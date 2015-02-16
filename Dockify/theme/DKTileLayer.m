//
//  DKTileLayer.m
//  Dockify
//
//  Created by Alexander Zielenski on 2/15/15.
//  Copyright (c) 2015 Alexander Zielenski. All rights reserved.
//

#import "DKTileLayer.h"
#import "Dockify.h"

@implementation DKTileLayer

- (void)layoutSublayers {
    self.opacity = currentTheme.iconOpacity;
}

- (float)opacity {
    return currentTheme.iconOpacity;
}

@end
