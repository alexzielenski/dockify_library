/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSObject.h"

@class NSDictionary;

@interface LPCompletionBlock : NSObject
{
    id _block;
    NSDictionary *_userinfo;
    unsigned int _identifier;
}

@property(retain, nonatomic) NSDictionary *userinfo; // @synthesize userinfo=_userinfo;
@property(nonatomic) unsigned int identifier; // @synthesize identifier=_identifier;
- (void)invalidate;
- (void)dealloc;
- (id)initCompletionBlock:(id)arg1;

@end

