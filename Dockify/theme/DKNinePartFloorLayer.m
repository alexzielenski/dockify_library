//
//  DKNinePartFloorLayer.m
//  Dockify
//
//  Created by Alexander Zielenski on 3/31/15.
//  Copyright (c) 2015 Alexander Zielenski. All rights reserved.
//

#import "DKNinePartFloorLayer.h"

@interface DKNinePartFloorLayer () {
    dispatch_once_t setupFinishedToken;
}
@property (readwrite, strong) CALayer *topLeft;
@property (readwrite, strong) CALayer *topEdge;
@property (readwrite, strong) CALayer *topRight;
@property (readwrite, strong) CALayer *leftEdge;
@property (readwrite, strong) CALayer *centerFill;
@property (readwrite, strong) CALayer *rightEdge;
@property (readwrite, strong) CALayer *bottomLeft;
@property (readwrite, strong) CALayer *bottomEdge;
@property (readwrite, strong) CALayer *bottomRight;
- (void)setupIfNeeded;
- (CGSize)contentsSizeForPart:(DKFlatPart)part;
@end

@implementation DKNinePartFloorLayer

- (void)layoutSublayers {
    [self setupIfNeeded];
    
    CGSize topLeftSize     = [self contentsSizeForPart:DKFlatPartTopLeft];
    CGSize topEdgeSize     = [self contentsSizeForPart:DKFlatPartTopEdge];
    CGSize topRightSize    = [self contentsSizeForPart:DKFlatPartTopRight];
    CGSize leftEdgeSize    = [self contentsSizeForPart:DKFlatPartLeftEdge];
    CGSize rightEdgeSize   = [self contentsSizeForPart:DKFlatPartRightEdge];
    CGSize bottomLeftSize  = [self contentsSizeForPart:DKFlatPartBottomLeft];
    CGSize bottomEdgeSize  = [self contentsSizeForPart:DKFlatPartBottomEdge];
    CGSize bottomRightSize = [self contentsSizeForPart:DKFlatPartBottomRight];
    
    // Offset the coordinates of some of the fills just incase the fixed-size elements
    // have different sizes. This is because are anchors are in the center of a certain axis
    // and will expand out a certain width from there equally in both directions
    CGFloat topEdgeOffsetX = (topLeftSize.width - topRightSize.width) / 2;
    CGFloat leftEdgeOffsetY = (bottomLeftSize.height - topLeftSize.height) / 2;
    CGFloat centerFillOffsetX = (leftEdgeSize.width - rightEdgeSize.width) / 2;
    CGFloat centerFillOffsetY = (bottomEdgeSize.height - topEdgeSize.height) / 2;
    CGFloat rightEdgeOffsetY = (bottomRightSize.height - topRightSize.height) / 2;
    CGFloat bottomEdgeOffsetX = (bottomLeftSize.width - bottomRightSize.width) / 2;
    
    self.topLeft.frame     = CGRectMake(0.0,
                                        CGRectGetMaxY(self.bounds),
                                        topLeftSize.width, topLeftSize.height);
    self.topEdge.frame     = CGRectMake(CGRectGetMidX(self.bounds) + topEdgeOffsetX,
                                        CGRectGetMaxY(self.bounds),
                                        CGRectGetWidth(self.bounds) - topLeftSize.width - topRightSize.height, topEdgeSize.height);
    self.topRight.frame    = CGRectMake(CGRectGetMaxX(self.bounds),
                                        CGRectGetMaxY(self.bounds),
                                        topRightSize.width,
                                        topRightSize.height);
    self.leftEdge.frame    = CGRectMake(0.0,
                                        CGRectGetMidY(self.bounds) + leftEdgeOffsetY,
                                        leftEdgeSize.width,
                                        CGRectGetHeight(self.bounds) - topLeftSize.height - bottomLeftSize.height);
    self.centerFill.frame  = CGRectMake(CGRectGetMidX(self.bounds) + centerFillOffsetX,
                                        CGRectGetMidY(self.bounds) + centerFillOffsetY,
                                        CGRectGetWidth(self.bounds) - leftEdgeSize.width - rightEdgeSize.width,
                                        CGRectGetHeight(self.bounds) - topEdgeSize.height - bottomEdgeSize.height);
    self.rightEdge.frame   = CGRectMake(CGRectGetMaxX(self.bounds),
                                        CGRectGetMidY(self.bounds) + rightEdgeOffsetY,
                                        rightEdgeSize.width,
                                        CGRectGetHeight(self.bounds) - topRightSize.height - bottomRightSize.height);
    self.bottomLeft.frame  = CGRectMake(0.0,
                                        0.0,
                                        bottomLeftSize.width,
                                        bottomLeftSize.height);
    self.bottomEdge.frame  = CGRectMake(CGRectGetMidX(self.bounds) + bottomEdgeOffsetX,
                                        0.0,
                                        CGRectGetWidth(self.bounds) - bottomLeftSize.width - bottomRightSize.width,
                                        bottomEdgeSize.height);
    self.bottomRight.frame = CGRectMake(CGRectGetMaxX(self.bounds),
                                        0.0,
                                        bottomRightSize.width,
                                        bottomRightSize.height);
}

- (void)setupIfNeeded {
    dispatch_once(&setupFinishedToken, ^{
        self.topLeft     = [CALayer layer];
        self.topEdge     = [CALayer layer];
        self.topRight    = [CALayer layer];
        self.leftEdge    = [CALayer layer];
        self.centerFill  = [CALayer layer];
        self.rightEdge   = [CALayer layer];
        self.bottomLeft  = [CALayer layer];
        self.bottomEdge  = [CALayer layer];
        self.bottomRight = [CALayer layer];
        
        self.topLeft.anchorPoint     = CGPointMake(0.0, 1.0);
        self.topEdge.anchorPoint     = CGPointMake(0.5, 1.0);
        self.topRight.anchorPoint    = CGPointMake(1.0, 1.0);
        self.leftEdge.anchorPoint    = CGPointMake(0.0, 0.5);
        self.centerFill.anchorPoint  = CGPointMake(0.5, 0.5);
        self.rightEdge.anchorPoint   = CGPointMake(1.0, 0.5);
        self.bottomLeft.anchorPoint  = CGPointMake(0.0, 0.0);
        self.bottomEdge.anchorPoint  = CGPointMake(0.5, 0.0);
        self.bottomRight.anchorPoint = CGPointMake(1.0, 0.0);
        
        self.topLeft.contentsGravity     = kCAGravityTopLeft;
        self.topEdge.contentsGravity     = kCAGravityResize;
        self.topRight.contentsGravity    = kCAGravityTopRight;
        self.leftEdge.contentsGravity    = kCAGravityResize;
        self.centerFill.contentsGravity  = kCAGravityResize;
        self.rightEdge.contentsGravity   = kCAGravityResize;
        self.bottomLeft.contentsGravity  = kCAGravityBottomLeft;
        self.bottomEdge.contentsGravity  = kCAGravityResize;
        self.bottomRight.contentsGravity = kCAGravityBottomRight;
        
        [self addSublayer:self.centerFill];
        [self addSublayer:self.rightEdge];
        [self addSublayer:self.leftEdge];
        [self addSublayer:self.topEdge];
        [self addSublayer:self.bottomEdge];
        [self addSublayer:self.topLeft];
        [self addSublayer:self.topRight];
        [self addSublayer:self.bottomLeft];
        [self addSublayer:self.bottomRight];
    });

    self.topLeft.contentsScale     = self.contentsScale;
    self.topEdge.contentsScale     = self.contentsScale;
    self.topRight.contentsScale    = self.contentsScale;
    self.leftEdge.contentsScale    = self.contentsScale;
    self.centerFill.contentsScale  = self.contentsScale;
    self.rightEdge.contentsScale   = self.contentsScale;
    self.bottomLeft.contentsScale  = self.contentsScale;
    self.bottomEdge.contentsScale  = self.contentsScale;
    self.bottomRight.contentsScale = self.contentsScale;
}

- (CGSize)contentsSizeForPart:(DKFlatPart)part {
    CALayer *layer = [self layerForPart:part];
    CGImageRef image = (__bridge CGImageRef)(layer.contents);
    return CGSizeMake((CGFloat)CGImageGetWidth(image) / layer.contentsScale,
                      (CGFloat)CGImageGetHeight(image) / layer.contentsScale);
}

- (CALayer *)layerForPart:(DKFlatPart)part {
    switch (part) {
        case DKFlatPartTopLeft:
            return self.topLeft;
            break;
        case DKFlatPartTopRight:
            return self.topRight;
            break;
        case DKFlatPartTopEdge:
            return self.topEdge;
            break;
        case DKFlatPartLeftEdge:
            return self.leftEdge;
            break;
        case DKFlatPartRightEdge:
            return self.rightEdge;
            break;
        case DKFlatPartCenterFill:
            return self.centerFill;
            break;
        case DKFlatPartBottomLeft:
            return self.bottomLeft;
            break;
        case DKFlatPartBottomEdge:
            return self.bottomEdge;
            break;
        case DKFlatPartBottomRight:
            return self.bottomRight;
            break;
        default:
            break;
    }
}

- (void)setImage:(CGImageRef)image forPart:(DKFlatPart)part {
    [self layerForPart:part].contents = (__bridge id)(image);
    [self setNeedsLayout];
}

@end
