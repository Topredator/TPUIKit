//
//  TPRootVC.m
//  TPUIKit_Example
//
//  Created by Topredator on 2021/10/19.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import "TPRootVC.h"
#import <TPUIKit/TPUIKit.h>
#import "TPFunctionVC.h"
#import "TPClassifyVC.h"
#import "TPNavigationController.h"
@interface TPRootVC ()

@end

@implementation TPRootVC
- (instancetype)init {
    self = [super init];
    if (self) {
        if (@available(iOS 10.0, *)) self.tabBar.unselectedItemTintColor = [TPUI tp_t:102];
        self.tabBar.tintColor = [TPUI tp_r:39 g:119 b:248];
        self.tabBar.layer.shadowColor = [TPUI tp_t:0 alpha:0.1].CGColor;
        self.tabBar.layer.shadowOffset = CGSizeMake(0, -1);
        self.tabBar.layer.shadowOpacity = 0.3;
        
        if (@available(iOS 13.0, *)) {
            UITabBarAppearance *appearance = self.tabBar.standardAppearance.copy;
            [appearance setShadowImage:[UIImage tp_imageWithColor:UIColor.whiteColor]];
            [appearance setBackgroundImage:[UIImage tp_imageWithColor:UIColor.whiteColor]];
            self.tabBar.standardAppearance = appearance;
        } else {
            [[UITabBar appearance] setShadowImage:[UIImage new]];
            [[UITabBar appearance] setBackgroundImage:[UIImage new]];
        }
        [UITabBar.appearance setTranslucent:NO];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configViewControllers];
}
- (void)configViewControllers {
    
    TPFunctionVC *functionVC = [TPFunctionVC new];
    TPNavigationController *functionNavi = [[TPNavigationController alloc] initWithRootViewController:functionVC];
    functionNavi.tabBarItem.title = @"Function";
    
    TPClassifyVC *classifyVC = [TPClassifyVC new];
    TPNavigationController *classifyNavi = [[TPNavigationController alloc] initWithRootViewController:classifyVC];
    classifyNavi.tabBarItem.title = @"Classify";
    
    self.viewControllers = @[functionNavi, classifyNavi];
}
@end
