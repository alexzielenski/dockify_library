/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSObject.h"

@class NSObject<OS_xpc_object>, NSSet;

@interface _DockNotificationCenterBadgeConnection : NSObject
{
    BOOL _needsAuthentication;
    BOOL _serverConnectionFailure;
    NSObject<OS_xpc_object> *_connection;
    NSSet *_badgesDisabledForBundleIdentifiers;
}

- (id)_serverConnection;
- (void)_got_server_keep_alive:(id)arg1;
- (void)_send_connection_authentication;
- (void)_handleDisabledBadgesSet:(id)arg1;
- (void)_handleDockBadgeSet:(id)arg1;
- (BOOL)badgesDisabledForIdentifier:(id)arg1;
- (void)tellNCAboutDeletedApp:(id)arg1;
- (id)init;

@end
