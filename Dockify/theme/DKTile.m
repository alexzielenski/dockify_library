//
//  DKTile.m
//  Dockify
//
//  Created by Alexander Zielenski on 7/23/15.
//  Copyright © 2015 Alexander Zielenski. All rights reserved.
//

#import "Tile.h"
#import "ZKSwizzle.h"
#import "DKPrefs.h"

ZKSwizzleInterface(DKTile, Tile, NSObject)
@implementation DKTile

- (void)setGlobalFrame:(struct FloatRect)arg1 {
    if (Prefs(currentStyle) == DKTheme3DStyle) {
        CGFloat height = (CGFloat)labs((NSInteger)arg1.top - (NSInteger)arg1.bottom);
        arg1.bottom -= height * 0.1;
        arg1.top -= height * 0.1;
    }
    
    ZKOrig(void, arg1);
}

@end
