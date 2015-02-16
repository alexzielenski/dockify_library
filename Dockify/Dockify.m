//
//  Dockify.m
//  Dockify
//
//  Created by Alexander Zielenski on 2/15/15.
//  Copyright (c) 2015 Alexander Zielenski. All rights reserved.
//
#import "Dockify.h"
#import "DKFloorLayer.h"

DKTheme *currentTheme = nil;

__attribute__((__constructor__)) static void _DKInitialize() {
    DLog(@"loaded");
    currentTheme = [DKTheme themeWithContentsOfURL:[NSURL fileURLWithPath:@"/Users/Alex/Desktop/Dock.dockify"]];
    
    ZKSwizzle(DKFloorLayer, DOCKFloorLayer);
    
    DLog(@"initialized");
}
