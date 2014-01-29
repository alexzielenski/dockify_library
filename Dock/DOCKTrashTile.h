/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "Tile.h"

@interface DOCKTrashTile : Tile
{
    BOOL _trashFull;
    struct __CFString *_trashString;
}

@property(readonly, nonatomic) struct __CFString *trashString; // @synthesize trashString=_trashString;
- (int)axCopyAttributeValue:(struct __CFString *)arg1 value:(const void **)arg2;
- (struct __CFArray *)axCopyAttributeNames;
- (BOOL)isRemovable;
- (BOOL)dragDrop:(struct OpaqueCoreDrag *)arg1;
- (void)dragLeave:(struct OpaqueCoreDrag *)arg1;
- (void)dragEnter:(struct OpaqueCoreDrag *)arg1;
- (void)resetTrashIcon;
- (void)changeState:(BOOL)arg1;
- (void)render;
- (struct __CFDictionary *)copyInstallDictionary:(int)arg1;
- (void)setRepacementImage:(struct CGImage *)arg1;
- (void)doCommand:(unsigned int)arg1;
- (struct OpaqueMenuRef *)createMenu:(void *)arg1 options:(int)arg2;
- (void)spring:(unsigned int)arg1;
- (void)open;
- (BOOL)doAction:(unsigned int)arg1 fromKeyboard:(BOOL)arg2;
- (void)dealloc;
- (id)init;

@end

