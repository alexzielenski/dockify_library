//
//  DKTheme.m
//  dockify_library
//
//  Created by Alex Zielenski on 7/17/14.
//  Copyright (c) 2014 Alex Zielenski. All rights reserved.
//

#import "DKTheme.h"
#import "ZKColorParser.h"

typedef NSString * DKFilename;
DKFilename DKInfoFileName = @"Info.plist";

DKFilename DKLargeBackgroundFilename = @"backgrounds/3d/large.png";
DKFilename DKMediumBackgroundFilename = @"backgrounds/3d/small.png";
DKFilename DKSmallBackgroundFilename = @"backgrounds/3d/medium.png";
DKFilename DKXLargeBackgroundFilename = @"backgrounds/3d/xlarge.png";
DKFilename DKFrontlineFilename = @"backgrounds/3d/frontline.png";

DKFilename DKWideSmallFilename = @"backgrounds/wide/small.png";
DKFilename DKWideMediumFilename = @"backgrounds/wide/medium.png";
DKFilename DKWideLargeFilename = @"backgrounds/wide/large.png";;

DKFilename DK2DTopLeftFilename = @"backgrounds/2d/topleft.png";
DKFilename DK2DTopRightFilename = @"backgrounds/2d/topright.png";
DKFilename DK2DTopEdgeFilename = @"backgrounds/2d/topedge.png";;
DKFilename DK2DLeftEdgeFilename = @"backgrounds/2d/leftedge.png";;
DKFilename DK2DRightEdgeFilename = @"backgrounds/2d/rightedge.png";;
DKFilename DK2DCenterFillFilename = @"backgrounds/2d/centerfill.png";;

DKFilename DKSeparator2DFilename = @"separators/2d.png";
DKFilename DKSeparator2DVerticalFilename = @"separators/2dvertical.png";
DKFilename DKSeparator3DFilename = @"separators/3d.png";
DKFilename DKSeparatorWideFilename = @"separators/wide.png";

DKFilename DKIndicatorSmallFilename = @"indicators/small.png";
DKFilename DKIndicatorMediumFilename = @"indicators/medium.png";
DKFilename DKIndicatorLargeFilename = @"indicators/large.png";
DKFilename DKIndicatorXLargeFilename = @"indicators/xlarge.png";

typedef NSString * DKThemeKey;
DKThemeKey DKAuthorThemeKey            = @"Author";
DKThemeKey DKInfoThemeKey              = @"Info";
DKThemeKey DKReflectionOpacityThemeKey = @"ReflectionOpacity";
DKThemeKey DKBackgroundOpacityThemeKey = @"BackgroundOpacity";
DKThemeKey DKRetinaThemeKey            = @"Retina";
DKThemeKey DKNameThemeKey              = @"Name";
DKThemeKey DKStylesThemeKey            = @"Styles";
DKThemeKey DKShowSeparatorThemeKey     = @"ShowSeparator";
DKThemeKey DKShowShadowsThemeKey       = @"ShowShadows";
DKThemeKey DKVersionThemeKey           = @"Version";
DKThemeKey DKShadowColorThemeKey       = @"BackgroundShadowColor";
DKThemeKey DKShadowDirectionThemeKey   = @"BackgroundShadowDirection";
DKThemeKey DKShadowRadiusThemeKey      = @"BackgroundShadowRadius";
DKThemeKey DKIconOpacityThemeKey       = @"IconOpacity";
DKThemeKey DKBorderColorThemeKey       = @"BorderColor";
DKThemeKey DKBorderWidthThemeKey       = @"BorderWidth";
DKThemeKey DKBorderRadiusThemeKey      = @"BorderRadius";
DKThemeKey DKBackgroundColorThemeKey   = @"BackgroundColor";

extern DKDockSize DKDockSizeFromSize(CGSize size) {
    // large 1280x98px
    // medium 1280x128
    // small 900x128
    // xlarge 1280x86
    if (size.height <= 86) {
        return DKDockSizeExtraLarge;
    } else if (size.height <= 98) {
        return DKDockSizeLarge;
    }

    // middle between small and medium
    if (size.width <= 1090) {
        return DKDockSizeSmall;
    }

    return DKDockSizeMedium;
}

extern BOOL DKStyleSupportsOrientation(DKThemeStyle style, DKDockOrientation orientation) {
    switch (orientation) {
        case DKDockOrientationBottom:
            return YES;
        case DKDockOrientationLeft:
        case DKDockOrientationRight:
            return (style & DKTheme2DStyle) == DKTheme2DStyle;
        default:
            break;
    }
}

NSString *retinaNameofFilename(DKFilename filename) {
    NSString *ext = filename.pathExtension;
    NSString *f = [filename stringByDeletingPathExtension];
    f = [[f stringByAppendingString:@"@2x"] stringByAppendingPathExtension:ext];
    return f;
}

@interface DKTheme ()
@property (strong) NSCache *imageCache;
- (BOOL)_readFromDictionary:(NSDictionary *)dict;
- (CGImageRef)imageWithName:(DKFilename)filename retina:(BOOL)flag;
@end

@implementation DKTheme

+ (instancetype)themeWithContentsOfURL:(NSURL *)url {
    return [[self alloc] initWithContentsOfURL:url];
}

- (instancetype)initWithContentsOfURL:(NSURL *)url {
    if ((self = [self init])) {
        self.fileURL = url;
        self.imageCache = [[NSCache alloc] init];
        self.imageCache.evictsObjectsWithDiscardedContent = NO;

        if (![self _readFromDictionary:[NSDictionary dictionaryWithContentsOfURL:[url URLByAppendingPathComponent:DKInfoFileName]]]) {
            return nil;
        }
    }
    return self;
}

- (BOOL)_readFromDictionary:(NSDictionary *)dict {
    if (!dict) {
        return NO;
    }

    self.author = dict[DKAuthorThemeKey];
    self.info = dict[DKInfoThemeKey];
    self.reflectionOpacity = [dict[DKReflectionOpacityThemeKey] doubleValue];
    self.backgroundOpacity = [dict[DKBackgroundOpacityThemeKey] doubleValue];
    self.retina = [dict[DKRetinaThemeKey] boolValue];
    self.name = dict[DKNameThemeKey];
    self.styles = [dict[DKStylesThemeKey] unsignedIntegerValue];
    self.showShadows = [dict[DKShowShadowsThemeKey] boolValue];
    self.showSeparator = [dict[DKShowSeparatorThemeKey] boolValue];
    self.version = [dict[DKVersionThemeKey] doubleValue];
    self.iconOpacity = [dict[DKIconOpacityThemeKey] doubleValue];
    self.borderRadius = [dict[DKBorderRadiusThemeKey] doubleValue];
    self.borderWidth = [dict[DKBorderWidthThemeKey] doubleValue];
    
    self.shadowColor =[ZKColorParser colorFromString:dict[DKShadowColorThemeKey]] ?: [NSColor blackColor];
    self.borderColor = [ZKColorParser colorFromString:dict[DKBorderColorThemeKey]];
    self.backgroundColor = [ZKColorParser colorFromString:dict[DKBackgroundColorThemeKey]];
    
    // shadow is in the format (x, y) where both specify offset directions for the shadow
    NSString *shadowString = [dict[DKShadowDirectionThemeKey] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (shadowString) {
        shadowString = [shadowString substringWithRange:NSMakeRange(1, shadowString.length - 2)];

        NSArray *shadowComponents = [shadowString componentsSeparatedByString:@","];
        self.shadowDirection = CGSizeMake([shadowComponents[0] doubleValue], [shadowComponents[1] doubleValue]);
    } else {
        self.shadowDirection = CGSizeMake(0.0, -3.0);
    }

    if (dict[DKShadowRadiusThemeKey]) {
        self.shadowRadius = [dict[DKShadowRadiusThemeKey] doubleValue];
    } else {
        self.shadowRadius = 10.0;
    }

    if (self.styles == DKThemeNoStyle)
        return NO;

    return YES;
}

- (CGImageRef)imageWithName:(DKFilename)filename retina:(BOOL)flag {
    NSString *key = [filename stringByAppendingString:flag ? @"@2x" : @""];
    id obj = [self.imageCache objectForKey:key];
    if (obj)
        return (__bridge CGImageRef)obj;

    NSURL *imageURL = [self.fileURL URLByAppendingPathComponent:flag ? retinaNameofFilename(filename) : filename];

    NSBitmapImageRep *image = [[NSBitmapImageRep alloc] initWithData:[NSData dataWithContentsOfURL:imageURL]];
    if (!image) {
        if (flag) return [self imageWithName:filename retina:NO];
        else return nil;
    }

    [self.imageCache setObject:(id)[image CGImage] forKey:key];
    return [self imageWithName:filename retina:flag];
}

- (CGImageRef)scurveImageForSize:(DKDockSize)size retina:(BOOL)flag {
    DKFilename filename = nil;
    switch (size) {
        case DKDockSizeSmall:
            filename = DKSmallBackgroundFilename;
            break;
        case DKDockSizeMedium:
            filename = DKMediumBackgroundFilename;
            break;
        case DKDockSizeLarge:
            filename = DKLargeBackgroundFilename;
            break;
        case DKDockSizeExtraLarge:
            filename = DKXLargeBackgroundFilename;
            break;
        default:
            break;
    }

    return [self imageWithName:filename retina:flag];
}

- (CGImageRef)frontlineImageAsRetina:(BOOL)flag {
    return [self imageWithName:DKFrontlineFilename retina:flag];
}

- (CGImageRef)separatorImageForStyle:(DKThemeStyle)style orientation:(DKDockOrientation)orientation retina:(BOOL)flag {
    switch (style) {
        case DKTheme3DStyle:
            return [self imageWithName:DKSeparator3DFilename retina:flag];
            break;
        case DKTheme2DStyle:
            return [self imageWithName:orientation == DKDockOrientationBottom ? DKSeparator2DFilename : DKSeparator2DVerticalFilename retina:flag];

        case DKThemeWideStyle:
            return [self imageWithName:DKSeparatorWideFilename retina:flag];
        default:
            return nil;
            break;
    }
}

- (CGImageRef)indicatorForSize:(DKDockSize)size retina:(BOOL)flag {
    DKFilename filename = nil;
    switch (size) {
        case DKDockSizeSmall:
            filename = DKIndicatorSmallFilename;
            break;
        case DKDockSizeMedium:
            filename = DKIndicatorMediumFilename;
            break;
        case DKDockSizeLarge:
            filename = DKIndicatorLargeFilename;
            break;
        case DKDockSizeExtraLarge:
            filename = DKIndicatorXLargeFilename;
            break;
        default:
            break;
    }

    return [self imageWithName:filename retina:flag];
}

- (CGImageRef)wideBackgroundImageForSize:(DKDockSize)size retina:(BOOL)flag {
    NSString *filename = nil;
    switch (size) {
        case DKDockSizeSmall:
            filename = DKWideSmallFilename;
            break;
        case DKDockSizeMedium:
            filename = DKWideMediumFilename;
            break;
        default:
            filename = DKWideLargeFilename;
            break;
    }

    return [self imageWithName:DKWideLargeFilename retina:flag];
}

- (CGImageRef)flatBackgroundImageForPart:(DKFlatPart)part retina:(BOOL)flag {
    DKFilename filename = nil;
    switch (part) {
        case DKFlatPartCenterFill:
            filename = DK2DCenterFillFilename;
            break;
        case DKFlatPartLeftEdge:
            filename = DK2DLeftEdgeFilename;
            break;
        case DKFlatPartRightEdge:
            filename = DK2DRightEdgeFilename;
            break;
        case DKFlatPartTopEdge:
            filename = DK2DTopEdgeFilename;
            break;
        case DKFlatPartTopLeft:
            filename = DK2DTopLeftFilename;
            break;
        case DKFlatPartTopRight:
            filename = DK2DTopRightFilename;
            break;
    }
    
    return [self imageWithName:filename retina:flag];
}


@end
