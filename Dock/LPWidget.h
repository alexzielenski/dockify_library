/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "LPRunnable.h"

@interface LPWidget : LPRunnable
{
}

- (BOOL)_collectWidgetInfoForURL:(id)arg1;
- (void)_updateFlagsForURL:(id)arg1;
- (void)loadImagesFromURL:(id)arg1 mini:(unsigned long long)arg2 large:(unsigned long long)arg3 images:(id)arg4;
- (id)categoryUTI;
- (void)dealloc;
- (id)snapshot:(BOOL)arg1;
- (id)initWithURL:(id)arg1 forScan:(unsigned int)arg2;
- (void)insertIntoStorage:(id)arg1 parent:(id)arg2 withOrder:(long long)arg3;
- (id)storageTable;
- (id)storageCreationProperties;
- (id)storageColumnForProperty:(id)arg1;
- (int)storageType;
- (id)initWithSQLStatement:(struct sqlite3_stmt *)arg1 withColumn:(int *)arg2;

@end

