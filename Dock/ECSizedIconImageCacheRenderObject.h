/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSObject.h"

@interface ECSizedIconImageCacheRenderObject : NSObject
{
    struct OpaqueIconRef *_icon;
    unsigned short _size;
    float _scaleFactor;
    struct _CARenderImage *_image;
    unsigned int _count;
}

@property(readonly, nonatomic) unsigned short size; // @synthesize size=_size;
@property(readonly, nonatomic) struct OpaqueIconRef *icon; // @synthesize icon=_icon;
@property(readonly, nonatomic) struct _CARenderImage *image; // @synthesize image=_image;
- (void)removeEntry;
- (id)entry;
- (void)dealloc;
- (id)initWithIcon:(struct OpaqueIconRef *)arg1 andSize:(int)arg2 usingScaleFactor:(float)arg3;

@end

