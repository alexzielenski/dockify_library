//
//  DKTileLayer.m
//  Dockify
//
//  Created by Alexander Zielenski on 2/15/15.
//  Copyright (c) 2015 Alexander Zielenski. All rights reserved.
//

#import "Dockify.h"
#import <QuartzCore/QuartzCore.h>
#import "DOCKTileLayer.h"

ZKSwizzleInterface(DKTileLayer, DOCKTileLayer, CALayer)

@interface DKTileLayer (DOCKTileLayer)
@property(readonly, nonatomic) CALayer *labelLayer; // @synthesize labelLayer=_statusLabelLayer;
@end

@implementation DKTileLayer

- (void)layoutSublayers {
    ZKOrig(void);
    
    if (!Prefs(enabled)) {
        return;
    }

    DKTheme *currentTheme = Prefs(currentTheme);
    
    self.shadowOpacity = currentTheme.iconShadowColor.alphaComponent;
    self.shadowColor = [currentTheme.iconShadowColor colorWithAlphaComponent:1.0].CGColor;
    self.shadowRadius = currentTheme.iconShadowRadius;
    self.shadowOffset = currentTheme.iconShadowDirection;
    
    self.opacity = Prefs(currentTheme).iconOpacity;
}

- (float)opacity {
    if (!Prefs(enabled)) {
        return ZKOrig(float);
    }
    
    return Prefs(currentTheme).iconOpacity;
}

@end
