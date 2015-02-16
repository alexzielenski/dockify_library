//
//  ZKColorParser.h
//  Dockify
//
//  Created by Alexander Zielenski on 2/15/15.
//  Copyright (c) 2015 Alexander Zielenski. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/* 
 parses:
 
 rgb: rgb(1.0, 1.0, 1.0)            // must have decimals
 rgb: rgb(100%, 100%, 100%)
 rgb: rgb(255, 255, 255)
 
 rgba: rgba(1.0, 1.0, 1.0, 1.0)      //must have decimals
 rgba: rgba(100%, 100%, 100%, 1.0)
 rgba: rgba(255, 255, 255, 1.0)
 rgba: rgba(255, 255, 255, 100%)
 
 hex: #000000
 hex: #000
 hex: #00
 
 hsl: hsl(0, 100%, 100%)
 hsla: hsla(0, 100%, 100%, 1.0)
 
 hsb: hsb(0, 100%, 100%)
 hsba: hsba(0, 100%, 100%, 1.0)
 
 */
@interface ZKColorParser : NSObject
+ (NSColor *)colorFromString:(NSString *)format;
@end
