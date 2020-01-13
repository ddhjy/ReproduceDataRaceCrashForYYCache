//
//  ViewController.m
//  ReproduceDataRaceCrashForYYCache
//
//  Created by 曾凯 on 2020/1/13.
//  Copyright © 2020 曾凯. All rights reserved.
//

#import "ViewController.h"
#import <YYCache/YYCache.h>

@interface ViewController ()
@property (nonatomic, strong) YYMemoryCache *memoryCache;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.memoryCache = [YYMemoryCache new];
    self.memoryCache.name = @"demo";
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (true) {
            [NSThread sleepForTimeInterval:0.00000000000001];
            [self.memoryCache setObject:[NSObject new] forKey:@"content"];
        }
    });

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (true) {
            [NSThread sleepForTimeInterval:0.00000000000001];
            NSObject *content = (NSObject *)[self.memoryCache objectForKey:@"content"];
            if ([content isKindOfClass:[NSObject class]]) {
                NSLog(@"content: %@", content);
            }
        }
    });
}



@end
