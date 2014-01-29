/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "CAGradientLayer.h"

@class CALayer;

@interface ECProgressLayer : CAGradientLayer
{
    float _progress;
    int _style;
    CAGradientLayer *_progressContentLayer;
    CALayer *_progressOutlineLayer;
    CALayer *_progressOutlineShadowLayer;
    CALayer *_progressOutlineShadowContainerLayer;
}

@property(nonatomic) int style; // @synthesize style=_style;
@property(nonatomic) float progress; // @synthesize progress=_progress;
- (void)_setupLayers;
- (void)layoutSublayers;
- (void)dealloc;
- (id)initWithStyle:(int)arg1;

@end

