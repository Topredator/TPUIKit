//
//  TPTestViewController.m
//  TPUIKit_Example
//
//  Created by Topredator on 2019/2/25.
//  Copyright © 2019 Topredator. All rights reserved.
//

#import "TPTestViewController.h"

@interface TPTestViewController ()
@property (nonatomic, strong) TPGradientView *gradientView;
@property (nonatomic, strong) TPSimButton *simBtn;
@end

@implementation TPTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.gradientView];
    [self.view addSubview:self.simBtn];
    [self.gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 100));
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(80);
    }];
    [self.simBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 45));
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.gradientView.mas_bottom).offset(30);
    }];
}
- (TPGradientView *)gradientView {
    if (!_gradientView) {
        _gradientView = [[TPGradientView alloc] initWithBeginColor:UIColor.redColor endColor:UIColor.greenColor direction:TPGradientDirectionLeftToRight];
    }
    return _gradientView;
}
- (TPSimButton *)simBtn {
    if (!_simBtn) {
        _simBtn = [[TPSimButton alloc] initWithFrame:CGRectZero];
        _simBtn.iconPosition = TPSimButtonIconPositionRight;
        _simBtn.iconTextMargin = 5;
        _simBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _simBtn.backgroundColor = UIColor.purpleColor;
        [_simBtn setTitle:@"测试按钮" forState:UIControlStateNormal];
        [_simBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_simBtn setImage:[UIImage imageNamed:@"invalidName"] forState:UIControlStateNormal];
    }
    return _simBtn;
}
@end
