/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSObject-Protocol.h"

@protocol ECAlertPanelDelegate <NSObject>

@optional
- (id)layerForCenteringOfAlertPanel:(id)arg1;
- (void)alertPanel:(id)arg1 didDismissWithButtonIndex:(long long)arg2;
- (void)alertPanel:(id)arg1 willDismissWithButtonIndex:(long long)arg2;
- (void)didPresentAlertPanel:(id)arg1;
- (void)willPresentAlertPanel:(id)arg1;
- (void)alertPanelCancel:(id)arg1;
- (void)alertPanel:(id)arg1 clickedButtonIndex:(long long)arg2;
@end

