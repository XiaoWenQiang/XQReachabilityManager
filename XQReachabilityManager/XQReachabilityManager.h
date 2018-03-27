//
//  XQReachabilityManager.h
//  XQReachabilityManagerExample
//
//  Created by xiao qiang on 2018/3/27.
//  Copyright © 2018年 xiao qiang. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"

/** 检测网络 */
UIKIT_EXTERN NSString * const kReachability;
/** 没有网络 */
UIKIT_EXTERN NSString * const kNotReachable;
/** 有网络 */
UIKIT_EXTERN NSString * const kHaveNetwork;
/** 已连接WiFi */
UIKIT_EXTERN NSString * const kViaWiFi;
/** 正在使用手机流量 */
UIKIT_EXTERN NSString * const kViaWWAN;

@interface XQReachabilityManager : NSObject

+ (instancetype)sharedInstance;

- (void)reachabilityWithNotification:(NSNotification *)notification myReach:(Reachability *)myReach;

- (BOOL)hasViaWWAN;

- (BOOL)hasViaWiFi;

- (BOOL)hasNotReachable;

- (BOOL)currentReachabilityStatus;

- (BOOL)isWifiReachabilityStatus;

@end
