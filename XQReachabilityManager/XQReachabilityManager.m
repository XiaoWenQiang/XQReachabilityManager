//
//  XQReachabilityManager.m
//  XQReachabilityManagerExample
//
//  Created by xiao qiang on 2018/3/27.
//  Copyright © 2018年 xiao qiang. All rights reserved.
//



#import "XQReachabilityManager.h"

@interface XQReachabilityManager ()

@property (nonatomic, strong) Reachability *reach;
@property (nonatomic, strong) Reachability *wifi;
@property (nonatomic, strong) Reachability *conn;

@end

static XQReachabilityManager *_reachabilityManager = nil;

/** 检测网络 */
NSString * const kReachability = @"kReachability";
/** 没有网络 */
NSString * const kNotReachable = @"kNotReachable";
/** 有网络 */
NSString * const kHaveNetwork = @"kHaveNetwork";
/** 已连接WiFi */
NSString * const kViaWiFi = @"kViaWiFi";
/** 正在使用手机流量 */
NSString * const kViaWWAN = @"kViaWWAN";

@implementation XQReachabilityManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        _reachabilityManager = [[self alloc] init];
    });
    return _reachabilityManager;
}

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:)  name:kReachabilityChangedNotification  object:nil];
        self.reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
        [self.reach startNotifier]; //启动一个run loop
    }
    return self;
}

- (void)reachabilityChanged:(NSNotification *)noti {
    [self reachabilityWithNotification:noti myReach:self.reach];
}

- (void)reachabilityWithNotification:(NSNotification *)notification myReach:(Reachability *)myReach {
    Reachability *reach = [notification object];
    myReach = reach;
    self.reach = reach;
    self.wifi = [Reachability reachabilityForLocalWiFi];
    self.conn = [Reachability reachabilityForInternetConnection];
    
    // 3.判断网络状态
    if ([self.wifi currentReachabilityStatus] != NotReachable) { // 有wifi
        [[NSNotificationCenter defaultCenter] postNotificationName:kViaWiFi object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:kHaveNetwork object:nil];
    } else if ([self.conn currentReachabilityStatus] != NotReachable) { // 没有使用wifi, 使用手机自带网络进行上网
        [[NSNotificationCenter defaultCenter] postNotificationName:kViaWWAN object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:kHaveNetwork object:nil];
    } else { // 没有网络
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotReachable object:nil];
    }
}

- (BOOL)hasViaWWAN {
    return [self.conn currentReachabilityStatus] == ReachableViaWWAN;
}

- (BOOL)hasViaWiFi {
    return [self.wifi currentReachabilityStatus] != NotReachable;
}

- (BOOL)hasNotReachable {
    return [self.reach currentReachabilityStatus] == NotReachable;
}

- (BOOL)currentReachabilityStatus {
    if ([self.wifi currentReachabilityStatus] != NotReachable) {
        return YES;
    } else if ([self.conn currentReachabilityStatus] != NotReachable) {
        return YES;
    }
    return NO;
}

- (BOOL)isWifiReachabilityStatus {
    if ([self.wifi currentReachabilityStatus] != NotReachable) {
        return YES;
    } else if ([self.conn currentReachabilityStatus] != NotReachable) {
        return NO;
    }
    return NO;
}

@end

