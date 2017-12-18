//
//  ExampleTableViewController.m
//  MGShareExample
//
//  Created by Luqiang on 2017/6/5.
//  Copyright © 2017年 libcore. All rights reserved.
//

#import "ExampleTableViewController.h"
#import "MGShare.h"

@interface ExampleTableViewController () <MGShareDelegate>

@property (nonatomic, assign) NSUInteger shareScene;
@property (nonatomic, strong) UIAlertController *alertVC;

@end

@implementation ExampleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MGShare sharedInstance].delegate = self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *title = cell.textLabel.text;
    if ([title isEqualToString:@"分享文本"]) {
        _shareScene = 1;
    }
    if ([title isEqualToString:@"分享图片"]) {
        _shareScene = 2;
    }
    if ([title isEqualToString:@"分享链接"]) {
        _shareScene = 3;
    }
    
    UIAlertController *alert = self.alertVC;
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)_sendShareWithPlatformScene:(NSUInteger)platformScene {
    switch (_shareScene) {
        case 1:
        {
            [[MGShare sharedInstance] sendText:@"分享文本内容" type:platformScene];
        }
            break;
        case 2:
        {
            [[MGShare sharedInstance] sendOriginalImage:[UIImage imageNamed:@"original.jpeg"] thumbnailImage:[UIImage imageNamed:@"thumbnail"] type:platformScene];
        }
            break;
        case 3:
        {
            [[MGShare sharedInstance] sendLinkURL:@"www.baidu.com" title:@"百度" description:@"百度一下" thumbnailImage:[UIImage imageNamed:@"thumbnail"] type:platformScene];

        }
            break;
            
        default:
            break;
    }
}

- (UIAlertController *)alertVC {
    if (!_alertVC) {
        _alertVC = [UIAlertController alertControllerWithTitle:@"平台" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        __weak typeof(self) weakSelf = self;
        [_alertVC addAction:[UIAlertAction actionWithTitle:@"微信会话" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf _sendShareWithPlatformScene:MGShareTypeWechatSession];
        }]];
        [_alertVC addAction:[UIAlertAction actionWithTitle:@"微信朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf _sendShareWithPlatformScene:MGShareTypeWechatTimeline];
        }]];
        [_alertVC addAction:[UIAlertAction actionWithTitle:@"微信收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf _sendShareWithPlatformScene:MGShareTypeWechatFavorite];
        }]];
        [_alertVC addAction:[UIAlertAction actionWithTitle:@"QQ" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf _sendShareWithPlatformScene:MGShareTypeQQ];
        }]];
        [_alertVC addAction:[UIAlertAction actionWithTitle:@"QZone" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf _sendShareWithPlatformScene:MGShareTypeQZone];
        }]];
        [_alertVC addAction:[UIAlertAction actionWithTitle:@"新浪微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf _sendShareWithPlatformScene:MGShareTypeWeibo];
        }]];
        [_alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    }
    return _alertVC;
}

#pragma mark MGShareDelegate

- (void)shareResult:(BOOL)status {
    NSString *msg = @"";
    if (status) {
        msg = @"分享成功";
    } else {
        msg = @"分享失败";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}



@end
