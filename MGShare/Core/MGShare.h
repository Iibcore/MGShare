//
//  MGShare.h
//  MGShareExample
//
//  Created by Luqiang on 2017/6/1.
//  Copyright © 2017年 libcore. All rights reserved.
//

/**
 *  分享类型：
 *  1.文本
 *  2.图片
 *  3.多媒体
 **/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MGShareType) {
    MGShareTypeWechatSession,
    MGShareTypeWechatTimeline,
    MGShareTypeWechatFavorite,
    MGShareTypeQQ,
    MGShareTypeQZone,
    MGShareTypeWeibo
};

@protocol MGShareDelegate <NSObject>

- (void)shareResult:(BOOL)status;

@end

@interface MGShare : NSObject

+ (MGShare *)sharedInstance;
@property (nonatomic, weak) id <MGShareDelegate> delegate;
- (BOOL)wechatHandleOpenURL:(NSURL *)url;
- (BOOL)qqHandleOpenURL:(NSURL *)url;
- (BOOL)weiboHandleOpenURL:(NSURL *)url;


- (BOOL)registerShareForWechat:(NSString *)appId enableMTA:(BOOL)isEnableMTA;
- (BOOL)registerShareForQQ:(NSString *)appId;
- (BOOL)registerShareForWeibo:(NSString *)appKey;


- (void)sendText:(NSString *)text type:(MGShareType)type;
- (void)sendOriginalImage:(UIImage *)originImage thumbnailImage:(UIImage *)thumbImage type:(MGShareType)type;//原图不能超过10M，缩略图不能超过32KB
- (void)sendLinkURL:(NSString *)url title:(NSString *)title description:(NSString *)description thumbnailImage:(UIImage *)thumbImage type:(MGShareType)type;






@end
