//
//  DKindicatorLayer.m
//  Dockify
//
//  Created by Alexander Zielenski on 3/31/15.
//  Copyright (c) 2015 Alexander Zielenski. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>
#import "ZKSwizzle.h"
#import "Dockify.h"

ZKSwizzleInterface(DKIndicatorLayer, DOCKIndicatorLayer, CALayer)
@implementation DKIndicatorLayer

- (void)updateIndicatorForSize:(float)arg1 {
    ZKOrig(void, arg1);
    self.backgroundColor = NSColor.clearColor.CGColor;
    self.cornerRadius = 0.0;
    
    DKDockSize size = DKDockSizeForIconSize(arg1);
    CGImageRef image = [currentTheme indicatorForSize:size
                                               retina:self.contentsScale == 2.0];
    self.contents = (__bridge id)image;
    self.contentsGravity = kCAGravityBottom;
    self.frame = CGRectMake(self.frame.origin.x, 0, (CGFloat)CGImageGetWidth(image) / self.contentsScale, (CGFloat)CGImageGetHeight(image) / self.contentsScale);
}

@end