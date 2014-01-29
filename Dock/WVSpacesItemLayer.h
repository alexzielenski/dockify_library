/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "CALayer.h"

#import "ECEventHandlingDelegate-Protocol.h"

@class ECShadowTextLayer, WVSpacesItem;

@interface WVSpacesItemLayer : CALayer <ECEventHandlingDelegate>
{
    WVSpacesItem *_item;
    struct CGRect _displayBounds;
    unsigned int _displayID;
    float _displayScale;
    struct CGRect _contentRect;
    CALayer *_badgeLayer;
    CALayer *_borderLayer;
    CALayer *_highlightLayer;
    CALayer *_closeBoxLayer;
    CALayer *_selectionLayer;
    ECShadowTextLayer *_titleLayer;
    double _titleMaxWidth;
    CALayer *_spaceLayer;
    CALayer *_windowsLayer;
    CALayer *_desktopLayer;
    BOOL _contentRectStale;
    BOOL _highlighted;
    BOOL _truncatedTitle;
}

+ (struct CGRect)spaceFrameForLayerFrame:(struct CGRect)arg1 withDisplayBounds:(struct CGRect)arg2;
+ (double)sizeForDisplayBounds:(struct CGRect)arg1;
+ (double)heightForDisplayBounds:(struct CGRect)arg1;
+ (double)labelHeight;
@property(nonatomic) BOOL highlighted; // @synthesize highlighted=_highlighted;
@property(readonly, nonatomic) CALayer *titleLayer; // @synthesize titleLayer=_titleLayer;
@property(retain, nonatomic) CALayer *highlightLayer; // @synthesize highlightLayer=_highlightLayer;
@property(retain, nonatomic) CALayer *selectionLayer; // @synthesize selectionLayer=_selectionLayer;
@property(retain, nonatomic) CALayer *closeBoxLayer; // @synthesize closeBoxLayer=_closeBoxLayer;
@property(readonly, nonatomic) CALayer *spaceLayer; // @synthesize spaceLayer=_spaceLayer;
@property(readonly, nonatomic) WVSpacesItem *item; // @synthesize item=_item;
- (id)_createDesktopLayerForFrame:(struct CGRect)arg1;
- (void)layoutSpaceWindows;
- (void)layout;
@property(readonly, nonatomic) struct CGRect contentRect;
- (void)removeTitleLayer;
- (void)updateTitleLayout;
- (void)updateTitle;
- (void)addTitleTruncated:(BOOL)arg1 withParentLayer:(id)arg2;
- (void)removeSelectionLayer;
- (void)updateSelectionLayout;
- (void)addSelectionWithParentLayer:(id)arg1;
- (void)removeCloseboxLayer;
- (void)updateCloseboxLayout;
- (void)setCloseBoxState:(BOOL)arg1;
- (void)addCloseboxWithParentLayer:(id)arg1;
- (void)removeAuxilaryLayers;
- (void)updateAuxilaryLayersLayout;
- (void)updateBackgroundImageCrossfade:(BOOL)arg1;
- (id)layersForWindows:(id)arg1;
@property(readonly, nonatomic) BOOL supportsClose; // @dynamic supportsClose;
- (void)dealloc;
- (id)initWithItem:(id)arg1 andDisplay:(id)arg2;

@end

