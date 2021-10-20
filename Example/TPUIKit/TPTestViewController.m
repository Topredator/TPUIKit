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
@property (nonatomic, strong) UIButton *changeBtn;
@property (nonatomic, strong) UIButton *normalBtn;
@end

@implementation TPTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.gradientView];
    [self.view addSubview:self.simBtn];
    [self.view addSubview:self.normalBtn];
    [self.view addSubview:self.changeBtn];
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
    [self.normalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 45));
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.simBtn.mas_bottom).offset(30);
    }];
    [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 45));
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.normalBtn.mas_bottom).offset(30);
    }];
}
- (void)changeBtnAction {
    [self.simBtn setTitle:@"测试按钮" forState:UIControlStateNormal];
    [self.simBtn setImage:nil forState:UIControlStateNormal];
    
    [self.normalBtn setImage:[UIImage imageNamed:@"invalidName"] forState:UIControlStateHighlighted];
    [self.normalBtn setImage:nil forState:UIControlStateNormal];
    
}
- (TPUIGradientView *)gradientView {
    if (!_gradientView) {
        _gradientView = [[TPUIGradientView alloc] initWithFrame:CGRectZero];
        [_gradientView tp_addGradient:TPCreateGradientLayer(UIColor.redColor, UIColor.blueColor, TPUIGradientDirectionLeftToRight)];
    }
    return _gradientView;
}
- (TPUISimButton *)simBtn {
    if (!_simBtn) {
        _simBtn = [TPUISimButton buttonWithType:UIButtonTypeCustom];
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
- (UIButton *)normalBtn {
    if (!_normalBtn) {
        _normalBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _normalBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _normalBtn.backgroundColor = UIColor.purpleColor;
        [_normalBtn setTitle:@"系统按钮" forState:UIControlStateNormal];
        [_normalBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_normalBtn setImage:[UIImage imageNamed:@"invalidName"] forState:UIControlStateNormal];
    }
    return _normalBtn;
}
- (UIButton *)changeBtn {
    if (!_changeBtn) {
        _changeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_changeBtn setTitle:@"测试" forState:UIControlStateNormal];
        [_changeBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _changeBtn.backgroundColor = UIColor.purpleColor;
        _changeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_changeBtn addTarget:self action:@selector(changeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeBtn;
}
@end
