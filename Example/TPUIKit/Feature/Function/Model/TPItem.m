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
@implementation TPItem
+ (instancetype)itemName:(NSString *)name type:(ItemType)type {
    TPItem *item = [self new];
    item.name = name;
    item.type = type;
    return item;
}
- (void)execute {
    switch (self.type) {
        case Alert: break;
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
        case Tabbar: break;
        case Banner: break;
        default: break;
    }
}
@end
