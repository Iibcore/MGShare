//
//  MGShareWechatHandler.m
//  MGShareExample
//
//  Created by Luqiang on 2017/6/5.
//  Copyright © 2017年 libcore. All rights reserved.
//

#import "MGShareWechatHandler.h"
#import "SendMessageToWXReq+MGShare.h"
#import "WXMediaMessage+MGShare.h"

@implementation MGShareWechatHandler

+ (BOOL)handleOpenURL:(NSURL *)url delegate:(id<WXApiDelegate>)delegate {
    return [WXApi handleOpenURL:url delegate:delegate];
}

+ (BOOL)registerApp:(NSString *)appId enableMTA:(BOOL)isEnableMTA {
    return [WXApi registerApp:appId enableMTA:isEnableMTA];
}

+ (BOOL)isWXAppInstalled {
    return [WXApi isWXAppInstalled];
}

+ (BOOL)sendText:(NSString *)text
         InScene:(enum WXScene)scene {
    SendMessageToWXReq *req = [SendMessageToWXReq requestWithText:text InScene:scene];
    return [WXApi sendReq:req];
}

+ (BOOL)sendImageData:(NSData *)imageData
              TagName:(NSString *)tagName
           MessageExt:(NSString *)messageExt
               Action:(NSString *)action
           ThumbImage:(UIImage *)thumbImage
              InScene:(enum WXScene)scene {
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = imageData;
    WXMediaMessage *message = [WXMediaMessage messageWithTitle:nil
                                                   Description:nil
                                                        Object:ext
                                                    MessageExt:messageExt
                                                 MessageAction:action
                                                    ThumbImage:thumbImage
                                                      MediaTag:tagName];
    SendMessageToWXReq* req = [SendMessageToWXReq requestWithMediaMessage:message InScene:scene];
    return [WXApi sendReq:req];
}

+ (BOOL)sendLinkURL:(NSString *)urlString
            TagName:(NSString *)tagName
              Title:(NSString *)title
        Description:(NSString *)description
         ThumbImage:(UIImage *)thumbImage
            InScene:(enum WXScene)scene {
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = urlString;
    WXMediaMessage *message = [WXMediaMessage messageWithTitle:title
                                                   Description:description
                                                        Object:ext
                                                    MessageExt:nil
                                                 MessageAction:nil
                                                    ThumbImage:thumbImage
                                                      MediaTag:tagName];
    SendMessageToWXReq* req = [SendMessageToWXReq requestWithMediaMessage:message InScene:scene];
    return [WXApi sendReq:req];
}

@end
