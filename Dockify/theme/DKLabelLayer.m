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
//        NSLog(@"bdrop %@", backdrop.contents);
    }
    
    if (content.contents) {
//        NSLog(@"cnts %@", content.contents);
//        CGImageRef image = (__bridge CGImageRef)(content.contents);
//        NSLog(@"%@", backdrop.shadowPath);
//        NSLog(@"%@", backdrop.backgroundColor);
//        [[[[NSBitmapImageRep alloc] initWithCGImage:image] representationUsingType:NSPNGFileType properties:nil] writeToFile:@"/Users/Alex/Desktop/a.png" atomically:NO];
    }

}

@end

