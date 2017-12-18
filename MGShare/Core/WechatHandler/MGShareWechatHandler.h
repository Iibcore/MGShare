//
//  MGShareWechatHandler.h
//  MGShareExample
//
//  Created by Luqiang on 2017/6/5.
//  Copyright © 2017年 libcore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@interface MGShareWechatHandler : NSObject

+ (BOOL)handleOpenURL:(NSURL *)url delegate:(id<WXApiDelegate>)delegate;

+ (BOOL)registerApp:(NSString *)appId enableMTA:(BOOL)isEnableMTA;
+ (BOOL)isWXAppInstalled;

+ (BOOL)sendText:(NSString *)text
         InScene:(enum WXScene)scene;
+ (BOOL)sendImageData:(NSData *)imageData
              TagName:(NSString *)tagName
           MessageExt:(NSString *)messageExt
               Action:(NSString *)action
           ThumbImage:(UIImage *)thumbImage
              InScene:(enum WXScene)scene;
+ (BOOL)sendLinkURL:(NSString *)urlString
            TagName:(NSString *)tagName
              Title:(NSString *)title
        Description:(NSString *)description
         ThumbImage:(UIImage *)thumbImage
            InScene:(enum WXScene)scene;


@end
