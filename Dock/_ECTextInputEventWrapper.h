/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSObject.h"

@interface _ECTextInputEventWrapper : NSObject
{
    struct _CGSEventRecord _event;
}

+ (id)wrapperWithEvent:(const struct _CGSEventRecord *)arg1;
@property(readonly, nonatomic) struct _CGSEventRecord *event;
- (id)initWithEvent:(const struct _CGSEventRecord *)arg1;

@end
