//
//  DKFloorLayer.h
//  Dockify
//
//  Created by Alexander Zielenski on 2/15/15.
//  Copyright (c) 2015 Alexander Zielenski. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DOCKFloorLayer.h"
#import "ECMaterialLayer.h"

@interface DKFloorLayer : CALayer
@property CALayer *separatorLayer;
@property CALayer *glassLayer;
@property (readonly) ECMaterialLayer *materialLayer;
- (DKDockSize)currentSize;
@end
