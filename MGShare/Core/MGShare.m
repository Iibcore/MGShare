//
//  MGShare.m
//  MGShareExample
//
//  Created by Luqiang on 2017/6/1.
//  Copyright © 2017年 libcore. All rights reserved.
//

#import "MGShare.h"
#import "MGShareWechatHandler.h"
#import "MGShareQQHandler.h"
#import "MGShareWeiboHandler.h"

@interface MGShare () <WXApiDelegate, TencentSessionDelegate, WeiboSDKDelegate, QQApiInterfaceDelegate>

@property (nonatomic, assign) BOOL isRegisterWechat;
@property (nonatomic, assign) BOOL isRegisterQQ;
@property (nonatomic, assign) BOOL isRegisterWeibo;


@property (nonatomic, strong) id tencentOAuth;

@end

@implementation MGShare

+ (MGShare *)sharedInstance {
    static MGShare *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MGShare alloc] init];
    });
    return instance;
}

#pragma mark - Wechat

- (BOOL)registerShareForWechat:(NSString *)appId enableMTA:(BOOL)isEnableMTA {
    self.isRegisterWechat = [MGShareWechatHandler registerApp:appId enableMTA:isEnableMTA];
    return self.isRegisterWechat;
}

- (BOOL)wechatHandleOpenURL:(NSURL *)url {
    return [MGShareWechatHandler handleOpenURL:url delegate:self];
}

#pragma mark - WXApiDelegate

- (void)onReq:(BaseReq*)req {
    NSLog(@"WXApiDelegate->onReq");
}

#pragma mark - WX And QQ Delegate
- (void)onResp:(id)resp {
    if ([resp isKindOfClass:[BaseResp class]]) {
        BaseResp *realResp = (BaseResp *)resp;
        if (realResp.errCode == 0) {
            [self _handleMGShareResult:YES];
        } else {
            [self _handleMGShareResult:NO];
        }
    }
    if ([resp isKindOfClass:[QQBaseResp class]]) {
        QQBaseResp *realResp = (QQBaseResp *)resp;
        if ([@"0" isEqualToString:realResp.result]) {
            [self _handleMGShareResult:YES];
        } else {
            [self _handleMGShareResult:NO];
        }
    }
}

#pragma mark - QQ

- (BOOL)registerShareForQQ:(NSString *)appId {
    self.tencentOAuth = [MGShareQQHandler registerApp:appId delegate:self];
    self.isRegisterQQ = self.tencentOAuth ? YES : NO;
    return self.isRegisterQQ;
}

- (BOOL)qqHandleOpenURL:(NSURL *)url {
    return [MGShareQQHandler handleOpenURL:url delegate:self];
}

#pragma mark - TencentLoginDelegate
- (void)tencentDidLogin {}
- (void)tencentDidNotLogin:(BOOL)cancelled {}
- (void)tencentDidNotNetWork {}

#pragma mark - handleSendResult
- (void)handleQQSendResult:(QQApiSendResultCode)code {
    NSLog(@"handleQQSendResult->code:%d", code);
}

#pragma mark - Weibo

- (BOOL)registerShareForWeibo:(NSString *)appKey {
    self.isRegisterWeibo = [MGShareWeiboHandler registerApp:appKey];
    return self.isRegisterWeibo;
}

- (BOOL)weiboHandleOpenURL:(NSURL *)url {
    return [MGShareWeiboHandler handleOpenURL:url delegate:[MGShare sharedInstance]];
}

#pragma mark - WeiboSDKDelegate

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    NSLog(@"WeiboSDKDelegate->request");
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    NSLog(@"WeiboSDKDelegate->response.statusCode:%ld", (long)response.statusCode);
    if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
        [self _handleMGShareResult:YES];
    } else {
        [self _handleMGShareResult:NO];
    }
}


#pragma mark - MGShare Method

- (void)sendText:(NSString *)text type:(MGShareType)type {
    if (![self _handleMGShareType:type]) {
        return;
    }
    switch (type) {
        case MGShareTypeWechatSession:
        {
            [MGShareWechatHandler sendText:text InScene:WXSceneSession];
        }
            break;
        case MGShareTypeWechatTimeline:
        {
            [MGShareWechatHandler sendText:text InScene:WXSceneTimeline];
        }
            break;
        case MGShareTypeWechatFavorite:
        {
            [MGShareWechatHandler sendText:text InScene:WXSceneFavorite];
        }
            break;
        case MGShareTypeQQ:
        {
            [self handleQQSendResult:[MGShareQQHandler sendText:text inScene:QQSceneQQ]];
        }
            break;
        case MGShareTypeQZone:
        {
            [self handleQQSendResult:[MGShareQQHandler sendText:text inScene:QQSceneQZone]];
        }
            break;
        case MGShareTypeWeibo:
        {
            [MGShareWeiboHandler sendText:text];
        }
            break;
        default:
            break;
    }
}

- (void)sendOriginalImage:(UIImage *)originImage thumbnailImage:(UIImage *)thumbImage type:(MGShareType)type {
    if (![self _handleMGShareType:type]) {
        return;
    }
    switch (type) {
        case MGShareTypeWechatSession:
        {
            [MGShareWechatHandler sendImageData:UIImagePNGRepresentation(originImage) TagName:nil MessageExt:nil Action:nil ThumbImage:thumbImage InScene:WXSceneSession];
        }
            break;
        case MGShareTypeWechatTimeline:
        {
            [MGShareWechatHandler sendImageData:UIImagePNGRepresentation(originImage) TagName:nil MessageExt:nil Action:nil ThumbImage:thumbImage InScene:WXSceneTimeline];
        }
            break;
        case MGShareTypeWechatFavorite:
        {
            [MGShareWechatHandler sendImageData:UIImagePNGRepresentation(originImage) TagName:nil MessageExt:nil Action:nil ThumbImage:thumbImage InScene:WXSceneFavorite];
        }
            break;
        case MGShareTypeQQ:
        {
            [self handleQQSendResult:[MGShareQQHandler sendOriginalImage:originImage previewImage:thumbImage title:nil description:nil inScene:QQSceneQQ]];
        }
            break;
        case MGShareTypeQZone:
        {
            [self handleQQSendResult:[MGShareQQHandler sendOriginalImage:originImage previewImage:thumbImage title:nil description:nil inScene:QQSceneQZone]];
        }
            break;
        case MGShareTypeWeibo:
        {
            [MGShareWeiboHandler sendImageData:UIImagePNGRepresentation(originImage)];
        }
            break;
        default:
            break;
    }
}

- (void)sendLinkURL:(NSString *)url title:(NSString *)title description:(NSString *)description thumbnailImage:(UIImage *)thumbImage type:(MGShareType)type {
    if (![self _handleMGShareType:type]) {
        return;
    }
    switch (type) {
        case MGShareTypeWechatSession:
        {
            [MGShareWechatHandler sendLinkURL:url TagName:nil Title:title Description:description ThumbImage:thumbImage InScene:WXSceneSession];
        }
            break;
        case MGShareTypeWechatTimeline:
        {
            [MGShareWechatHandler sendLinkURL:url TagName:nil Title:title Description:description ThumbImage:thumbImage InScene:WXSceneTimeline];
        }
            break;
        case MGShareTypeWechatFavorite:
        {
            [MGShareWechatHandler sendLinkURL:url TagName:nil Title:title Description:description ThumbImage:thumbImage InScene:WXSceneFavorite];
        }
            break;
        case MGShareTypeQQ:
        {
            [self handleQQSendResult:[MGShareQQHandler sendLinkURL:url Title:title Description:description ThumbImage:thumbImage InScene:QQSceneQQ]];
        }
            break;
        case MGShareTypeQZone:
        {
            [self handleQQSendResult:[MGShareQQHandler sendLinkURL:url Title:title Description:description ThumbImage:thumbImage InScene:QQSceneQZone]];
        }
            break;
        case MGShareTypeWeibo:
        {
            [MGShareWeiboHandler sendLinkURL:url title:title description:description thumbnailData:UIImagePNGRepresentation(thumbImage)];
        }
            break;
        default:
            break;
    }
}



#pragma mark - Private Method

- (void)_handleMGShareResult:(BOOL)status {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareResult:)]) {
        [self.delegate shareResult:status];
    }
}

- (BOOL)_handleMGShareType:(MGShareType)type {
    switch (type) {
        case MGShareTypeWechatSession:
        case MGShareTypeWechatTimeline:
        case MGShareTypeWechatFavorite:
        {
            if ([MGShareWechatHandler isWXAppInstalled]) {
                return YES;
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"未安装微信客户端" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                return NO;
            }
        }
            break;
            
        case MGShareTypeQQ:
        case MGShareTypeQZone:
        {
            if ([MGShareQQHandler iphoneQQInstalled]) {
                return YES;
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"未安装QQ客户端" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                return NO;
            }
        }
            break;
            
        case MGShareTypeWeibo:
        {
            if ([MGShareWeiboHandler isWeiboAppInstalled]) {
                return YES;
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"未安装微博客户端" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                return NO;
            }
        }
            break;
        default:
            break;
    }
    
    return NO;
}

@end
