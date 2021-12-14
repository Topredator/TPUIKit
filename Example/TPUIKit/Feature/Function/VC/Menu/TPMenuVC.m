//
//  TPMenuVC.m
//  TPUIKit_Example
//
//  Created by Topredator on 2021/10/20.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import "TPMenuVC.h"
#import <TPUIKit/TPUIPopupMenuVC.h>
#import <TPUIKit/TPUISimButton.h>
#import <Masonry/Masonry.h>
@interface TPMenuVC ()
@property (nonatomic, weak) TPUIPopupMenuVC *menuVC;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) TPUISimButton *testBtn;
@end

@implementation TPMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Menu";
    [self setupSubviews];
}
- (void)setupSubviews {
    [self.view addSubview:self.testBtn];
    [self.testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(45);
    }];
}
- (void)testAction {
    if (!self.menuVC) {
        NSArray *titles = @[
            @"Number 1",
            @"Number 2",
            @"Number 3",
            @"Number 4",
            @"Number 5"];
        TPUIPopupMenuConfig *config = [TPUIPopupMenuConfig new];
        config.selectedIndex = self.selectedIndex;
        TPUIPopupMenuVC *menuVC = [TPUIPopupMenuVC menuConfig:config
                                                       titles:titles];
        __weak typeof(self) weakSelf = self;
        [menuVC setDidSelectedBlock:^(NSInteger index) {
            weakSelf.selectedIndex = index;
            [weakSelf.testBtn setTitle:titles[index] forState:UIControlStateNormal];
        }];
        [menuVC setDismissBlock:^{
            NSLog(@"消失了");
        }];
        [menuVC presentInTargetVC:self contentHeight:MIN(200, [menuVC maxContentHeight]) topOffset:200];
        self.menuVC = menuVC;
    }
}
#pragma mark ------------------------  lazy method  ---------------------------
- (TPUISimButton *)testBtn {
    if (!_testBtn) {
        _testBtn = [[TPUISimButton alloc] initWithFrame:CGRectZero];
        [_testBtn setTitle:@"Number 1" forState:UIControlStateNormal];
        [_testBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _testBtn.titleLabel.font = [TPUI tp_font:15 weight:FontMedium];
        _testBtn.backgroundColor = UIColor.purpleColor;
        [_testBtn addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _testBtn;
}
@end
