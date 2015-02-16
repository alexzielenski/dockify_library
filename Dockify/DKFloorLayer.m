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
- (id)initWithOrientation:(int)arg1 hasSeparator:(_Bool)arg2 {
    return ZKOrig(id, 0,  currentTheme.showSeparator);
}

- (void)layoutSublayers {
    ZKOrig(void);

//    self.glassLayer.hidden = YES;
    self.materialLayer.hidden = YES;
    
    self.backgroundColor = currentTheme.backgroundColor.CGColor;
    self.borderColor = currentTheme.borderColor.CGColor;
    self.borderWidth = currentTheme.borderWidth;
    self.cornerRadius = currentTheme.borderRadius;
}

#pragma mark - Properties

- (CALayer *)materialLayer {
    return ZKHookIvar(self, CALayer *, "_materialLayer");
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
