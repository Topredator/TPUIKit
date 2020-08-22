//
//  TPViewController.m
//  TPUIKit
//
//  Created by Topredator on 02/21/2019.
//  Copyright (c) 2019 Topredator. All rights reserved.
//

#import "TPViewController.h"
//#import "TPUIKit.h"
#import "TPTestViewController.h"
@interface TPViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myTable;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation TPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *data = @[@"加载", @"你好啊", @"成功", @"请求成功", @"失败", @"请求失败", @"显示信息", @"测试Navigator", @"显示blank", @"显示带有刷新按钮的blank", @"activityBlank", @"隐藏blank"];
    [self.datas addObjectsFromArray:data];
    self.myTable.mj_header = [TPUIRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    self.myTable.mj_footer = [TPUIRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}
- (void)refresh {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.myTable.mj_header endRefreshing];
    });
}
- (void)loadMore {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.myTable.mj_footer endRefreshing];
    });
}
#pragma mark ==================  tableview datasource and delegate  ==================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    switch (row) {
            case 0: {
                [TPUIToast showLoading];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [TPUIToast hideToast];
                });
            }
            break;
            case 1:{
                [TPUIToast showLoadingWithString:@"你好啊"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [TPUIToast hideToast];
                });
            }
            break;
            case 2: {
                [TPUIToast showSuccess];
            }
            break;
            case 3: {
                [TPUIToast showSuccessWithString:@"请求成功"];
            }
            break;
            case 4: {
                [TPUIToast showError];
            }
            break;
            case 5: {
                [TPUIToast showErrorWithString:@"请求失败"];
            }
            break;
            case 6: {
                [TPUIToast showInfoWithString:@"春眠不知晓，\n处处闻啼鸟。\n夜来风雨声，\n花落知多少。"];
            }
            break;
        case 7: {
            TPTestViewController *testVC = [TPTestViewController new];
            testVC.title = @"测试";
            [TPUINavigator pushViewController:testVC animated:YES];
        }
            break;
        case 8: {
            TPUITextBlankView *blank = [TPUITextBlankView showInView:tableView animated:YES];
            blank.imageView.image = [UIImage imageNamed:@""];
            blank.textLabel.text = @"显示成功";
            blank.subTextLabel.text = @"你需要显示什么";
        }
            break;
        case 9: {
            TPUITextBlankView *blank = [TPUITextBlankView showInView:tableView animated:YES];
            blank.imageView.image = [UIImage imageNamed:@""];
            blank.textLabel.text = @"显示成功";
            blank.subTextLabel.text = @"你需要显示什么";
            __weak typeof(blank) blankView = blank;
            [blank setRefreshTitle:@"删除" actionBlock:^{
                [blankView hideWithAnimated:YES];
            }];
        }
            break;
        case 10: {
            [tableView tp_showActivityBlankView];
        }
            break;
        case 11: {
            [[TPUIBlankView blankViewInView:tableView] hideWithAnimated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark ==================  lazy method  ==================
- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = @[].mutableCopy;
    }
    return _datas;
}
@end
