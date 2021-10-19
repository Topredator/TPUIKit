//
//  TPFunctionVC.m
//  TPUIKit_Example
//
//  Created by Topredator on 2021/10/19.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import "TPFunctionVC.h"
#import <Masonry/Masonry.h>
#import "TPFunctionRow.h"
#import <TPFoundation/TPFoundation.h>

@implementation TPFunctionVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Function";
    [self loadData];
}
- (void)setupTableView {
    [super setupTableView];
    self.tableview.hidden = NO;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
- (void)loadData {
    NSArray *items = @[
        [TPItem itemName:@"Alert" type:Alert],
        [TPItem itemName:@"Blank" type:Blank],
        [TPItem itemName:@"Toast" type:Toast],
        [TPItem itemName:@"Tabbar" type:Tabbar],
        [TPItem itemName:@"Banner" type:Banner]
    ];
    TPTableSection *section = [self tableSection];
    for (TPItem *item in items) {
        [section tp_safetyAddObject:[TPFunctionRow itemRow:item]];
    }
    [self reloadData:@[section]];
}





- (TPTableSection *)tableSection {
    TPTableSection *section = [TPTableSection section];
    section.headerHeight = ^CGFloat(__kindof TPTableSection * _Nonnull sectionData, TPTableViewProxy * _Nonnull proxy, NSUInteger section) {
        return 0.1;
    };
    section.footerHeight = ^CGFloat(__kindof TPTableSection * _Nonnull sectionData, TPTableViewProxy * _Nonnull proxy, NSUInteger section) {
        return 0.1;
    };
    return section;
}
@end
