//
//  TPAppDelegate+TPWindow.m
//  TPUIKit_Example
//
//  Created by Topredator on 2021/10/19.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import "TPAppDelegate+TPWindow.h"
#import "TPRootVC.h"
@implementation TPAppDelegate (TPWindow)
- (void)initWindow {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    [self resetWindow];
}
- (void)resetWindow {
    TPRootVC *rootVC = [TPRootVC new];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
}
@end
