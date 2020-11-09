//
//  TPCellVC.m
//  TPUIKit_Example
//
//  Created by Topredator on 2020/11/9.
//  Copyright © 2020 Topredator. All rights reserved.
//

#import "TPCellVC.h"
#import <TPFoundation/TPFoundation.h>
#import "TPCellRow.h"
@interface TPCellVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TPCellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    NSArray *titles = @[@"黄色的树林里分出两条路，可惜我不能同时去涉足，我在那路口久久伫立，我向着一条路极目望去，直到它消失在丛林深处。",
                        @"Two roads diverged in a yellow wood, And sorry I could not travel both And be one traveler, long I stood And looked down one as far as I could To where it bent in the undergrowth; ",
                        @"★タクシー代がなかったので、家まで歩いて帰った。★もし事故が発生した场所、このレバーを引いて列车を止めてください。", @"哈哈哈哈啊😸😸", @"hkfwjeiofowhfewlhfwehfwel"];
    TPTableSection *section = [TPTableSection section];
    for (NSInteger i = 0; i < titles.count; i++) {
        [section tp_safetyAddObject:[TPCellRow rowWithTitle:titles[i]]];
    }
    [self.tableView.TPProxy reloadData:@[section]];
}



#pragma mark ------------------------  lazy method ---------------------------
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.TPProxy = [TPTableViewProxy proxyWithTableView:_tableView];
    }
    return _tableView;
}
@end
