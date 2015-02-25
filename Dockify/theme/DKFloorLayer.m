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

- (void)layoutSublayers {
    ZKOrig(void);
    if (!currentTheme)
        return;
    
//    CGFloat fH = frontline.frame.size.height;
    CGFloat h = self.bounds.size.height;
    CGFloat o  = offsetForHeight(h);
    CGFloat w  = self.bounds.size.width;
    
    self.glassLayer.contents = nil;
    self.separatorLayer.hidden = !currentTheme.showSeparator;
    
    ECMaterialLayer *material = self.materialLayer;
    material.contents = (__bridge id)([currentTheme scurveImageForSize:self.currentSize retina:YES]);
//    material.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, w, h);
    CATransform3D stretch = CATransform3DrectToQuad(self.bounds,
                                                    0, 0,
                                                    w + o, 0,
                                                    0, h,
                                                    w - o, h);
    self.transform = stretch;
    
    material.backgroundColor    = currentTheme.backgroundColor.CGColor;
    material.reduceTransparency = NO;
    material.blurRadius         = currentTheme.backgroundBlurRadius;
    material.cornerRadius       = currentTheme.borderRadius;
    
    self.borderColor                      = currentTheme.borderColor.CGColor;
    self.borderWidth                      = currentTheme.borderWidth;
    self.cornerRadius                     = currentTheme.borderRadius;
    self.shadowColor                      = currentTheme.shadowColor.CGColor;
    self.shadowOpacity                    = currentTheme.shadowColor.alphaComponent;
    self.shadowOffset                     = currentTheme.shadowDirection;
    self.shadowRadius                     = currentTheme.shadowRadius;
}

- (DKDockSize)currentSize {
    return DKDockSizeFromSize(self.materialLayer.frame.size);
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
    *&ZKHookIvar(self, CALayer *, "_separatorLayer") = separatorLayer;
}

- (void)setGlassLayer:(CALayer *)glassLayer {
    glassLayer.frame = self.glassLayer.frame;
    [self.glassLayer removeFromSuperlayer];
    [self addSublayer:glassLayer];
    *&ZKHookIvar(self, CALayer *, "_glassLayer") = glassLayer;
}

@end
