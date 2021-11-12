//
//  UIView+TPTapExtension.h
//  TPUIKit
//
//  Created by Topredator on 2021/10/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// view  点击 扩展
@interface UIView (TPTapExtension)
/// 添加点击
- (void)tp_addTapBlock:(void (^)(UIView *view))tapBlock;
@end

NS_ASSUME_NONNULL_END
