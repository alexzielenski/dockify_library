//
//  DKPrefs.m
//  Dockify
//
//  Created by Alexander Zielenski on 3/30/15.
//  Copyright (c) 2015 Alexander Zielenski. All rights reserved.
//

#import "DKPrefs.h"

@interface DKPrefs ()
@property (strong) DKTheme *_currentTheme;
@end

static NSString *const DKPrefsChangedNotification = @"com.alexzielenski.dockify/prefsChanged";

static NSString *const DKPrefsEnabledKey = @"dockify-enabled";
static NSString *const DKPrefsStyleKey   = @"dockify-style";
static NSString *const DKPrefsThemeKey   = @"dockify-theme";

static id GetPrefsValue(NSString *key) {
    return (__bridge_transfer id)CFPreferencesCopyAppValue((__bridge CFStringRef)key, CFSTR("com.apple.dock"));
}

static void SetPrefsValue(NSString *key, id value) {
    CFPreferencesSetAppValue((__bridge CFStringRef)key,
                             (__bridge CFPropertyListRef)value,
                             CFSTR("com.apple.dock"));
}

static void PostPrefsChanged() {
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(),
                                         (__bridge CFStringRef)DKPrefsChangedNotification,
                                         NULL, NULL, true);
}

static void prefsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    DKPrefs *self = (__bridge DKPrefs *)observer;
    NSString *themePath = GetPrefsValue(DKPrefsThemeKey);
    
    if (![themePath isEqualToString:self.currentTheme.fileURL.path]) {
        self._currentTheme = [DKTheme themeWithContentsOfURL:[NSURL fileURLWithPath:themePath]];
    }
}

@implementation DKPrefs
@dynamic enabled, currentStyle, currentTheme;

+ (instancetype)sharedPreferences {
    static DKPrefs *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    
    return shared;
}

- (instancetype)init {
    if ((self = [super init])) {
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                        (__bridge const void *)(self),
                                        prefsChanged,
                                        (__bridge CFStringRef)DKPrefsChangedNotification,
                                        NULL,
                                        CFNotificationSuspensionBehaviorDeliverImmediately);
    }
    
    return self;
}

- (void)dealloc {
    CFNotificationCenterRemoveObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                       (__bridge const void *)self,
                                       (__bridge CFStringRef)DKPrefsChangedNotification,
                                       NULL);
}

#pragma mark - Computed Properties

- (BOOL)isEnabled {
    return ((NSNumber *)GetPrefsValue(DKPrefsEnabledKey)).boolValue;
}

- (void)setEnabled:(BOOL)enabled {
    [self willChangeValueForKey:@"enabled"];
    SetPrefsValue(DKPrefsEnabledKey, @(enabled));
    PostPrefsChanged();
    [self didChangeValueForKey:@"enabled"];
}

- (DKTheme *)currentTheme {
    return self._currentTheme;
}

- (void)setCurrentTheme:(DKTheme *)currentTheme {
    SetPrefsValue(DKPrefsThemeKey, currentTheme.fileURL.path);
    self._currentTheme = currentTheme;
    PostPrefsChanged();
}

- (DKThemeStyle)currentStyle {
    return ((NSNumber *)GetPrefsValue(DKPrefsStyleKey)).unsignedIntegerValue;
}

- (void)setCurrentStyle:(DKThemeStyle)currentStyle {
    [self willChangeValueForKey:@"currentStyle"];
    SetPrefsValue(DKPrefsStyleKey, @(currentStyle));
    PostPrefsChanged();
    [self didChangeValueForKey:@"currentStyle"];
}

+ (NSSet *)keyPathsForValuesAffectingCurrentTheme {
    return [NSSet setWithObjects:@"_currentTheme", nil];
}

@end
