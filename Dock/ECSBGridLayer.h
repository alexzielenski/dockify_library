/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "ECGridLayer.h"

@class CALayer, NSMutableArray;

@interface ECSBGridLayer : ECGridLayer
{
    double _offset;
    struct _NSRange _lockedRange;
    unsigned long long _placeholderIndex;
    BOOL _faded;
    BOOL _centerSingleRow;
}

+ (void)calculateIconFrame:(struct CGRect *)arg1 itemBounds:(struct CGRect *)arg2 forBounds:(struct CGRect)arg3 andScaleFactor:(float)arg4 withNumberOfRows:(unsigned long long)arg5 andColumns:(unsigned long long)arg6;
+ (void)calculateIconSize:(unsigned long long *)arg1 miniIconSize:(unsigned long long *)arg2 forBounds:(struct CGRect)arg3 andScaleFactor:(float)arg4 withNumberOfRows:(unsigned long long)arg5 andColumns:(unsigned long long)arg6;
@property(nonatomic) BOOL centerSingleRow; // @synthesize centerSingleRow=_centerSingleRow;
@property(nonatomic) unsigned long long placeholderIndex; // @synthesize placeholderIndex=_placeholderIndex;
@property(nonatomic) struct _NSRange lockedRange; // @synthesize lockedRange=_lockedRange;
@property(nonatomic) double offset; // @synthesize offset=_offset;
- (void)reloadItemContentsWithDataSource:(id)arg1;
- (void)purgeItemContents;
- (unsigned long long)itemIndexWithFrame:(struct CGRect)arg1 relativeToItemIndex:(unsigned long long)arg2 usingHysteresis:(BOOL)arg3;
- (struct CGRect)frameForItemIndex:(unsigned long long)arg1;
- (void)removeItemLayer:(id)arg1;
- (void)moveItemLayer:(id)arg1 toIndex:(unsigned long long)arg2;
- (void)insertItemLayer:(id)arg1 atIndex:(unsigned long long)arg2;
- (void)addItemLayer:(id)arg1;
- (void)_layoutItemLayers;
@property(nonatomic) BOOL faded; // @dynamic faded;
@property(readonly, nonatomic) CALayer *itemsLayer; // @dynamic itemsLayer;
@property(readonly, nonatomic) NSMutableArray *itemLayers; // @dynamic itemLayers;
- (void)dealloc;
- (id)initWithLayerSource:(id)arg1 scaleFactor:(float)arg2;

@end

