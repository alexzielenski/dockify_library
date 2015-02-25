//
//  Dockify.m
//  Dockify
//
//  Created by Alexander Zielenski on 2/15/15.
//  Copyright (c) 2015 Alexander Zielenski. All rights reserved.
//
#import "Dockify.h"

#import "DKFloorLayer.h"
#import "DKTileLayer.h"

DKTheme *currentTheme = nil;
//!TODO: load this from prefs somewhere
DKThemeStyle currentStyle = DKTheme3DStyle;

static BOOL loaded = NO;

@interface Dockify : NSObject
@end

// Opee support
__attribute__((__constructor__)) static void _DKInitialize() {
    [Dockify load];
}


// SIMBL support
@implementation Dockify

+ (void)load {
    if (loaded)
        return;
    
    DLog(@"%ld, %ld", LONG_MAX, LONG_MIN);
    
    loaded = YES;
    DLog(@"loaded");
    currentTheme = [DKTheme themeWithContentsOfURL:[NSURL fileURLWithPath:@"/Users/Alex/Desktop/Dock.dockify"]];
    
    ZKSwizzle(DKFloorLayer, DOCKFloorLayer);
    ZKSwizzle(DKTileLayer, DOCKTileLayer);
    
    DLog(@"initialized");
}

@end