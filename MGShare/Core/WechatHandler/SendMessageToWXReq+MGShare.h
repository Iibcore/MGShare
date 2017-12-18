//
//  SendMessageToWXReq+MGShare.h
//  MGShareExample
//
//  Created by Luqiang on 2017/6/5.
//  Copyright © 2017年 libcore. All rights reserved.
//

#import "WXApiObject.h"

@interface SendMessageToWXReq (MGShare)

+ (SendMessageToWXReq *)requestWithText:(NSString *)text InScene:(enum WXScene)scene;
+ (SendMessageToWXReq *)requestWithMediaMessage:(WXMediaMessage *)message InScene:(enum WXScene)scene;

@end
