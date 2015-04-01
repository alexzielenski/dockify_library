//
//  DKNinePartFloorLayer.h
//  Dockify
//
//  Created by Alexander Zielenski on 3/31/15.
//  Copyright (c) 2015 Alexander Zielenski. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "Dockify.h"

@interface DKNinePartFloorLayer : CALayer
@property (readonly, strong) CALayer *topLeft;
@property (readonly, strong) CALayer *topEdge;
@property (readonly, strong) CALayer *topRight;
@property (readonly, strong) CALayer *leftEdge;
@property (readonly, strong) CALayer *centerFill;
@property (readonly, strong) CALayer *rightEdge;
@property (readonly, strong) CALayer *bottomLeft;
@property (readonly, strong) CALayer *bottomEdge;
@property (readonly, strong) CALayer *bottomRight;
@property (assign) DKDockOrientation orientation;

- (CALayer *)layerForPart:(DKFlatPart)part;
- (void)setImage:(CGImageRef)image forPart:(DKFlatPart)part;

@end
