/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "ECSBItem.h"

@class ECSBPage, NSMutableArray;

@interface ECSBPageItem : ECSBItem
{
    ECSBPage *_page;
    NSMutableArray *_items;
}

@property(retain, nonatomic) NSMutableArray *items; // @synthesize items=_items;
@property(nonatomic) ECSBPage *page; // @synthesize page=_page;
- (void)dealloc;
- (id)init;

@end

