//
//  Dockify.h
//  Dockify
//
//  Created by Alexander Zielenski on 2/15/15.
//  Copyright (c) 2015 Alexander Zielenski. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZKSwizzle.h"
#import "math.h"
#import "DKConstants.h"
#import "DKTheme.h"
#import "DKPrefs.h"

#define DLog(fmt, ...) NSLog((@"dockify: " fmt),  ##__VA_ARGS__)
#define D(fmt) DLog(@"%@", fmt)
