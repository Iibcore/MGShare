//
//  WXMediaMessage+MGShare.h
//  MGShareExample
//
//  Created by Luqiang on 2017/6/5.
//  Copyright © 2017年 libcore. All rights reserved.
//

#import "WXApiObject.h"

@interface WXMediaMessage (MGShare)

+ (WXMediaMessage *)messageWithTitle:(NSString *)title
                         Description:(NSString *)description
                              Object:(id)mediaObject
                          MessageExt:(NSString *)messageExt
                       MessageAction:(NSString *)action
                          ThumbImage:(UIImage *)thumbImage
                            MediaTag:(NSString *)tagName;

@end
