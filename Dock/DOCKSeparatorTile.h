/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "Tile.h"

@interface DOCKSeparatorTile : Tile
{
    float _midPoint;
}

- (int)axSetAttributeValue:(struct __CFString *)arg1 value:(void *)arg2;
- (int)axIsAttributeSettable:(struct __CFString *)arg1 settable:(const struct __CFBoolean **)arg2;
- (int)axCopyAttributeValue:(struct __CFString *)arg1 value:(const void **)arg2;
- (struct __CFArray *)axCopyAttributeNames;
- (BOOL)dragDrop:(struct OpaqueCoreDrag *)arg1;
- (struct __CFDictionary *)copyInstallDictionary:(int)arg1;
- (BOOL)doAction:(unsigned int)arg1 fromKeyboard:(BOOL)arg2;
- (void)doCommand:(unsigned int)arg1;
- (struct OpaqueMenuRef *)createMenu:(void *)arg1 options:(int)arg2;
- (void)updateRect;
- (void)generateShadowsAndReflection;
- (BOOL)hasShadowsAndReflection;
- (BOOL)isRemovable;
- (id)init;

@end
