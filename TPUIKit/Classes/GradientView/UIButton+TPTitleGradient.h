//
//  UIButton+TPTitleGradient.h
//  TPUIKit
//
//  Created by Topredator on 2024/12/22.
//

#import <UIKit/UIKit.h>
#import "TPUIGradientLayer.h"


NS_ASSUME_NONNULL_BEGIN

@interface UIButton (TPTitleGradient)
/// 给title设置渐变色
/// 注意:  如果使用约束布局，应该在布局之后添加使用
///
/// - Parameter layer: 渐变图层
- (void)tp_addTitleGradient:(TPUIGradientLayer *)layer;
@end

NS_ASSUME_NONNULL_END
