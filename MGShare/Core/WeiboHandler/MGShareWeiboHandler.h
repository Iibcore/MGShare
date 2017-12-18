//
//  MGShareWeiboHandler.h
//  MGShareExample
//
//  Created by Luqiang on 2017/6/5.
//  Copyright © 2017年 libcore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"

@interface MGShareWeiboHandler : NSObject

+ (BOOL)handleOpenURL:(NSURL *)url delegate:(id<WeiboSDKDelegate>)delegate;

+ (BOOL)registerApp:(NSString *)appId;
+ (BOOL)isWeiboAppInstalled;

+ (BOOL)sendText:(NSString *)text;
+ (BOOL)sendImageData:(NSData *)imageData;
+ (BOOL)sendLinkURL:(NSString *)url title:(NSString *)title description:(NSString *)description thumbnailData:(NSData *)thumbData;


@end
