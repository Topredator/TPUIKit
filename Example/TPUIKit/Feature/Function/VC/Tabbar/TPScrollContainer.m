//
//  TPScrollContainer.m
//  TPUIKit_Example
//
//  Created by Topredator on 2021/10/20.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import "TPScrollContainer.h"
#import "TPTabbarPageVC.h"

@interface TPScrollContainer ()

@end

@implementation TPScrollContainer

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"ScrollContainer";
    
    TPTabbarPageVC *firstVC = [TPTabbarPageVC new];
    firstVC.title = @"Number 1";
    
    TPTabbarPageVC *secondVC = [TPTabbarPageVC new];
    secondVC.title = @"Number 2";
    
    TPTabbarPageVC *thirdVC = [TPTabbarPageVC new];
    thirdVC.title = @"Number 3";
    self.viewControllers = @[firstVC, secondVC, thirdVC];
    self.initialTabIndex = 1;
}
@end
