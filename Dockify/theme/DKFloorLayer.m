//
//  DKFloorLayer.m
//  Dockify
//
//  Created by Alexander Zielenski on 2/15/15.
//  Copyright (c) 2015 Alexander Zielenski. All rights reserved.
//

#import "Dockify.h"
#import "DKFloorLayer.h"

@implementation DKFloorLayer
@dynamic separatorLayer, glassLayer, materialLayer;

+ (void)load {    
    ZKSwizzle(self, DOCKFloorLayer);
}

- (void)layoutSublayers {
    ZKOrig(void);
    
    if (!currentTheme)
        return;
    
//    CGFloat fH = frontline.frame.size.height;
    CGFloat h = self.bounds.size.height;
    CGFloat o  = offsetForHeight(h);
    CGFloat w  = self.bounds.size.width;
    
    ECMaterialLayer *material = self.materialLayer;
    ((CALayer *)material).opacity = 0.0;
    
    CALayer *glass = self.glassLayer;
    
    // remove dark/light background from material
    CALayer *backdropLayer = ZKHookIvar(material, CALayer *, "_backdropLayer");
    backdropLayer.backgroundColor = NSColor.clearColor.CGColor;
    backdropLayer.contents        = nil;
    backdropLayer.borderColor     = backdropLayer.backgroundColor;
    backdropLayer.shadowOpacity   = 0.0;
    backdropLayer.borderWidth     = 0.0;
    backdropLayer.shadowPath      = NULL;
    material.contents             = nil;
    
//    self.separatorLayer.hidden = !currentTheme.showSeparator;
    self.separatorLayer.backgroundColor = NSColor.blueColor.CGColor;
    CGRect sepFrame = self.separatorLayer.frame;
    sepFrame.origin.x -= 50;
    sepFrame.size.width += 100;
    self.separatorLayer.frame = sepFrame;
    
    CGRect frameRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, w, h);
    glass.frame = frameRect;
    CATransform3D stretch = CATransform3DrectToQuad(frameRect,
                                                    -o, 0,
                                                    w + o, 0,
                                                    0, h,
                                                    w, h);
    glass.contentsGravity = kCAGravityResize;
    glass.anchorPoint     = CGPointZero;
    glass.transform       = stretch;
    glass.backgroundColor = [currentTheme.backgroundColor colorWithAlphaComponent:0.25].CGColor;
    glass.cornerRadius    = currentTheme.borderRadius;
    glass.contents        = (__bridge id)([currentTheme scurveImageForSize:self.currentSize retina:YES]);

    glass.borderColor   = currentTheme.borderColor.CGColor;
    glass.borderWidth   = currentTheme.borderWidth;
    glass.cornerRadius  = self.bounds.size.height * 0.0;//currentTheme.borderRadius;
    
    self.shadowColor   = currentTheme.shadowColor.CGColor;
    self.shadowOpacity = currentTheme.shadowColor.alphaComponent;
    self.shadowOffset  = currentTheme.shadowDirection;
    self.shadowRadius  = currentTheme.shadowRadius;

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
    CALayer *maskLayer = backdropLayer.mask;
    if (![maskLayer.name isEqualToString:@"stretched"]) {
        maskLayer = [CALayer layer];
        maskLayer.name = @"stretched";
        maskLayer.backgroundColor = NSColor.blackColor.CGColor;
        backdropLayer.mask = maskLayer;
    }
    CGRect maskRect = frameRect;
    maskRect.origin.x += o;

    maskLayer.transform = stretch;
    maskLayer.frame = maskRect;
    maskLayer.anchorPoint = CGPointZero;

    backdropLayer.anchorPoint = CGPointZero;
    backdropLayer.frame = CGRectInset(frameRect, -o, 0);
    
    // Make sure glass is in front of backdrop layer
    [self addSublayer:backdropLayer];
    [self addSublayer:glass];
    [self addSublayer:self.separatorLayer];
    
    NSLog(@"%@", [NSApp windows]);
}

- (DKDockSize)currentSize {
    return DKDockSizeFromSize(self.glassLayer.frame.size);
}

#pragma mark - Properties

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

@end
