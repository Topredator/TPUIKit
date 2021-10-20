//
//  TPFunctionRow.m
//  TPUIKit_Example
//
//  Created by Topredator on 2021/10/19.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import "TPFunctionRow.h"

@interface TPFunctionRow ()
@property (nonatomic, strong) TPItem *item;
@end

@implementation TPFunctionRow
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setCellClass:UITableViewCell.class];
    }
    return self;
}
+ (instancetype)itemRow:(TPItem *)item {
    TPFunctionRow *row = [TPFunctionRow row];
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
