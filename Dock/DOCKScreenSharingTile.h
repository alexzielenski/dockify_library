/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "Tile.h"

#import "DOCKStackActionHandling-Protocol.h"
#import "DOCKStackCollapsedDataSource-Protocol.h"
#import "DOCKStackExpandedDataSource-Protocol.h"

@class DOCKStack, NSArray, NSMutableArray;

@interface DOCKScreenSharingTile : Tile <DOCKStackActionHandling, DOCKStackExpandedDataSource, DOCKStackCollapsedDataSource>
{
    DOCKStack *_stack;
    NSMutableArray *_items;
    unsigned char _viewAs;
    int _preferredItemSize;
    NSArray *_sortedTypeAheadArray;
    BOOL _ignoreNextDoAction;
    BOOL _onlyShowBackToMyMac;
    struct __NWBrowser *_browser;
}

@property(nonatomic) int preferredItemSize; // @synthesize preferredItemSize=_preferredItemSize;
@property(nonatomic) unsigned char viewAs; // @synthesize viewAs=_viewAs;
- (id)stack;
- (void)_browserCallback:(struct __NWBrowser *)arg1 node:(struct __NWNode *)arg2 protocol:(struct __CFString *)arg3 error:(int)arg4;
- (void)_itemsUpdated;
- (int)axCopyAttributeValue:(struct __CFString *)arg1 value:(const void **)arg2;
- (struct __CFArray *)axCopyAttributeNames;
- (id)expandedStackValueForKey:(id)arg1 withInfo:(id)arg2;
- (id)expandedStackValueForKey:(id)arg1 atIndex:(unsigned long long)arg2 withItemInfo:(id)arg3 maximumViewableItems:(unsigned long long)arg4;
- (id)collapsedStackValueForKey:(id)arg1 atIndex:(unsigned long long)arg2;
- (unsigned long long)numberOfExpandedStackItems;
- (unsigned long long)numberOfCollapsedStackItems;
- (void)showStackAsMenu:(BOOL)arg1;
- (void)endStackTypeAhead;
- (unsigned long long)indexForStackTypeAhead:(id)arg1;
- (void)beginStackTypeAhead:(id)arg1;
- (BOOL)performStackActionAtIndex:(unsigned long long)arg1 withEvent:(id)arg2 sender:(id)arg3;
- (BOOL)showMenu:(BOOL)arg1 options:(int)arg2;
- (void)spring:(unsigned int)arg1;
- (BOOL)doAction:(unsigned int)arg1 fromKeyboard:(BOOL)arg2;
- (void)doCommand:(unsigned int)arg1;
- (struct __CFDictionary *)copyInstallDictionary:(int)arg1;
- (struct OpaqueMenuRef *)createMenu:(void *)arg1 options:(int)arg2;
- (void *)copyTilePlist;
- (struct __CFString *)typeString;
- (BOOL)shouldInsetReflection;
- (void)collapseStack;
- (void)dealloc;
- (id)initWithPlist:(void *)arg1;
- (id)initWithBackToMyMac:(BOOL)arg1;

@end

