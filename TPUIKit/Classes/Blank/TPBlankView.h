//
//  TPBlankView.h
//  TPUIKit
//
//  Created by Topredator on 2019/3/1.
//

#import <UIKit/UIKit.h>

#import "UIView+TPBlankView.h"

@interface TPBlankView : UIView
@property (nonatomic, strong, nullable) UIView *contentView;
@property (nonatomic, assign) CGFloat topOffset UI_APPEARANCE_SELECTOR;
+ (instancetype)blankView;
+ (TPBlankView *)blankViewInView:(UIView *)view;
+ (instancetype)showInView:(UIView *)view animated:(BOOL)animated;
+ (instancetype)hideInView:(UIView *)view animated:(BOOL)animated;
- (void)showInView:(UIView *)view animated:(BOOL)animated;
- (void)hideWithAnimated:(BOOL)animated;
- (void)setupSubviews;
@end

#pragma mark ==================  TPImageBlankView   ==================
@interface TPImageBlankView : TPBlankView
@property (nonatomic, strong, readonly) UIImageView *imageView;
@end
#pragma mark ==================  TPActivityBlankView   ==================
@interface TPActivityBlankView : TPBlankView
@property (nonatomic, strong, readonly) UIActivityIndicatorView *activitiyView;
@end
#pragma mark ==================  TPTextBlankView   ==================
@interface TPTextBlankView : TPImageBlankView
/// 主标题
@property (nonatomic, strong, readonly) UILabel *textLabel;
/// 副标题
@property (nonatomic, strong, readonly) UILabel *subTextLabel;
/// 刷新按钮
@property (nonatomic, strong, readonly) UIButton *refreshButton;

/**
 设置刷新按钮

 @param title 刷新按钮标题, 如果为nil，隐藏按钮
 @param target 响应对象
 @param action 事件回调
 */
- (void)setRefreshTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
 设置刷新按钮

 @param title 刷新按钮标题, 如果为nil，隐藏按钮
 @param block 事件回调
 */
- (void)setRefreshTitle:(NSString *)title actionBlock:(void(^)(void))block;
@end
