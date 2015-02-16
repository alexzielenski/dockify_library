//
//  math.h
//  Dockify
//
//  Created by Alexander Zielenski on 2/15/15.
//  Copyright (c) 2015 Alexander Zielenski. All rights reserved.
//

#ifndef __Dockify__math__
#define __Dockify__math__

#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#define DKMakeTransformLeft() CATransform3DMakeRotation(270.0 / 180.0 * M_PI, 0, 0, 1.00)
#define DKMakeTransformRight() CATransform3DMakeRotation(90.0 / 180.0 * M_PI, 0.0, 0.0, 1.0)

CATransform3D CATransform3DrectToQuad(CGRect rect,
                                      CGFloat x1a, CGFloat y1a,
                                      CGFloat x2a, CGFloat y2a,
                                      CGFloat x3a, CGFloat y3a,
                                      CGFloat x4a, CGFloat y4a);

CATransform3D rectToQuad(CGRect rect,
                         CGPoint topLeft, CGPoint topRight,
                         CGPoint bottomLeft, CGPoint bottomRight);

CGFloat offsetForHeight(CGFloat h);

#endif /* defined(__Dockify__math__) */
