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
    
//    self.glassLayer.hidden = YES;
    self.separatorLayer.hidden = !currentTheme.showSeparator;
//    self.materialLayer.hidden = NO;
    self.materialLayer.backgroundColor = currentTheme.backgroundColor.CGColor;
    self.materialLayer.reduceTransparency = NO;
    self.materialLayer.blurRadius = currentTheme.backgroundBlurRadius;
    
//    self.backgroundColor = currentTheme.backgroundColor.CGColor;
    self.borderColor = currentTheme.borderColor.CGColor;
    self.borderWidth = currentTheme.borderWidth;
    self.cornerRadius = currentTheme.borderRadius;
    self.shadowColor = currentTheme.shadowColor.CGColor;
    self.shadowOpacity = currentTheme.shadowColor.alphaComponent;
    self.shadowOffset = currentTheme.shadowDirection;
    self.shadowRadius = currentTheme.shadowRadius;
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