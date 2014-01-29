#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#import "Dock/DOCKGlassFloorLayer.h"
#import "Dock/DOCKReflectionLayer.h"
#import "Dock/ECMultiScaleImageCache.h"
#import "Dock/ECMultiScaleImage.h"

#import "CGSInternal/CGSConnection.h"

#include <objc/runtime.h>

%config(generator=internal)

template <typename Type_>
static inline Type_ &MSHookIvar(id self, const char *name) {
    Ivar ivar(class_getInstanceVariable(object_getClass(self), name));
    void *pointer(ivar == NULL ? NULL : reinterpret_cast<char *>(self) + ivar_getOffset(ivar));
    return *reinterpret_cast<Type_ *>(pointer);
}

#define DLog(fmt, ...) NSLog((@"dockify: " fmt),  ##__VA_ARGS__)
#define D(fmt) DLog(@"%@", fmt)

#define INFO_RELECTION_KEY @"reflectionOpacity"
#define INFO_SHOW_FRONTLINE_KEY @"showFrontline"

static NSArray *wantedImages = nil;
static NSBundle *dockBundle = nil;
static NSDictionary *options = nil;
static BOOL enabled = YES;
static float scale = 1.0f;

CG_EXTERN int CGSSetMagicMirror(int, int, CGRect, int, int, int, int);

CATransform3D CATransform3DrectToQuad(CGRect rect, CGFloat x1a, CGFloat y1a, CGFloat x2a, CGFloat y2a, CGFloat x3a, CGFloat y3a, CGFloat x4a, CGFloat y4a) {
	CGFloat X = rect.origin.x;
	CGFloat Y = rect.origin.y;
	CGFloat W = rect.size.width;
	CGFloat H = rect.size.height;
	
	CGFloat y21 = y2a - y1a;
	CGFloat y32 = y3a - y2a;
	CGFloat y43 = y4a - y3a;
	CGFloat y14 = y1a - y4a;
	CGFloat y31 = y3a - y1a;
	CGFloat y42 = y4a - y2a;

	CGFloat a = -H*(x2a*x3a*y14 + x2a*x4a*y31 - x1a*x4a*y32 + x1a*x3a*y42);
	CGFloat b = W*(x2a*x3a*y14 + x3a*x4a*y21 + x1a*x4a*y32 + x1a*x2a*y43);
	CGFloat c = H*X*(x2a*x3a*y14 + x2a*x4a*y31 - x1a*x4a*y32 + x1a*x3a*y42) - H*W*x1a*(x4a*y32 - x3a*y42 + x2a*y43) - W*Y*(x2a*x3a*y14 + x3a*x4a*y21 + x1a*x4a*y32 + x1a*x2a*y43);

	CGFloat d = H*(-x4a*y21*y3a + x2a*y1a*y43 - x1a*y2a*y43 - x3a*y1a*y4a + x3a*y2a*y4a);
	CGFloat e = W*(x4a*y2a*y31 - x3a*y1a*y42 - x2a*y31*y4a + x1a*y3a*y42);
	CGFloat f = -(W*(x4a*(Y*y2a*y31 + H*y1a*y32) - x3a*(H + Y)*y1a*y42 + H*x2a*y1a*y43 + x2a*Y*(y1a - y3a)*y4a + x1a*Y*y3a*(-y2a + y4a)) - H*X*(x4a*y21*y3a - x2a*y1a*y43 + x3a*(y1a - y2a)*y4a + x1a*y2a*(-y3a + y4a)));

	CGFloat g = H*(x3a*y21 - x4a*y21 + (-x1a + x2a)*y43);
	CGFloat h = W*(-x2a*y31 + x4a*y31 + (x1a - x3a)*y42);
	CGFloat i = W*Y*(x2a*y31 - x4a*y31 - x1a*y42 + x3a*y42) + H*(X*(-(x3a*y21) + x4a*y21 + x1a*y43 - x2a*y43) + W*(-(x3a*y2a) + x4a*y2a + x2a*y3a - x4a*y3a - x2a*y4a + x3a*y4a));

	if(fabs(i) < 0.00001)
	{
		i = 0.00001;
	}

	CATransform3D t = CATransform3DIdentity;

	t.m11 = a / i;
	t.m12 = d / i;
	t.m13 = 0;
	t.m14 = g / i;
	t.m21 = b / i;
	t.m22 = e / i;
	t.m23 = 0;
	t.m24 = h / i;
	t.m31 = 0;
	t.m32 = 0;
	t.m33 = 1;
	t.m34 = 0;
	t.m41 = c / i;
	t.m42 = f / i;
	t.m43 = 0;
	t.m44 = i / i;

	return t;
}

CATransform3D rectToQuad(CGRect rect, CGPoint topLeft, CGPoint topRight, CGPoint bottomLeft, CGPoint bottomRight) {
	return CATransform3DrectToQuad(rect, topLeft.x, topLeft.y, topRight.x, topRight.y, bottomLeft.x, bottomLeft.y, bottomRight.x, bottomRight.y);
}

CGFloat offsetForHeight(CGFloat h) {
	static CGFloat minOffset = 12.0;
	static CGFloat minHeight = 17.0;
	static CGFloat offStep   = 0.5;
	
	CGFloat oHeight = h - minHeight;
	CGFloat z = ceil(oHeight * offStep);
	return minOffset + z;
}

NSUInteger repForSize(CGSize size) {
	static CGSize sm = CGSizeMake(900, 128);
	static CGSize m  = CGSizeMake(1280, 128);
	static CGSize l  = CGSizeMake(1280, 98);
	static CGSize xl = CGSizeMake(1280, 86);
	
	// CGFloat smDH = abs(size.height - sm.height);
	CGFloat mDH  = abs(size.height - m.height);
	CGFloat lDH  = abs(size.height - l.height);
	CGFloat xlDH  = abs(size.height - xl.height);

	CGFloat smDW = abs(size.width- sm.width);
	CGFloat mDW  = abs(size.width - m.width);
	// CGFloat lDW  = abs(size.width - l.width);
	// CGFloat xlDW  = abs(size.width - xl.width);

	if (smDW < mDW) {
		return 0;
	}

	if (mDH < lDH)
		return 1;
	if (lDH < xlDH)
		return 2;

	return 3;
}

NSString *nameForSize(NSUInteger rep) {
	NSString *const prefix = @"scurve-";
	NSString *suffix = @"";
	switch (rep) {
		case 0:
			suffix = @"sm";
			break;
		case 1:
			suffix = @"m";
			break;
		case 2:
			suffix = @"l";
			break;
		default:
			suffix = @"xl";
			break;
	}
	return [prefix stringByAppendingString: suffix];
}


CGImageRef scurveForSize(CGSize size) {
	NSUInteger rep = repForSize(size);
	NSString *name = nameForSize(rep);

	// return [NSImage imageNamed: name];
	return [%c(ECMultiScaleImageCache) sharedImageWithName: name andScaleFactor: scale removingOtherScaleFactors: YES];
}

CGImageRef frontlineImage() {
	return [%c(ECMultiScaleImageCache) sharedImageWithName: @"frontline" andScaleFactor: scale removingOtherScaleFactors: YES];
}

%hook DOCKReflectionLayer

- (void)setHidden:(BOOL)h {
	if (enabled) {
		%orig(YES);
	} else {
		%orig;
	}
}

- (BOOL)isHidden {
	if (enabled)
		return YES;
	return %orig;
}

- (void)layoutSublayers {
	%orig;

	if (!enabled)
		return;

	CALayer **imLayer = &MSHookIvar<CALayer *>(self, "_imageLayer");
	NSNumber *reflection = [options objectForKey: INFO_RELECTION_KEY];
	if (reflection)
		[*imLayer setOpacity: [reflection doubleValue]];
}

%end

@interface DOCKGlassFloorLayer (dockify)
- (CALayer *)dk_frontline;
- (CALayer *)dk_background;
- (CALayer *)dk_mask;
- (void)dk_setFrontline:(CALayer *)layer;
- (void)dk_setMask:(CALayer *)layer;
- (void)dk_setBackground:(CALayer *)layer;
@end

%hook DOCKGlassFloorLayer

- (void)updateFrame:(CGRect)arg1 iconOffset:(int)arg2 {
	if (enabled) {
		_Bool *dontShowMirror = &MSHookIvar<_Bool>(self, "_dontEverShowMirror");
		*dontShowMirror = true;

		// Remove any previous magic mirror
		CGSSetMagicMirror(CGSMainConnectionID(), 0, CGRectZero, 0, 0, 0, 0);
	}

	// Call the original implementation
	%orig(arg1, arg2);
	
	if (!enabled)
		return;

	// Configure frontline
	CALayer *frontline = self.dk_frontline;
	CGImageRef fli = frontlineImage();

	if (!frontline) {
		frontline             = [CALayer layer];
		frontline.anchorPoint = CGPointZero;
		frontline.frame       = CGRectMake(0, 0, CGImageGetWidth(fli), CGImageGetHeight(fli));
		frontline.zPosition   = 1.0; 
		[self addSublayer: frontline];

		[self dk_setFrontline: frontline];
	}

	// Make the frontline frame 0 if it is disabled
	if (![[options objectForKey: INFO_SHOW_FRONTLINE_KEY] boolValue]) {
		frontline.frame = CGRectZero;
	}

	CGFloat fH = frontline.frame.size.height;
	CGFloat iH = arg1.size.height;
	CGFloat h  = fH + iH;
	CGFloat w  = self.frame.size.width;
	CGFloat o  = offsetForHeight(h);
	CATransform3D stretch = rectToQuad(CGRectMake(0, 0, w, h), CGPointMake(0, 0), CGPointMake(w, 0), CGPointMake(o, h), CGPointMake(w - o, h));

	frontline.contents = (id)fli;
	frontline.frame    = CGRectMake(self.bounds.origin.x, self.frame.origin.y, w, fH);	

	CALayer *mask = self.dk_mask;
	
	if (!mask) {
		mask = [CALayer layer];
		mask.anchorPoint = CGPointZero;
		mask.backgroundColor = CGColorGetConstantColor(kCGColorBlack);
		frontline.mask = mask;

		[self dk_setMask: mask];
	}

	CALayer *l = self.dk_background;

	if (!l) {
		l = [CALayer layer];
		l.anchorPoint = CGPointZero;
		[self addSublayer: l];
	
		[self dk_setBackground: l];
	}
	
	mask.transform = stretch;
	mask.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, w, h);

	l.transform = stretch;
	l.contents = (id)scurveForSize(CGSizeMake(w, iH));
	l.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, w, h);

	// Move the separator to the top
	CALayer **separatorLayer = &MSHookIvar<CALayer *>(self, "_separatorLayer");
	[self addSublayer: *separatorLayer];
}

- (BOOL)mirrorOn {
	if (enabled)
		return false;
	return %orig;
}

%new
- (CALayer *)dk_frontline {
	return objc_getAssociatedObject(self, @selector(dk_frontline));
}

%new
- (CALayer *)dk_background {
	return objc_getAssociatedObject(self, @selector(dk_background));
}

%new
- (CALayer *)dk_mask {
	return objc_getAssociatedObject(self, @selector(dk_mask));
}

%new
- (void)dk_setFrontline:(CALayer *)layer {
	objc_setAssociatedObject(self, @selector(dk_frontline), layer, OBJC_ASSOCIATION_RETAIN);
}

%new
- (void)dk_setBackground:(CALayer *)layer {
	objc_setAssociatedObject(self, @selector(dk_background), layer, OBJC_ASSOCIATION_RETAIN);
}

%new
- (void)dk_setMask:(CALayer *)layer {
	objc_setAssociatedObject(self, @selector(dk_mask), layer, OBJC_ASSOCIATION_RETAIN);
}

%end

%hook ECMultiScaleImage

- (id)initWithName:(NSString *)arg1 inBundle:(NSBundle *)arg2 usingScaleFactor:(float)arg3 {
	if ([wantedImages indexOfObject: arg1] != NSNotFound && enabled) {
		return %orig(arg1, dockBundle, arg3);
	}

	scale = arg3;
	return %orig;
}

%end

%ctor {
	DLog(@"Loaded");

	// Get the file paths for our Dockify folder in app support
	// and set the dockBundle equal to it
	NSFileManager *manager = [NSFileManager defaultManager];
	NSArray *appSupportDirs = [manager URLsForDirectory: NSApplicationSupportDirectory inDomains: NSUserDomainMask];
	NSString *appSupport = [[appSupportDirs[0] path] stringByAppendingPathComponent: @"Dockify"];

	NSString *prefsPath = [appSupport stringByAppendingPathComponent:@"com.alexzielenski.dockify.plist"];
	NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile: prefsPath];
	dockBundle = [NSBundle bundleWithPath:[appSupport stringByAppendingPathComponent:[prefs objectForKey: @"theme"]]];

	// Add every image in the theme directory to watched images
	// so whenever a cache request is made for one we are ready
	// this is very dynamic and offers a range of possibilites
	// not limited to replacing just the dock window's images
	NSMutableArray *ar = [NSMutableArray array];
	for (NSString *name in [manager contentsOfDirectoryAtPath: dockBundle.bundlePath error: nil]) {
		[ar addObject: [name stringByDeletingPathExtension]];
	}

	wantedImages = [[ar copy] autorelease];

	NSNumber *enabledObject = [prefs objectForKey: @"enabled"];
	enabled = (enabledObject.boolValue && (dockBundle != nil));

	// Read info.plist
	NSString *infoPath = nil;
	if ((infoPath = [dockBundle pathForResource: @"Info" ofType: @"plist"])) {
		options = [NSDictionary dictionaryWithContentsOfFile: infoPath];
	}

	// Remove any previous magic mirror
	CGSSetMagicMirror(CGSMainConnectionID(), 0, CGRectZero, 0, 0, 0, 0);

	%init;
}