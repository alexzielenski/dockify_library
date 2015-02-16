//
//  math.c
//  Dockify
//
//  Created by Alexander Zielenski on 2/15/15.
//  Copyright (c) 2015 Alexander Zielenski. All rights reserved.
//

#include "math.h"

CATransform3D CATransform3DrectToQuad(CGRect rect,
                                      CGFloat x1a, CGFloat y1a,
                                      CGFloat x2a, CGFloat y2a,
                                      CGFloat x3a, CGFloat y3a,
                                      CGFloat x4a, CGFloat y4a) {
    CGFloat X = rect.origin.x;
    CGFloat Y = rect.origin.y;
    CGFloat W = rect.size.width;
    CGFloat H = rect.size.height;
    
    CGFloat y21 = y2a - y1a;
    CGFloat y32 = y3a - y2a;
    CGFloat y43 = y4a - y3a;
    CGFloat y14 = y1a - y4a;
    CGFloat y31 = y3a - y1a;
    CGFloat y42 = y4a - y2a;
    
    CGFloat a = -H*(x2a*x3a*y14 + x2a*x4a*y31 - x1a*x4a*y32 + x1a*x3a*y42);
    CGFloat b = W*(x2a*x3a*y14 + x3a*x4a*y21 + x1a*x4a*y32 + x1a*x2a*y43);
    CGFloat c = H*X*(x2a*x3a*y14 + x2a*x4a*y31 - x1a*x4a*y32 + x1a*x3a*y42) - H*W*x1a*(x4a*y32 - x3a*y42 + x2a*y43) - W*Y*(x2a*x3a*y14 + x3a*x4a*y21 + x1a*x4a*y32 + x1a*x2a*y43);
    
    CGFloat d = H*(-x4a*y21*y3a + x2a*y1a*y43 - x1a*y2a*y43 - x3a*y1a*y4a + x3a*y2a*y4a);
    CGFloat e = W*(x4a*y2a*y31 - x3a*y1a*y42 - x2a*y31*y4a + x1a*y3a*y42);
    CGFloat f = -(W*(x4a*(Y*y2a*y31 + H*y1a*y32) - x3a*(H + Y)*y1a*y42 + H*x2a*y1a*y43 + x2a*Y*(y1a - y3a)*y4a + x1a*Y*y3a*(-y2a + y4a)) - H*X*(x4a*y21*y3a - x2a*y1a*y43 + x3a*(y1a - y2a)*y4a + x1a*y2a*(-y3a + y4a)));
    
    CGFloat g = H*(x3a*y21 - x4a*y21 + (-x1a + x2a)*y43);
    CGFloat h = W*(-x2a*y31 + x4a*y31 + (x1a - x3a)*y42);
    CGFloat i = W*Y*(x2a*y31 - x4a*y31 - x1a*y42 + x3a*y42) + H*(X*(-(x3a*y21) + x4a*y21 + x1a*y43 - x2a*y43) + W*(-(x3a*y2a) + x4a*y2a + x2a*y3a - x4a*y3a - x2a*y4a + x3a*y4a));
    
    if(fabs(i) < 0.00001)
    {
        i = 0.00001;
    }
    
    CATransform3D t = CATransform3DIdentity;
    
    t.m11 = a / i;
    t.m12 = d / i;
    t.m13 = 0;
    t.m14 = g / i;
    t.m21 = b / i;
    t.m22 = e / i;
    t.m23 = 0;
    t.m24 = h / i;
    t.m31 = 0;
    t.m32 = 0;
    t.m33 = 1;
    t.m34 = 0;
    t.m41 = c / i;
    t.m42 = f / i;
    t.m43 = 0;
    t.m44 = i / i;
    
    return t;
}

CATransform3D rectToQuad(CGRect rect,
                         CGPoint topLeft, CGPoint topRight,
                         CGPoint bottomLeft, CGPoint bottomRight) {
    return CATransform3DrectToQuad(rect, topLeft.x, topLeft.y, topRight.x, topRight.y, bottomLeft.x, bottomLeft.y, bottomRight.x, bottomRight.y);
}

CGFloat offsetForHeight(CGFloat h) {
    static CGFloat minOffset = 12.0;
    static CGFloat minHeight = 17.0;
    static CGFloat offStep   = 0.5;
    
    CGFloat oHeight = h - minHeight;
    CGFloat z = ceil(oHeight * offStep);
    return minOffset + z;
}
