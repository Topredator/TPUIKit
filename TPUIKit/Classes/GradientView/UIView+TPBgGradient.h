//
//  UIView+TPTitleGradient.h
//  TPUIKit
//
//  Created by Topredator on 2024/12/22.
//

#import <UIKit/UIKit.h>
#import "TPUIGradientLayer.h"


@interface UIView (TPBgGradient)
/// 背景色设置渐变色
/// 注意:  如果使用约束布局，应该在布局之后添加使用
///
/// - Parameter layer: 渐变图层
- (void)tp_addGradient:(TPUIGradientLayer *)layer;

/// 边框渐变色
/// - Parameter layer: 渐变图层
- (void)tp_addBorderGradient:(TPUIGradientLayer *)layer;

/// 边框渐变色
/// - Parameters:
///   - layer: 渐变图层
///   - lineWidth: 边框宽度
///   - corners: 圆角位置
///   - cornerRadius: 圆角半径
- (void)tp_addBorderGradient:(TPUIGradientLayer *)layer lineWidth:(CGFloat)lineWidth corners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius;

/// 删除渐变边框
- (void)tp_removeBorderGradient;
@end

