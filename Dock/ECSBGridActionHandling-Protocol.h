/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSObject-Protocol.h"

@protocol ECSBGridActionHandling <NSObject>
- (void)performGridActionAtIndex:(unsigned long long)arg1 withEvent:(id)arg2 sender:(id)arg3;

@optional
- (BOOL)performDropAtIndex:(unsigned long long)arg1 withEvent:(id)arg2 sender:(id)arg3;
- (BOOL)canAcceptDropAtIndex:(unsigned long long)arg1 withEvent:(id)arg2 sender:(id)arg3;
- (void)hideGroup:(id)arg1 withOffset:(double)arg2 sender:(id)arg3;
- (void)showGroup:(id)arg1 withOffset:(double)arg2 sender:(id)arg3;
- (void)prepareToShowGroup:(id)arg1 atRect:(struct CGRect)arg2 withOffset:(double)arg3 sender:(id)arg4;
- (void)gridItemSelectedAtIndex:(unsigned long long)arg1 sender:(id)arg2;
- (void)cancelGridActionWithEvent:(id)arg1 sender:(id)arg2;
@end

