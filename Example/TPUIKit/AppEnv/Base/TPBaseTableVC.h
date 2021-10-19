//
//  TPBaseTableVC.h
//  TPUIKit_Example
//
//  Created by Topredator on 2021/10/19.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import <TPUIKit/TPUIBaseViewController.h>
#import <TPFoundation/TPTableViewProxy.h>
NS_ASSUME_NONNULL_BEGIN

@interface TPBaseTableVC : TPUIBaseViewController
@property (nonatomic, strong) UITableView *tableview;

/// 创建 tableview
- (void)setupTableView;

/// 更新列表
/// @param datas 数据
- (void)reloadData:(NSArray <TPTableSection <TPTableRow *> *> *)datas;
@end

NS_ASSUME_NONNULL_END
