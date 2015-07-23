//
//  Dockify.m
//  Dockify
//
//  Created by Alexander Zielenski on 2/15/15.
//  Copyright (c) 2015 Alexander Zielenski. All rights reserved.
//
#import "Dockify.h"

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
    
    loaded = YES;
    DLog(@"loaded");
        
    Prefs(currentStyle) = DKTheme3DStyle;
    Prefs(currentTheme) = [DKTheme themeWithContentsOfURL:[NSURL fileURLWithPath:[@"~/Desktop/Dock.dockify" stringByExpandingTildeInPath]]];
    Prefs(enabled) = YES;
    
    DLog(@"initialized");
}

@end