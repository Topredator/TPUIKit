//
//  TPTestViewController.m
//  TPUIKit_Example
//
//  Created by Topredator on 2019/2/25.
//  Copyright © 2019 Topredator. All rights reserved.
//

#import "TPTestViewController.h"

@interface TPTestViewController ()
@property (nonatomic, strong) TPUIGradientView *gradientView;
@property (nonatomic, strong) TPUISimButton *simBtn;
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
- (TPUIGradientView *)gradientView {
    if (!_gradientView) {
        _gradientView = [[TPUIGradientView alloc] initWithFrame:CGRectZero];
        [_gradientView tpAddGradient:TPCreateGradientLayer(UIColor.redColor, UIColor.blueColor, TPUIGradientDirectionLeftToRight)];
    }
    return _gradientView;
}
- (TPUISimButton *)simBtn {
    if (!_simBtn) {
        _simBtn = [[TPUISimButton alloc] initWithFrame:CGRectZero];
        _simBtn.iconPosition = TPUISimButtonIconPositionRight;
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
