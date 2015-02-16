//
//  DKConstants.h
//  dockify_library
//
//  Created by Alex Zielenski on 7/18/14.
//  Copyright (c) 2014 Alex Zielenski. All rights reserved.
//

typedef NS_ENUM(NSUInteger, DKDockSize) {
    DKDockSizeSmall = 0,
    DKDockSizeMedium = 1,
    DKDockSizeLarge = 2,
    DKDockSizeExtraLarge = 3
};

typedef NS_ENUM(NSUInteger, DKDockOrientation) {
    DKDockOrientationBottom = 0,
    DKDockOrientationLeft = 1,
    DKDockOrientationRight = 2
};

typedef NS_OPTIONS(NSUInteger, DKThemeStyle) {
    DKThemeNoStyle = 0,
    DKTheme3DStyle = 1 << 0,
    DKTheme2DStyle = 1 << 1,
    DKThemeWideStyle = 1 << 2
};

typedef NS_ENUM(NSUInteger, DKFlatPart) {
    DKFlatPartTopLeft = 0,
    DKFlatPartTopRight = 1,
    DKFlatPartTopEdge = 2,
    DKFlatPartLeftEdge = 3,
    DKFlatPartRightEdge = 4,
    DKFlatPartCenterFill = 5
};

extern BOOL DKStyleSupportsOrientation(DKThemeStyle style, DKDockOrientation orientation);
#define kDKTileOffsetMultiplier Yosemite ? 1.0 : 0.6
#define kDKDockMaximumVerticalHeight 93.0
#define kDKDockMaximumHorizontalHeight 156.0
