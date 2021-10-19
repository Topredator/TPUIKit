//
//  TPBaseTableVC.m
//  TPUIKit_Example
//
//  Created by Topredator on 2021/10/19.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import "TPBaseTableVC.h"

@interface TPBaseTableVC ()

@end

@implementation TPBaseTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTableView];
}
- (void)setupTableView {
    [self.view addSubview:self.tableview];
}
- (void)reloadData:(NSArray<TPTableSection<TPTableRow *> *> *)datas {
    [self.tableview.TPProxy reloadData:datas];
}
#pragma mark ------------------------  lazy method  ---------------------------
- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableview.TPProxy = [TPTableViewProxy proxyWithTableView:_tableview];
        _tableview.hidden = YES;
    }
    return _tableview;
}
@end
