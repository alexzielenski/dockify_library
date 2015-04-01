//
//  DKLabelLayer.m
//  Dockify
//
//  Created by Alexander Zielenski on 4/1/15.
//  Copyright (c) 2015 Alexander Zielenski. All rights reserved.
//

#import "Dockify.h"
#import "DOCKLabelLayer.h"

ZKSwizzleInterface(DKLabelLayer, DOCKLabelLayer, CALayer)
@implementation DKLabelLayer

- (void)update {
    ZKOrig(void);
    
    self.opacity = 0.5;
    CALayer *backdrop = ZKHookIvar(self, CALayer *, "_backdrop");
    CALayer *content = [backdrop valueForKey:@"contentLayer"];
    
    if (backdrop.contents) {
        NSLog(@"bdrop %@", backdrop.contents);
    }
    
    if (content.contents) {
        NSLog(@"cnts %@", content.contents);
//        CGImageRef image = (__bridge CGImageRef)(content.contents);
        NSLog(@"%@", backdrop.shadowPath);
        NSLog(@"%@", backdrop.backgroundColor);
//        [[[[NSBitmapImageRep alloc] initWithCGImage:image] representationUsingType:NSPNGFileType properties:nil] writeToFile:@"/Users/Alex/Desktop/a.png" atomically:NO];
    }

}

@end

ZKSwizzleInterface(DKTile, Tile, NSObject)

@interface DKTile (asd)
- (void)setLabel:(id)arg1 stripAppSuffix:(_Bool)arg2;
- (void)update;
@end
@implementation DKTile

- (id)statusLabelForType:(int)arg1 {
    NSLog(@"%d %@", arg1, ZKOrig(id, arg1));
    return ZKOrig(id, arg1);
}

- (void)update {
    ZKOrig(void);
    
    [self setLabel:@"TEST" stripAppSuffix:false];
}

- (void)setStatusLabel:(id)arg1 forType:(int)arg2 {
    
    ZKOrig(void, arg1, arg2);
}

@end
