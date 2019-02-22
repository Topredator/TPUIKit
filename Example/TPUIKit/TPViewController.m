//
//  TPViewController.m
//  TPUIKit
//
//  Created by Topredator on 02/21/2019.
//  Copyright (c) 2019 Topredator. All rights reserved.
//

#import "TPViewController.h"
#import <TPUIKit/TPUIKit.h>
//#import "TPUIKit.h"

@interface TPViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myTable;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation TPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *data = @[@"加载", @"你好啊", @"成功", @"请求成功", @"失败", @"请求失败", @"显示信息"];
    [self.datas addObjectsFromArray:data];
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
                [TPToast showLoading];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [TPToast hideToast];
                });
            }
            break;
            case 1:{
                [TPToast showLoadingWithString:@"你好啊"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [TPToast hideToast];
                });
            }
            break;
            case 2: {
                [TPToast showSuccess];
            }
            break;
            case 3: {
                [TPToast showSuccessWithString:@"请求成功"];
            }
            break;
            case 4: {
                [TPToast showError];
            }
            break;
            case 5: {
                [TPToast showErrorWithString:@"请求失败"];
            }
            break;
            case 6: {
                [TPToast showInfoWithString:@"显示信息"];
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
