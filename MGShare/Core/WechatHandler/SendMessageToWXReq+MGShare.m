//
//  SendMessageToWXReq+MGShare.m
//  MGShareExample
//
//  Created by Luqiang on 2017/6/5.
//  Copyright © 2017年 libcore. All rights reserved.
//

#import "SendMessageToWXReq+MGShare.h"

@implementation SendMessageToWXReq (MGShare)

+ (SendMessageToWXReq *)requestWithText:(NSString *)text InScene:(enum WXScene)scene {
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = YES;
    req.scene = scene;
    req.text = text;
    return req;
}
+ (SendMessageToWXReq *)requestWithMediaMessage:(WXMediaMessage *)message InScene:(enum WXScene)scene {
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.scene = scene;
    req.message = message;
    return req;
}

@end
