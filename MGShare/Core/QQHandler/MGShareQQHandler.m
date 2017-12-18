//
//  MGShareQQHandler.m
//  MGShareExample
//
//  Created by Luqiang on 2017/6/5.
//  Copyright © 2017年 libcore. All rights reserved.
//

#import "MGShareQQHandler.h"

@implementation MGShareQQHandler

+ (BOOL)handleOpenURL:(NSURL *)url delegate:(id<QQApiInterfaceDelegate>)delegate {
    return [QQApiInterface handleOpenURL:url delegate:delegate];
}

+ (TencentOAuth *)registerApp:(NSString *)appId delegate:(id<TencentSessionDelegate>)delegate {
    return [[TencentOAuth alloc] initWithAppId:appId andDelegate:delegate];
}

+ (BOOL)iphoneQQInstalled {
    return [TencentOAuth iphoneQQInstalled];
}

+ (BOOL)iphoneQZoneInstalled {
    return [TencentOAuth iphoneQZoneInstalled];
}

+ (QQApiSendResultCode)sendText:(NSString *)text
                        inScene:(enum QQScene)scene {
    if (scene == QQSceneQQ) {
        return [MGShareQQHandler sendToQQText:text];
    } else {
        return [MGShareQQHandler sendToQZoneText:text];
    }
}

+ (QQApiSendResultCode)sendOriginalImage:(UIImage *)originalImage
                            previewImage:(UIImage *)preImage
                                   title:(NSString *)title
                             description:(NSString *)description
                                 inScene:(enum QQScene)scene {
    if (scene == QQSceneQQ) {
        return [MGShareQQHandler sendToQQOriginalImage:originalImage previewImage:preImage title:title description:description];
    } else {
        return [MGShareQQHandler sendToQZoneOriginalImage:originalImage previewImage:preImage title:title description:description];
    }
}

+ (QQApiSendResultCode)sendLinkURL:(NSString *)url
                             Title:(NSString *)title
                       Description:(NSString *)description
                        ThumbImage:(UIImage *)thumbImage
                           InScene:(enum QQScene)scene {
    NSURL *link = [NSURL URLWithString:url];
    
    QQApiNewsObject* imgObj = [QQApiNewsObject objectWithURL:link title:title description:description previewImageData:UIImagePNGRepresentation(thumbImage)];
    if (scene == QQSceneQZone) {
        [imgObj setCflag:kQQAPICtrlFlagQZoneShareOnStart];
    }
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:imgObj];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    return sent;
}




#pragma mark - Private Method
+ (QQApiSendResultCode)sendToQQText:(NSString *)text {
    QQApiTextObject *txtObj = [QQApiTextObject objectWithText:text];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:txtObj];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    return sent;
}

+ (QQApiSendResultCode)sendToQZoneText:(NSString *)text {
    QQApiImageArrayForQZoneObject *obj = [QQApiImageArrayForQZoneObject objectWithimageDataArray:nil title:text];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:obj];
    QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
    return sent;
}

+ (QQApiSendResultCode)sendToQQOriginalImage:(UIImage *)originalImage
                            previewImage:(UIImage *)preImage
                                   title:(NSString *)title
                             description:(NSString *)description {
    NSData* data = UIImagePNGRepresentation(originalImage);
    
    QQApiImageObject* img = [QQApiImageObject objectWithData:data previewImageData:data title:nil description:nil];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    return sent;
}

+ (QQApiSendResultCode)sendToQZoneOriginalImage:(UIImage *)originalImage
                                previewImage:(UIImage *)preImage
                                       title:(NSString *)title
                                 description:(NSString *)description {
    QQApiImageArrayForQZoneObject *img = [QQApiImageArrayForQZoneObject objectWithimageDataArray:[NSArray arrayWithObject:UIImagePNGRepresentation(originalImage)] title:nil];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
    return sent;
}

@end
