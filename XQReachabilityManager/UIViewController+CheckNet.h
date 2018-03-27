//
//  UIViewController+CheckNet.h
//  XQReachabilityManagerExample
//
//  Created by xiao qiang on 2018/3/27.
//  Copyright © 2018年 xiao qiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CheckNet) <UIAlertViewDelegate>

- (void)checkAppNetworkIsOpen;

- (void)checkAppNetworkIsOpenWithTitle:(NSString *)title prompt:(NSString *)prompt;

@end
