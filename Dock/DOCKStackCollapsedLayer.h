/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "DOCKStackLayer.h"

@interface DOCKStackCollapsedLayer : DOCKStackLayer
{
}

- (void)layerSourceInvalidated:(id)arg1 forRange:(struct _NSRange)arg2;
- (void)layerSourceInvalidated:(id)arg1;
- (id)itemLayersForRange:(struct _NSRange)arg1;
- (id)itemLayerForIndex:(unsigned long long)arg1;
- (struct _NSRange)actualItemRange;
- (struct _NSRange)visibleItemRange;
- (void)getLayoutFrames:(struct CGRect *)arg1 count:(unsigned long long)arg2;
- (id)imagesForShadowAndReflection;
- (void)layoutSublayers;
- (void)_removeLayers;
- (void)_layoutLayers;
- (void)_createLayers;
- (void)dealloc;
- (id)initWithStack:(id)arg1 usingLayerSource:(id)arg2;

@end
