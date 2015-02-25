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

CG_INLINE CATransform3D
CATransform3DMake(CGFloat m11, CGFloat m12, CGFloat m13, CGFloat m14,
                  CGFloat m21, CGFloat m22, CGFloat m23, CGFloat m24,
                  CGFloat m31, CGFloat m32, CGFloat m33, CGFloat m34,
                  CGFloat m41, CGFloat m42, CGFloat m43, CGFloat m44)
{
    CATransform3D t;
    t.m11 = m11; t.m12 = m12; t.m13 = m13; t.m14 = m14;
    t.m21 = m21; t.m22 = m22; t.m23 = m23; t.m24 = m24;
    t.m31 = m31; t.m32 = m32; t.m33 = m33; t.m34 = m34;
    t.m41 = m41; t.m42 = m42; t.m43 = m43; t.m44 = m44;
    return t;
}

#endif /* defined(__Dockify__math__) */
