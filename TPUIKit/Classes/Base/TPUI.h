//
//  TPUI.h
//  TPUIKit
//
//  Created by Topredator on 2021/10/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPUI : NSObject
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

@end

NS_ASSUME_NONNULL_END
