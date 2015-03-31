//
//  DKPrefs.h
//  Dockify
//
//  Created by Alexander Zielenski on 3/30/15.
//  Copyright (c) 2015 Alexander Zielenski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DKTheme.h"

#define Prefs(KEY) [DKPrefs sharedPreferences].KEY

@interface DKPrefs : NSObject

@property (assign, getter=isEnabled) BOOL enabled;
@property (strong) DKTheme *currentTheme;
@property (assign) DKThemeStyle currentStyle;

+ (instancetype)sharedPreferences;

@end
