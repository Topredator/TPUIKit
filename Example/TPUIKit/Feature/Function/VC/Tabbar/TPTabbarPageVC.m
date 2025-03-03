//
//  TPTabbarPageVC.m
//  TPUIKit_Example
//
//  Created by Topredator on 2021/10/20.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import "TPTabbarPageVC.h"
#import <TPFoundation/TPFoundation.h>
#import "TPTabbarRow.h"

@interface TPTabbarPageVC ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TPTableSection *section;
@end

@implementation TPTabbarPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [TPUI tp_randomColor];
    [self setupSubviews];
    [self loadData];
}
- (void)setupSubviews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
- (void)loadData {
    NSInteger count = arc4random() % 30 + 1;
    for (NSInteger i = 0; i < count; i++) {
        [self.section addObject:[TPTabbarRow row]];
    }
    [self.tableView.TPProxy reloadData:@[self.section]];
}
#pragma mark----------------- Getter -----------------
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.TPProxy = [TPTableViewProxy proxyWithTableView:_tableView];
        [TPUI tp_adjustsInsets:_tableView vc:self];
    }
    return _tableView;
}
- (TPTableSection *)section {
    if (!_section) {
        _section = [TPTableSection section];
        _section.headerHeight = ^CGFloat(__kindof TPTableSection * _Nonnull sectionData, TPTableViewProxy * _Nonnull proxy, NSUInteger section) {
            return 0.01;
        };
        _section.footerHeight = ^CGFloat(__kindof TPTableSection * _Nonnull sectionData, TPTableViewProxy * _Nonnull proxy, NSUInteger section) {
            return 0.01;
        };
    }
    return _section;
}
@end
