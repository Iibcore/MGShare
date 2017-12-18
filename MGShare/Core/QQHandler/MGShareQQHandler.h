//
//  MGShareQQHandler.h
//  MGShareExample
//
//  Created by Luqiang on 2017/6/5.
//  Copyright © 2017年 libcore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TencentOpenAPI/TencentOAuth.h"
#import "TencentOpenAPI/QQApiInterface.h"


/*! @brief 请求发送场景
 *
 */
enum QQScene {
    QQSceneQQ  = 0,        /**< 聊天界面    */
    QQSceneQZone = 1,        /**< 空间      */
};

@interface MGShareQQHandler : NSObject

+ (BOOL)handleOpenURL:(NSURL *)url delegate:(id<QQApiInterfaceDelegate>)delegate;

+ (TencentOAuth *)registerApp:(NSString *)appId delegate:(id<TencentSessionDelegate>)delegate;
+ (BOOL)iphoneQQInstalled;
+ (BOOL)iphoneQZoneInstalled;

+ (QQApiSendResultCode)sendText:(NSString *)text
                        inScene:(enum QQScene)scene;
+ (QQApiSendResultCode)sendOriginalImage:(UIImage *)originalImage
                            previewImage:(UIImage *)preImage
                                   title:(NSString *)title
                             description:(NSString *)description
                                 inScene:(enum QQScene)scene;
+ (QQApiSendResultCode)sendLinkURL:(NSString *)url
                             Title:(NSString *)title
                       Description:(NSString *)description
                        ThumbImage:(UIImage *)thumbImage
                           InScene:(enum QQScene)scene;

@end










