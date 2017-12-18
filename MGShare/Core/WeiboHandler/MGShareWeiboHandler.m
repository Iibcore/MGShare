//
//  MGShareWeiboHandler.m
//  MGShareExample
//
//  Created by Luqiang on 2017/6/5.
//  Copyright © 2017年 libcore. All rights reserved.
//

#import "MGShareWeiboHandler.h"

@implementation MGShareWeiboHandler

+ (BOOL)handleOpenURL:(NSURL *)url delegate:(id<WeiboSDKDelegate>)delegate {
    return [WeiboSDK handleOpenURL:url delegate:delegate];
}

+ (BOOL)registerApp:(NSString *)appId {
    return [WeiboSDK registerApp:appId];
}

+ (BOOL)isWeiboAppInstalled {
    return [WeiboSDK isWeiboAppInstalled];
}

+ (BOOL)sendText:(NSString *)text {
    WBMessageObject *message = [WBMessageObject message];
    message.text = text;
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
    return [WeiboSDK sendRequest:request];
}

+ (BOOL)sendImageData:(NSData *)imageData {
    WBMessageObject *message = [WBMessageObject message];
    WBImageObject *image = [WBImageObject object];
    image.imageData = imageData;
    message.imageObject = image;
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
    return [WeiboSDK sendRequest:request];
}

+ (BOOL)sendLinkURL:(NSString *)url title:(NSString *)title description:(NSString *)description thumbnailData:(NSData *)thumbData {
    WBMessageObject *message = [WBMessageObject message];
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = @"objectID";
    webpage.title = title;
    webpage.description = description;
    webpage.thumbnailData = thumbData;
    webpage.webpageUrl = url;
    message.mediaObject = webpage;
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
    return [WeiboSDK sendRequest:request];
}

@end
