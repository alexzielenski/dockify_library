/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSObject.h"

@interface DOCKMinimizedWindow : NSObject
{
}

+ (id)allWindows;
+ (id)windowsForPSN:(struct CPSProcessSerNum)arg1;
+ (void)removeAllWindowsForPSN:(struct CPSProcessSerNum)arg1;
+ (void)remove:(unsigned int)arg1 forPSN:(struct CPSProcessSerNum)arg2;
+ (id)add:(unsigned int)arg1 displayName:(id)arg2 forPSN:(struct CPSProcessSerNum)arg3;

@end

