//
//  ViewController.m
//  XQReachabilityManagerExample
//
//  Created by xiao qiang on 2018/3/27.
//  Copyright © 2018年 xiao qiang. All rights reserved.
//

#import "ViewController.h"
#import "XQReachabilityManagerHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([XQReachabilityManager sharedInstance].hasNotReachable) {
        [self checkAppNetworkIsOpenWithTitle:@"无网络" prompt:@""];
    }
}


@end
