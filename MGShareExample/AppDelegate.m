//
//  AppDelegate.m
//  MGShareExample
//
//  Created by Luqiang on 2017/6/1.
//  Copyright © 2017年 libcore. All rights reserved.
//

#import "AppDelegate.h"
#import "MGShare.h"

#define EXAMPLE_WECHAT_APPID @"wx5452f4e4216cf257"//bundle id:com.mango.libcore
#define EXAMPLE_QQ_APPID @"1106280575"//bundle id:com.mango.libcore
#define EXAMPLE_WEIBO_APPKEY @"4135917762"//bundle id:com.mango.libcore

#define EXAMPLR_WEIXIN_SCHEME @"wx5452f4e4216cf257"
#define EXAMPLR_QQ_SCHEME @"QQ41F0807F"
#define EXAMPLR_WEIBO_SCHEME @"wb4135917762"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[MGShare sharedInstance] registerShareForWechat:EXAMPLE_WECHAT_APPID enableMTA:NO];
    [[MGShare sharedInstance] registerShareForQQ:EXAMPLE_QQ_APPID];
    [[MGShare sharedInstance] registerShareForWeibo:EXAMPLE_WEIBO_APPKEY];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    NSLog(@"%@-%@-%@", url.absoluteString, url.relativeString, url.scheme);
    return [self handleOpenURL:url];
}

- (BOOL)handleOpenURL:(NSURL *)url {
    if ([url.scheme isEqualToString:EXAMPLR_WEIXIN_SCHEME]) {
        return [[MGShare sharedInstance] wechatHandleOpenURL:url];
    }
    if ([url.scheme isEqualToString:EXAMPLR_QQ_SCHEME]) {
        return [[MGShare sharedInstance] qqHandleOpenURL:url];
    }
    if ([url.scheme isEqualToString:EXAMPLR_WEIBO_SCHEME]) {
        return [[MGShare sharedInstance] weiboHandleOpenURL:url];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
