/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSObject.h"

#import "ECEventHandling-Protocol.h"
#import "ECEventHandlingDelegate-Protocol.h"
#import "ECKeyboardNavigating-Protocol.h"
#import "ECLayerSource-Protocol.h"

@class ECCoverFlowItemLayer, ECCoverFlowLayer, ECTooltipLayer, NSObject<OS_dispatch_source>;

@interface ECCoverFlow : NSObject <ECLayerSource, ECEventHandling, ECEventHandlingDelegate, ECKeyboardNavigating>
{
    ECCoverFlowLayer *_layer;
    id <ECCoverFlowDataSource><ECCoverFlowActionHandling> _handler;
    ECTooltipLayer *_tooltipLayer;
    ECCoverFlowItemLayer *_expandedItemLayer;
    Class _itemLayerClass;
    unsigned long long _selectedIndex;
    NSObject<OS_dispatch_source> *_springTimer;
    float _scaleFactor;
}

@property(nonatomic) float scaleFactor; // @synthesize scaleFactor=_scaleFactor;
@property(nonatomic) unsigned long long selectedIndex; // @synthesize selectedIndex=_selectedIndex;
@property(nonatomic) Class itemLayerClass; // @synthesize itemLayerClass=_itemLayerClass;
@property(nonatomic) id <ECCoverFlowDataSource><ECCoverFlowActionHandling> handler; // @synthesize handler=_handler;
@property(readonly, nonatomic) ECCoverFlowLayer *layer; // @synthesize layer=_layer;
- (BOOL)navigate:(int)arg1 withEvent:(id)arg2;
- (BOOL)gesture:(id)arg1 inLayer:(id)arg2;
- (BOOL)scrollWheel:(id)arg1 inLayer:(id)arg2;
- (BOOL)keyDown:(id)arg1;
- (BOOL)leftMouseDraggedExited:(id)arg1 inLayer:(id)arg2;
- (BOOL)leftMouseDraggedEntered:(id)arg1 inLayer:(id)arg2;
- (BOOL)mouseExited:(id)arg1 inLayer:(id)arg2;
- (BOOL)mouseEntered:(id)arg1 inLayer:(id)arg2;
- (BOOL)leftMouseUp:(id)arg1 inLayer:(id)arg2;
- (BOOL)leftMouseDown:(id)arg1 inLayer:(id)arg2;
- (void)invalidate;
- (void)layout;
- (void)scroll:(int)arg1;
- (void)scrollToIndex:(unsigned long long)arg1;
- (unsigned long long)indexOfItemLayer:(id)arg1;
- (id)itemLayerAtIndex:(unsigned long long)arg1;
- (void)setContentInLayers:(id)arg1 withDataRange:(struct _NSRange)arg2 forLayer:(id)arg3 usingScaleFactor:(float)arg4;
- (id)makeLayerForLayer:(id)arg1;
- (unsigned long long)numberOfItemsForLayer:(id)arg1;
@property(nonatomic) BOOL pageScrolling; // @dynamic pageScrolling;
@property(readonly, nonatomic) struct _NSRange visibleItemRange; // @dynamic visibleItemRange;
@property(nonatomic) unsigned long long numberOfVisibleItems; // @dynamic numberOfVisibleItems;
@property(nonatomic) unsigned long long numberOfOverflowItems; // @dynamic numberOfOverflowItems;
@property(nonatomic) unsigned long long scrolledIndex; // @dynamic scrolledIndex;
- (void)_collapseTextOfItemLayer:(id)arg1;
- (void)_removeTooltipLayer;
- (void)_expandTextOfItemLayer:(id)arg1;
- (BOOL)_canExpandTextOfItemLayer:(id)arg1;
- (void)dealloc;
- (id)initWithHandler:(id)arg1 numberOfOverflowItems:(unsigned long long)arg2 scaleFactor:(float)arg3;
- (id)initWithHandler:(id)arg1 scaleFactor:(float)arg2;

@end

