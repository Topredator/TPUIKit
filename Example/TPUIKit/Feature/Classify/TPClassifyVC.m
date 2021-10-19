//
//  TPClassifyVC.m
//  TPUIKit_Example
//
//  Created by Topredator on 2021/10/19.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import "TPClassifyVC.h"

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
}
- (void)loadData {
    
}
@end
