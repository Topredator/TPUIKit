//
//  TPUI.m
//  TPUIKit
//
//  Created by Topredator on 2021/10/18.
//

#import "TPUI.h"
#import <UIKit/UIKit.h>

@interface UIApplication ()
+ (CGFloat)tp_statusBarHeight;
@end

@implementation UIApplication (TPUI)
+ (CGFloat)tp_statusBarHeight {
    CGFloat statusBarHeight = 0.0;
    if (@available(iOS 13.0, *)) {
        UIWindow *window = UIApplication.sharedApplication.windows.firstObject;
        statusBarHeight = window.windowScene.statusBarManager.statusBarFrame.size.height;
    } else {
        statusBarHeight = UIApplication.sharedApplication.statusBarFrame.size.width;
    }
    return statusBarHeight;
}
@end

@implementation TPUI
+ (CGFloat)tp_screenWidth { return UIScreen.mainScreen.bounds.size.width; }
/// 屏幕 高度
+ (CGFloat)tp_screenHeight { return UIScreen.mainScreen.bounds.size.height; }
/// 状态栏 高度
+ (CGFloat)tp_statusBarHeight { return UIApplication.tp_statusBarHeight; }
/// 导航栏 高度
+ (CGFloat)tp_navigationBarHeight { return 44; }
/// 状态栏 + 导航栏 高度
+ (CGFloat)tp_topBarHeight { return UIApplication.tp_statusBarHeight + self.tp_navigationBarHeight; }
/// Tabbar 高度
+ (CGFloat)tp_tabbarHeight { return 49.0; }
/// Tabbar + 底部安全区域高度
+ (CGFloat)tp_bottomBarHeight { return self.tp_statusBarHeight > 20.0 ? 83.0 : 49.0; }
/// 底部安全区域高度
+ (CGFloat)tp_bottomSafeAreaHeight { return self.tp_statusBarHeight > 20.0 ? 34.0 : 0.0; }
@end
