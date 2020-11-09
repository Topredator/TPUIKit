//
//  TPCellRow.m
//  TPUIKit_Example
//
//  Created by Topredator on 2020/11/9.
//  Copyright © 2020 Topredator. All rights reserved.
//

#import "TPCellRow.h"

@interface TPCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *allBtn;
@property (nonatomic, copy) void (^scanAll) (void);
/// 是否单行展示
@property (nonatomic, assign) BOOL isSingle;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@end

@implementation TPCell
- (void)setupSubviews {
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.allBtn];
}
- (void)makeConstraints {
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
        make.height.mas_greaterThanOrEqualTo(20);
        make.right.equalTo(self.allBtn.mas_left).offset(-3);
    }];
    [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.right.mas_equalTo(-15);
        make.centerY.equalTo(self.nameLabel);
    }];
}
- (void)configTitle:(NSString *)title {
    self.title = title;
    self.nameLabel.text = title;
    CGFloat width = [self calculateTitleWidth:title];
    self.isSingle = width <= [[UIScreen mainScreen] bounds].size.width - 30;
    self.allBtn.hidden = self.isSingle;
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
        make.height.mas_greaterThanOrEqualTo(20);
        if (self.isSingle) {
            make.right.equalTo(self.contentView.mas_right).offset(-15);
        } else {
            make.right.equalTo(self.allBtn.mas_left).offset(-3);
        }
    }];
    if (!self.isSingle) {
        CGFloat maxTitleWidth = [UIScreen mainScreen].bounds.size.width - 33 - 80;
        NSString *string = @"";
        NSInteger index = 0;
        for (NSInteger i = 1; i < title.length; i++) {
            string = [title substringToIndex:i];
            CGFloat subWidth = [self calculateTitleWidth:string];
            if (subWidth >= maxTitleWidth) {
                index = i - 1;
                break;
            }
        }
        self.subTitle = [title substringWithRange:NSMakeRange(0, index)];
        self.nameLabel.text = [title substringWithRange:NSMakeRange(0, index)];
    }
    
}


- (void)updateSub:(BOOL)flag {
    self.allBtn.hidden = flag;
    self.nameLabel.numberOfLines = flag ? 0 : 1;
    self.nameLabel.text = flag ? self.title : self.subTitle;
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
        make.height.mas_greaterThanOrEqualTo(20);
        if (flag) {
            make.right.equalTo(self.contentView.mas_right).offset(-15);
        } else {
            make.right.equalTo(self.allBtn.mas_left).offset(-3);
        }
    }];
    if (self.scanAll) self.scanAll();
}
- (CGFloat)calculateTitleWidth:(NSString *)title {
    if (!title.length) return 20;
    return [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.width;
}
#pragma mark ------------------------  lazy method ---------------------------
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.numberOfLines = 1;
    }
    return _nameLabel;
}
- (UIButton *)allBtn {
    if (!_allBtn) {
        _allBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_allBtn setTitle:@"查看全文" forState:UIControlStateNormal];
        [_allBtn setTitleColor:UIColor.purpleColor forState:UIControlStateNormal];
        _allBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _allBtn.userInteractionEnabled = NO;
    }
    return _allBtn;
}
@end

@interface TPCellRow ()
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isSelected;
@end

@implementation TPCellRow
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:TPCell.class];
    }
    return self;
}
+ (instancetype)rowWithTitle:(NSString *)title {
    TPCellRow *row = [TPCellRow row];
    row.title = title;
    return row;
}
- (void)tp_tableViewPreparedCell:(TPCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    [cell configTitle:self.title];
    [cell setScanAll:^{
        [proxy.tableView beginUpdates];
        [proxy.tableView endUpdates];
    }];
}
- (void)tp_tableViewCellDidSelected:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    
    TPCell *cell = (TPCell *)self.cell;
    if (cell.isSingle) return;
    self.isSelected = !self.isSelected;
    [cell updateSub:self.isSelected];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
@end
