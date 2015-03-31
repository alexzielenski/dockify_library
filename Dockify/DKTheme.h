//
//  DKTheme.h
//  dockify_library
//
//  Created by Alex Zielenski on 7/17/14.
//  Copyright (c) 2014 Alex Zielenski. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DKConstants.h"

extern DKDockSize DKDockSizeFromSize(CGSize size);
extern DKDockSize DKDockSizeForIconSize(CGFloat iconSize);

@interface DKTheme : NSObject
@property (copy) NSURL *fileURL;
@property (copy) NSString *author;
@property (copy) NSString *info;
@property (assign, getter=isRetina) BOOL retina;
@property (copy) NSString *name;

@property (assign) DKThemeStyle styles;

@property (assign) CGFloat reflectionOpacity;
@property (assign) BOOL showShadows;
@property (assign) BOOL showSeparator;
@property (assign) CGFloat version;
@property (assign) CGFloat backgroundOpacity;
@property (strong) NSColor *shadowColor;
@property (assign) CGSize shadowDirection;
@property (assign) CGFloat shadowRadius;
@property (assign) CGFloat iconOpacity;
@property (assign) CGFloat borderRadius;
@property (assign) CGFloat borderWidth;
@property (strong) NSColor *borderColor;
@property (strong) NSColor *backgroundColor;
@property (assign) CGFloat backgroundBlurRadius;

+ (instancetype)themeWithContentsOfURL:(NSURL *)url;
- (instancetype)initWithContentsOfURL:(NSURL *)url;

- (CGImageRef)scurveImageForSize:(DKDockSize)size retina:(BOOL)flag;
- (CGImageRef)frontlineImageAsRetina:(BOOL)flag;
- (CGImageRef)separatorImageForStyle:(DKThemeStyle)style orientation:(DKDockOrientation)orientation retina:(BOOL)flag;
- (CGImageRef)indicatorForSize:(DKDockSize)size retina:(BOOL)flag;
- (CGImageRef)wideBackgroundImageForSize:(DKDockSize)size retina:(BOOL)flag;
- (CGImageRef)flatBackgroundImageForPart:(DKFlatPart)part retina:(BOOL)flag;

- (BOOL)supportsOrientation:(DKDockOrientation)orientation;
- (DKThemeStyle)supportedStylesOfStyles:(DKThemeStyle)style;
- (BOOL)supportsStyle:(DKThemeStyle)style;

@end
