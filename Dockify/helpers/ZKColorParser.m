//
//  ZKColorParser.m
//  ZKColorParser
//
//  Created by Alexander Zielenski on 2/15/15.
//  Copyright (c) 2015 Alexander Zielenski. All rights reserved.
//

#import "ZKColorParser.h"

CGFloat convertToDecimal(NSString *input) {
    if ([input rangeOfString:@"."].location != NSNotFound) {
        return input.doubleValue;
    } else if ([input rangeOfString:@"%"].location != NSNotFound) {
        input = [input stringByReplacingOccurrencesOfString:@"%" withString:@" "];
        return input.doubleValue / 100.0;
    }
    
    return input.doubleValue / 255.0;
}

@interface ZKColorParser ()
+ (NSColor *)colorFromHex:(NSString *)hex;
+ (NSColor *)colorFromRGB:(NSString *)rgb;
+ (NSColor *)colorFromHSL:(NSString *)hsl;
+ (NSArray *)argumentsFromString:(NSString *)format;
@end

@implementation ZKColorParser

+ (NSColor *)colorFromString:(NSString *)format {
    if (!format || format.length <= 1) {
        return nil;
    }
    
    format = format.lowercaseString;
    format = [format stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([format hasPrefix:@"rgb"]) {
        return [self colorFromRGB:format];
    } else if ([format hasPrefix:@"#"]) {
        return [self colorFromHex:format];
    } else if ([format hasPrefix:@"hsl"]) {
        return [self colorFromHSL:format];
    }
    
    return nil;
}

+ (NSColor *)colorFromHex:(NSString *)hex {
    unsigned colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    hex = [hex substringFromIndex:1];
    
    // support shorthand
    if (hex.length == 3) {
        char c1 = [hex characterAtIndex:0];
        char c2 = [hex characterAtIndex:1];
        char c3 = [hex characterAtIndex:2];
        hex = [NSString stringWithFormat:@"%c%c%c%c%c%c", c1, c1, c2, c2, c3, c3];
    }
    
    if (hex != nil) {
        NSScanner *scanner = [NSScanner scannerWithString:hex];
        (void) [scanner scanHexInt:&colorCode];
    }
    
    redByte = (unsigned char)((colorCode & 0xff0000) >> 16);
    greenByte = (unsigned char)((colorCode & 0x00ff00) >> 8);
    blueByte = (unsigned char)(colorCode & 0xff);
    
    return [NSColor
            colorWithCalibratedRed:(CGFloat)redByte / 0xFF
            green:(CGFloat)greenByte / 0xFF
            blue:(CGFloat)blueByte / 0xFF
            alpha:1.0];
}

+ (NSColor *)colorFromRGB:(NSString *)rgb {
    NSArray *args = [self argumentsFromString:rgb];
    if (args.count != 3 && args.count != 4) {
        NSLog(@"ZKColorParser: invalid arguments for input rgb string format: %@", rgb);
        return nil;
    }
    
    return [NSColor colorWithCalibratedRed:convertToDecimal(args[0])
                                     green:convertToDecimal(args[1])
                                      blue:convertToDecimal(args[2])
                                     alpha:args.count == 4 ? convertToDecimal(args[3]): 1.0];
}

+ (NSColor *)colorFromHSL:(NSString *)hsl {
    NSArray *args = [self argumentsFromString:hsl];
    if (args.count != 3 && args.count != 4) {
        NSLog(@"ZKColorParser: invalid arguments for input hsl string format: %@", hsl);
        return nil;
    }
    
    NSInteger hue = [(NSString *)args[0] integerValue];
    return [NSColor colorWithCalibratedHue:(CGFloat)((hue % 360) / 360.0)
                                saturation:convertToDecimal(args[1])
                                brightness:convertToDecimal(args[2])
                                     alpha:args.count == 4 ? convertToDecimal(args[3]) : 1.0];
}

// decodes something like asdasda(x,y,z) into [x, y, z]
+ (NSArray *)argumentsFromString:(NSString *)format {
    if (format == nil || format.length == 0)
        return @[];
    
    NSRange firstParen = [format rangeOfString:@"("];
    NSRange lastParen = [format rangeOfString:@")"];
    
    if (firstParen.location == NSNotFound || lastParen.location == NSNotFound)
        return @[];
    
    NSString *argumentString = [format substringWithRange:
                                NSMakeRange(firstParen.location + 1, lastParen.location - firstParen.location - 1)];
    return [argumentString componentsSeparatedByString:@","];
}

@end
