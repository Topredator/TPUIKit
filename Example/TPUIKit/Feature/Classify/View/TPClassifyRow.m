//
//  TPClassifyRow.m
//  TPUIKit_Example
//
//  Created by Topredator on 2021/11/15.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import "TPClassifyRow.h"

@implementation TPClassifyRow
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:UITableViewCell.class];
    }
    return self;
}
+ (instancetype)itemRow:(TPClassifyItem *)item {
    TPClassifyRow *row = [TPClassifyRow row];
    row.item = item;
    return row;
}
- (void)tp_tableViewCellWillDisplay:(__kindof UITableViewCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)tp_tableViewPreparedCell:(__kindof UITableViewCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = self.item.name;
}
- (void)tp_tableViewCellDidSelected:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    [self.item execute];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 48;
}
@end
