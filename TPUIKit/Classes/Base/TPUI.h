//
//  TPUI.h
//  TPUIKit
//
//  Created by Topredator on 2021/10/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TPUIFontWeight) {
    FontThin,
    FontRegular,
    FontMedium,
    FontSemibold,
    FontLight
};


@interface TPUI : NSObject
#pragma mark ------------------------  System  ---------------------------
/// 屏幕 宽度
+ (CGFloat)tp_screenWidth;
/// 屏幕 高度
+ (CGFloat)tp_screenHeight;
/// 状态栏 高度
+ (CGFloat)tp_statusBarHeight;
/// 导航栏 高度
+ (CGFloat)tp_navigationBarHeight;
/// 状态栏 + 导航栏 高度
+ (CGFloat)tp_topBarHeight;
/// Tabbar 高度
+ (CGFloat)tp_tabbarHeight;
/// Tabbar + 底部安全区域高度
+ (CGFloat)tp_bottomBarHeight;
/// 底部安全区域高度
+ (CGFloat)tp_bottomSafeAreaHeight;

#pragma mark ------------------------  R&G&B  ---------------------------
/// 随机色
+ (UIColor *)tp_randomColor;
/// RGB
+ (UIColor *)tp_r:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue;
/// RGBA
+ (UIColor *)tp_r:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue a:(CGFloat)alpha;
+ (UIColor *)tp_t:(CGFloat)t;
+ (UIColor *)tp_t:(CGFloat)t alpha:(CGFloat)alpha;
/// hex color
+ (UIColor *)tp_hexColor:(unsigned long)hex;
+ (UIColor *)tp_hexColor:(unsigned long)hex alpha:(CGFloat)alpha;
+ (UIColor *)tp_hexStringColor:(NSString *)hexString;
+ (UIColor *)tp_hexStringColor:(NSString *)hexString alpha:(CGFloat)alpha;

/// 调整scrollview insets
+ (void)tp_adjustsInsets:(UIScrollView *)scrollView vc:(UIViewController *)vc;

/// Font
+ (UIFont *)tp_font:(CGFloat)fontSize weight:(TPUIFontWeight)weight;

/// 从 bundle中 获取image
+ (UIImage *)tp_imageName:(NSString *)imageName
                bundleName:(NSString *)bundleName;

@end

NS_ASSUME_NONNULL_END
