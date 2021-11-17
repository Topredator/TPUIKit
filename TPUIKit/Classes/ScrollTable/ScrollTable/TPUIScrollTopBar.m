//
//  TPUIScrollTopBar.m
//  TPUIKit
//
//  Created by Topredator on 2020/10/31.
//

#import "TPUIScrollTopBar.h"
#import "TPUI.h"
const CGFloat kTPUIScrollTopBarHeight = 45;

@implementation TPUIScrollTopBar

+ (instancetype)tabbar {
    return [[self alloc] initWithFrame:CGRectMake(0, 0, TPUI.tp_screenWidth, kTPUIScrollTopBarHeight)];
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}
- (void)commonInit {
    self.itemTitleColor = [TPUI tp_t:102];
    self.itemTitleSelectedColor = [TPUI tp_t:51];
    self.itemTitleFont = [TPUI tp_font:15 weight:FontMedium];
    self.itemTitleSelectedFont = [TPUI tp_font:15 weight:FontMedium];
    self.indicatorScrollFollowContent = YES;
    self.indicatorColor = [TPUI tp_r:39 g:119 b:248];
    [self setIndicatorWidthFixTextAndMarginTop:kTPUIScrollTopBarHeight - 2 marginBottom:0 tapSwitchAnimated:YES];
}
@end
