//
//  TPNavigationController.h
//  TPUIKit_Example
//
//  Created by Topredator on 2021/10/19.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import <TPUIKit/TPUIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 通用 导航控制器
@interface TPNavigationController : TPUIBackNavigationController
- (void)configTabbarItemTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
