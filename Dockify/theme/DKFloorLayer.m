//
//  DKFloorLayer.m
//  Dockify
//
//  Created by Alexander Zielenski on 2/15/15.
//  Copyright (c) 2015 Alexander Zielenski. All rights reserved.
//

#import "Dockify.h"
#import "DKFloorLayer.h"
#import "DKNinePartFloorLayer.h"
#import "math.h"

@interface DKFloorLayer ()
@property (strong) DKNinePartFloorLayer *ninePartLayer;
- (void)layout3DDock;
- (void)layout2DDock;
@end

@implementation DKFloorLayer
@dynamic separatorLayer, glassLayer, materialLayer, orientation, ninePartLayer;

+ (void)load {
    ZKSwizzle(DKFloorLayer, Dock.FloorLayer);
}

- (void)layoutSublayers {
    ZKOrig(void);
    
    DKTheme *currentTheme = Prefs(currentTheme);
    DKThemeStyle currentStyle = Prefs(currentStyle);

    if (!currentTheme ||
        ![currentTheme supportsOrientation:ZKHookIvar(self, int, "orientation")] ||
        ![currentTheme supportsStyle:currentStyle] ||
        !Prefs(enabled))
        return;

    self.separatorLayer.hidden = !currentTheme.showSeparator;
    
    ECMaterialLayer *material = self.materialLayer;
    material.opacity            = 0.0;
    material.reduceTransparency = NO;
    material.blurRadius         = currentTheme.backgroundBlurRadius;
    
    /*
     BackdropLayer is what creates the blur behind the dock
     We don't want to apply the transform directly to it because that
     would warp the blurring, so, we make the backdrop layer big enough to
     hold the entire maskLayer, then apply the transform to the mask layer
     and shift the mask layer the appropriate amount of pixels to align with the
     glass layer.
     */

    CALayer *backdropLayer = ZKHookIvar(material, CALayer *, "_backdropLayer");
    
    // setting the blur radius to zero on the material has unwanted effects
    if (currentTheme.backgroundBlurRadius == 0.0) {
        backdropLayer.opacity = 0.0;
    }
    
    CALayer *maskLayer = backdropLayer.mask;
    
    backdropLayer.backgroundColor = NSColor.clearColor.CGColor;
    backdropLayer.contents        = nil;
    backdropLayer.borderColor     = backdropLayer.backgroundColor;
    backdropLayer.borderWidth     = 0.0;
    backdropLayer.shadowOpacity   = 0.0;
    backdropLayer.borderWidth     = 0.0;
    backdropLayer.shadowPath      = NULL;
    material.contents             = nil;
    
    if (![maskLayer.name isEqualToString:@"stretched"]) {
        maskLayer                 = [CALayer layer];
        maskLayer.name            = @"stretched";
        maskLayer.backgroundColor = NSColor.blackColor.CGColor;
        backdropLayer.mask        = maskLayer;
    }
    maskLayer.anchorPoint     = CGPointZero;
    backdropLayer.anchorPoint = CGPointZero;
    
    [self layout2DDock];
    [self layout3DDock];

    // Make sure glass is in front of backdrop layer
    [self addSublayer:backdropLayer];
    [self addSublayer:self.glassLayer];
    [self addSublayer:self.separatorLayer];
}

- (void)layout2DDock {
    DKTheme *currentTheme = Prefs(currentTheme);
    DKThemeStyle currentStyle = Prefs(currentStyle);
    if (currentStyle != DKTheme2DStyle)
        return;
    
    if (!self.ninePartLayer) {
        self.ninePartLayer = [DKNinePartFloorLayer layer];
        [self.glassLayer addSublayer:self.ninePartLayer];
    }
    self.ninePartLayer.opacity = 1.0;
    self.ninePartLayer.orientation = self.orientation;
    
    CGRect ninePartRect = self.glassLayer.bounds;
    CGFloat inset = 40.0;
    ninePartRect.origin.x += inset / 2 + 20;
    ninePartRect.size.width -= inset + 40;
    ninePartRect.size.height -= inset;
    self.ninePartLayer.frame = ninePartRect;
    
    ECMaterialLayer *material = self.materialLayer;
    CALayer *backdropLayer = ZKHookIvar(material, CALayer *, "_backdropLayer");
    backdropLayer.frame = self.glassLayer.bounds;

    if (![backdropLayer.mask.name isEqualToString:@"2d-mask"]) {
        backdropLayer.mask = [DKNinePartFloorLayer layer];
        backdropLayer.mask.name = @"2d-mask";
        backdropLayer.mask.transform = CATransform3DIdentity;
    }
    backdropLayer.mask.backgroundColor = NSColor.blackColor.CGColor;
    backdropLayer.mask.frame = self.bounds;
    
    for (DKFlatPart part = DKFlatPartTopLeft; part <= DKFlatPartBottomRight; part++) {
        [self.ninePartLayer setImage:[currentTheme flatBackgroundImageForPart:part retina:self.contentsScale == 2.0] forPart:part];
        [(DKNinePartFloorLayer *)backdropLayer.mask setImage:[currentTheme flatBackgroundImageForPart:part retina:self.contentsScale == 2.0] forPart:part];
    }
}
- (void)layout3DDock {
    DKTheme *currentTheme = Prefs(currentTheme);
    DKThemeStyle currentStyle = Prefs(currentStyle);

    if (currentStyle != DKTheme3DStyle)
        return;
    
    
    ECMaterialLayer *material = self.materialLayer;
    CALayer *glass = self.glassLayer;
    self.ninePartLayer.opacity = 0.0;

    //    CGFloat fH = frontline.frame.size.height;
    CGFloat h = self.bounds.size.height;
    CGFloat o  = offsetForHeight(h);
    CGFloat w  = self.bounds.size.width;
    // remove dark/light background from material
    CALayer *backdropLayer = ZKHookIvar(material, CALayer *, "_backdropLayer");
    CGRect frameRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, w, h);
    glass.frame = frameRect;
    CATransform3D stretch = CATransform3DrectToQuad(frameRect,
                                                    -o, 0,
                                                    w + o, 0,
                                                    0, h,
                                                    w, h);
//    glass.contentsGravity = kCAGravityResize;
    glass.anchorPoint     = CGPointZero;
    glass.transform       = stretch;
    glass.backgroundColor = [currentTheme.backgroundColor colorWithAlphaComponent:0.25].CGColor;
    glass.cornerRadius    = currentTheme.borderRadius;
    glass.contents        = (__bridge id)([currentTheme scurveImageForSize:self.currentSize retina:self.contentsScale == 2.0]);
    
    glass.borderColor   = currentTheme.borderColor.CGColor;
    glass.borderWidth   = currentTheme.borderWidth;
    glass.cornerRadius  = self.bounds.size.height * 0.0;//currentTheme.borderRadius;
    
    self.shadowColor   = currentTheme.shadowColor.CGColor;
    self.shadowOpacity = currentTheme.shadowColor.alphaComponent;
    self.shadowOffset  = currentTheme.shadowDirection;
    self.shadowRadius  = currentTheme.shadowRadius;
    
    CALayer *maskLayer  = backdropLayer.mask;
    CGRect maskRect     = frameRect;
    maskRect.origin.x   += o;
    maskLayer.transform = stretch;
    maskLayer.frame     = maskRect;

    backdropLayer.frame = CGRectInset(frameRect, -o, 0);
}

- (DKDockSize)currentSize {
    return DKDockSizeFromSize(self.glassLayer.frame.size);
}

- (void)updateFrame:(CGRect)arg1 {
    if (Prefs(currentStyle) == DKTheme3DStyle) {
        arg1.size.height *= 0.63;
    }
    
    ZKOrig(void, arg1);
}

#pragma mark - Properties

- (DKNinePartFloorLayer *)ninePartLayer {
    return objc_getAssociatedObject(self, @selector(ninePartLayer));
}

- (void)setNinePartLayer:(DKNinePartFloorLayer *)ninePartLayer {
    [self willChangeValueForKey:@"ninePartLayer"];
    objc_setAssociatedObject(self, @selector(ninePartLayer), ninePartLayer, OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey:@"ninePartLayer"];
}

- (DKDockOrientation)orientation {
    return ZKHookIvar(self, DKDockOrientation, "_orientation");
}

- (ECMaterialLayer *)materialLayer {
    return ZKHookIvar(self, ECMaterialLayer *, "_materialLayer");
}

- (CALayer *)separatorLayer {
    return ZKHookIvar(self, CALayer *, "_separatorLayer");
}

- (CALayer *)glassLayer {
    return ZKHookIvar(self, CALayer *, "_glassLayer");
}

- (void)setSeparatorLayer:(CALayer *)separatorLayer {
    separatorLayer.frame = self.separatorLayer.frame;
    [self.separatorLayer removeFromSuperlayer];
    [self addSublayer:separatorLayer];
    ZKHookIvar(self, CALayer *, "_separatorLayer") = separatorLayer;
}

- (void)setGlassLayer:(CALayer *)glassLayer {
    glassLayer.frame = self.glassLayer.frame;
    [self.glassLayer removeFromSuperlayer];
    [self addSublayer:glassLayer];
    ZKHookIvar(self, CALayer *, "_glassLayer") = glassLayer;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wmismatched-parameter-types"
- (void)setOrientation:(int)orientation {
#pragma clang diagnostic pop
    ZKOrig(void, orientation);
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
