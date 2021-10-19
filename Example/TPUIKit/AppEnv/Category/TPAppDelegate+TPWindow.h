//
//  TPAppDelegate+TPWindow.h
//  TPUIKit_Example
//
//  Created by Topredator on 2021/10/19.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import "TPAppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/// 扩展 window
@interface TPAppDelegate (TPWindow)
/// 初始化窗口
- (void)initWindow;
/// 重置 窗口
- (void)resetWindow;
@end

NS_ASSUME_NONNULL_END
