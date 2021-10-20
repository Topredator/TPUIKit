//
//  TPItem.m
//  TPUIKit_Example
//
//  Created by Topredator on 2021/10/19.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import "TPItem.h"
#import <TPUIKit/TPUIKit.h>
#import <TPFoundation/TPFoundation.h>
#import "TPScrollContainer.h"
#import "TPBannerVC.h"
#import "TPMenuVC.h"
@implementation TPItem
+ (instancetype)itemName:(NSString *)name type:(ItemType)type {
    TPItem *item = [self new];
    item.name = name;
    item.type = type;
    return item;
}
- (void)execute {
    switch (self.type) {
        case Alert: {
            [TPUIAlert alertSheetShow:^(TPUIAlertMaker *make) {
                make.title(@"Alert 测试").message(@"测试系统alert");
                make.cancleOption(@"取消");
                TPUIAlertOption *option = [TPUIAlertOption optionWithTitle:@"警告" block:^{
                    NSLog(@"警告!!!");
                } actionStyle:UIAlertActionStyleDestructive];
                make.addOption(option);
                make.addOption(TPUIAlertBlockOption(@"确定", nil));
            }];
        } break;
        case Blank: {
            TPUITextBlankView *blank = [TPUITextBlankView showInView:[TPUINavigator currentViewController].view animated:YES];
            blank.textLabel.text = @"显示成功";
            blank.subTextLabel.text = @"你需要显示什么";
            __weak typeof(blank) blankView = blank;
            [blank setRefreshTitle:@"删除" actionBlock:^{
                [blankView hideWithAnimated:YES];
            }];
        } break;
        case Toast: {
            [TPUIToast showLoadingWithString:@"加载中..."];
            [TPGCDQueue executeInMainQueue:^{
                [TPUIToast hideToast];
            } afterDelaySecs:1.5];
        } break;
        case Tabbar: {
            [TPUINavigator pushViewController:TPScrollContainer.new animated:YES];
        } break;
        case Banner: {
            [TPUINavigator pushViewController:TPBannerVC.new animated:YES];
        } break;
        case Menu: {
            [TPUINavigator pushViewController:TPMenuVC.new animated:YES];
        } break;
        default: break;
    }
}
@end
