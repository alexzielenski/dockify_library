/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSObject.h"

@class NSArray, NSMutableArray, NSString;

@interface LPStorageTransaction : NSObject
{
    NSMutableArray *_blocks;
    NSString *_uuid;
    int _dbref;
}

@property(readonly, nonatomic) NSString *uuid; // @synthesize uuid=_uuid;
@property(readonly, nonatomic) NSArray *blocks; // @synthesize blocks=_blocks;
@property(readonly, nonatomic) int dbref; // @synthesize dbref=_dbref;
- (void)addBlock:(id)arg1;
- (void)dealloc;
- (id)initWithDatabaseReference:(int)arg1;

@end

