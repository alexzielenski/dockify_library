/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSObject.h"

@interface ECFSRef : NSObject
{
    struct FSRef _ref;
}

+ (id)fsrefWithFSRef:(const struct FSRef *)arg1;
@property(readonly, nonatomic) const struct FSRef *fsref; // @dynamic fsref;
- (id)initWithFSRef:(const struct FSRef *)arg1;

@end
