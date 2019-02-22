//
//  TPRefreshHeader.m
//  TPUIKit
//
//  Created by Topredator on 2019/2/21.
//

#import "TPRefreshHeader.h"
#import <Masonry/Masonry.h>



@implementation TPRefreshHeader
- (void)prepare {
    [super prepare];
    [self setupSubviews];
}
- (void)placeSubviews {
    [super placeSubviews];
}
- (void)setupSubviews {
    self.lastUpdatedTimeLabel.hidden = YES;
    // 设置状态标签
    self.stateLabel.textAlignment = NSTextAlignmentCenter;
    self.stateLabel.font = [UIFont systemFontOfSize:12];
    
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"加载中" forState:MJRefreshStateRefreshing];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(50);
    }];
    
    // 设置Gif
    NSArray *idleImages = @[TPModuleImage(@"loading1_00000")];
    // 设置即将刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int i = 0; i <= 49; i++) {
        UIImage *image = TPModuleImage([NSString stringWithFormat:@"loading1_0000%02d", i]);
        [refreshingImages addObject:image];
    }
    // 设置不同状态的图片
    [self setImages:idleImages forState:MJRefreshStateIdle];
    [self setImages:idleImages forState:MJRefreshStatePulling];
    [self setImages:refreshingImages duration:3.5 forState:MJRefreshStateRefreshing];
    
    [self.gifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(38, 36));
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(8);
    }];
    
    self.mj_h = 70;
}
- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
    if (self.state == MJRefreshStateIdle) {
        self.gifView.transform = CGAffineTransformMakeScale(pullingPercent, pullingPercent);
    } else {
        if (!CGAffineTransformEqualToTransform(self.gifView.transform, CGAffineTransformIdentity)) {
            self.gifView.transform = CGAffineTransformIdentity;
        }
    }
}

@end
