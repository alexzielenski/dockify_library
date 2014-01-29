/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "Springboard.h"

#import "DOCKExtraDelegate-Protocol.h"

@class NSMapTable, NSMutableDictionary, WALayerKitWindow;

@interface LPSpringboard : Springboard <DOCKExtraDelegate>
{
    WALayerKitWindow *_window;
    WALayerKitWindow *_dragWindow;
    NSMutableDictionary *_runningProcessLabels;
    NSMutableDictionary *_pushLabels;
    NSMapTable *_dragAcceptanceMap;
}

- (void)_desktopPictureChanged:(id)arg1;
- (void)_updateDesktopImages;
- (void)uninstallRunnable:(id)arg1 withResult:(id)arg2;
- (void)_uninstallClearNotificationObservers:(id)arg1;
- (BOOL)performDropForItem:(id)arg1 withEvent:(id)arg2 sender:(id)arg3;
- (BOOL)canAcceptDropForItem:(id)arg1 withEvent:(id)arg2 sender:(id)arg3;
- (void)initialSetupComplete;
- (void)bounceDockIcon;
- (id)zoomFactorsPrefKey;
- (void)iconSizesChanged;
- (BOOL)unregisterObservationOfItem:(id)arg1;
- (BOOL)registerObservationOfItem:(id)arg1;
- (BOOL)handleRunnableOpen:(id)arg1 atURL:(id)arg2 fromFrame:(struct CGRect)arg3 toFrame:(struct CGRect *)arg4;
- (id)newDesktopLayer;
- (void)_appExtraPluginStateChanged:(id)arg1;
- (void)_removeAppDockExtra:(id)arg1;
- (void)_addAppDockExtra:(id)arg1;
- (void)setStatusLabel:(id)arg1 forPushNotificationWithBundleID:(id)arg2;
- (void)setStatusLabel:(id)arg1 forRunningProcess:(struct CPSProcessSerNum)arg2;
- (void)setStatusLabel:(id)arg1 forProcessWithBundleIdentifier:(id)arg2;
- (void)dockExtraSetCustomIconImage:(struct CGImage *)arg1 withContext:(id)arg2;
- (void)dockExtraSetBadgeLabel:(id)arg1 withContext:(id)arg2;
- (void)endDragOfItem:(id)arg1 withEvent:(id)arg2 andLayer:(id)arg3;
- (void)beginDragOfItem:(id)arg1 withEvent:(id)arg2 andLayer:(id)arg3;
- (void)clearDragAcceptanceMap;
- (void)importURLs:(id)arg1;
- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4;
- (BOOL)filtersWithBlacklist;
- (unsigned int)springboardType;
- (id)rootLayerForDragging;
- (id)containerWindow;
- (void)setVisible:(BOOL)arg1 slow:(BOOL)arg2;
- (int)defaultFilter;
- (BOOL)showsDock;
- (void)dealloc;
- (id)init;

@end

