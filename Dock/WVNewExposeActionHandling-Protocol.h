/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "WVWindowActionHandling-Protocol.h"

@protocol WVNewExposeActionHandling <WVWindowActionHandling>
- (void)darkenBackground:(BOOL)arg1 forExpose:(id)arg2;
- (void)windowExposeDrag:(id)arg1 dragCompleteForSender:(id)arg2;
- (BOOL)windowExposeDrag:(id)arg1 droppedAtLocation:(struct CGPoint)arg2 sender:(id)arg3;
- (void)windowExposeDrag:(id)arg1 toLocation:(struct CGPoint)arg2 sender:(id)arg3;
- (void)windowExposeDrag:(id)arg1 startedAtLocation:(struct CGPoint)arg2 sender:(id)arg3;
- (void)windowExposeWillStartDragAtLocation:(struct CGPoint)arg1 sender:(id)arg2;
@end

