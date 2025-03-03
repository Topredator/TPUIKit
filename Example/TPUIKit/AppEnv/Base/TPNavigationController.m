//
//  TPNavigationController.m
//  TPUIKit_Example
//
//  Created by Topredator on 2021/10/19.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import "TPNavigationController.h"
#import <TPUIKit/TPUI.h>
@interface TPNavigationController ()

@end

@implementation TPNavigationController
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        rootViewController.hidesBottomBarWhenPushed = NO;
        self.navigationBar.translucent = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = UIColor.whiteColor;
    self.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationBar.titleTextAttributes = @{
        NSFontAttributeName: [TPUI tp_font:18 weight:FontMedium],
        NSForegroundColorAttributeName : [TPUI tp_t:51]
    };
    [[UINavigationBar appearance]  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{
        NSForegroundColorAttributeName: [TPUI tp_r:101 g:109 b:127],
        NSFontAttributeName: [TPUI tp_font:10 weight:FontRegular]
    } forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{
        NSForegroundColorAttributeName: [TPUI tp_r:39 g:119 b:248],
        NSFontAttributeName: [TPUI tp_font:10 weight:FontRegular]
    } forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -2)];
}
- (void)configTabbarItemTitle:(NSString *)title {
    self.tabBarItem.title = title;
}
@end
