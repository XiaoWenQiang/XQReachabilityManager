//
//  UIViewController+CheckNet.m
//  XQReachabilityManagerExample
//
//  Created by xiao qiang on 2018/3/27.
//  Copyright © 2018年 xiao qiang. All rights reserved.
//

#import "UIViewController+CheckNet.h"
#import <objc/runtime.h>
#import "XQReachabilityManager.h"

#define strIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length]<1 ? YES : NO )


@implementation UIViewController (CheckNet)

- (void)checkAppNetworkIsOpen {
    [self checkAppNetworkIsOpenWithTitle:nil prompt:nil];
}

- (void)checkAppNetworkIsOpenWithTitle:(NSString *)title prompt:(NSString *)prompt {
    if (self.isAlertViewShow) {
        return;
    }
    if (![self isAlert]) {
        if ([XQReachabilityManager sharedInstance].hasNotReachable) {
            NSString *titleString = @"";
            if (strIsEmpty(title)) {
                titleString = @"网络连接出了问题";
            } else {
                titleString = title;
            }
            NSString *promptString = @"";
            if (strIsEmpty(prompt)) {
                promptString = @"请检查您的网络连接，或者进入“设置”中允许访问网络数据";
            } else {
                promptString = prompt;
            }
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:titleString message:promptString delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:@"去设置", nil];
            self.isAlertViewShow = YES;
            [alertView show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    self.isAlertViewShow = NO;
    if (buttonIndex == 1) {
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

- (BOOL)isAlert{
    if ([[UIApplication sharedApplication].keyWindow isMemberOfClass:[UIWindow class]]) {
        return NO;
    }
    return YES;
}

- (BOOL)isAlertViewShow {
    return [objc_getAssociatedObject(self, @"kXQIsAlertViewShowKey") boolValue];
}

- (void)setIsAlertViewShow:(BOOL)isAlertViewShow {
    objc_setAssociatedObject(self, @"kXQIsAlertViewShowKey", [NSNumber numberWithBool:isAlertViewShow], OBJC_ASSOCIATION_ASSIGN);
}


@end
