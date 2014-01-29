/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSObject.h"

@class ECSBItemLayer, NSMutableArray;

@interface ECSBItem : NSObject
{
    ECSBItem *_parent;
    id _clientItem;
    ECSBItemLayer *_itemLayer;
}

@property(nonatomic) ECSBItemLayer *itemLayer; // @synthesize itemLayer=_itemLayer;
@property(nonatomic) id clientItem; // @synthesize clientItem=_clientItem;
@property(nonatomic) ECSBItem *parent; // @synthesize parent=_parent;
- (id)valueForKey:(id)arg1 withHandler:(id)arg2 andInfo:(id)arg3;
- (id)description;
@property(retain, nonatomic) NSMutableArray *items; // @dynamic items;
- (void)dealloc;
- (id)init;

@end

