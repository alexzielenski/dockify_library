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
@implementation DKTileLayer

- (void)layoutSublayers {
    ZKOrig(void);
    
    if (!Prefs(enabled)) {
        return;
    }
    self.opacity = Prefs(currentTheme).iconOpacity;
}

- (float)opacity {
    if (!Prefs(enabled)) {
        return ZKOrig(float);
    }
    
    return Prefs(currentTheme).iconOpacity;
}

@end
