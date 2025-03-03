//
//  TPClassifyVC.m
//  TPUIKit_Example
//
//  Created by Topredator on 2021/10/19.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import "TPClassifyVC.h"
#import "TPClassifyRow.h"
#import <TPUIKit/TPUIRefreshFooter.h>
@interface TPClassifyVC ()

@end

@implementation TPClassifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Classify";
    [self loadData];
}
- (void)setupTableView {
    [super setupTableView];
    self.tableview.hidden = NO;
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    __weak typeof(self) weakSelf = self;
    self.tableview.mj_footer = [TPUIRefreshFooter footerWithRefreshingBlock:^{
        [TPGCDQueue executeInMainQueue:^{
            [weakSelf.tableview.mj_footer endRefreshing];
        } afterDelaySecs:2];
    }];
}
- (void)loadData {
    NSArray *items = @[
        [TPClassifyItem itemName:@"RichText" type:RichText],
    ];
    TPTableSection *section = [TPTableSection section];
    for (TPClassifyItem *item in items) {
        [section tp_safetyAddObject:[TPClassifyRow itemRow:item]];
    }
    [self reloadData:@[section]];
}
@end
