//
//  TPTabbarRow.m
//  TPUIKit_Example
//
//  Created by Topredator on 2024/12/22.
//  Copyright © 2024 Topredator. All rights reserved.
//

#import "TPTabbarRow.h"

@implementation TPTabbarRow
- (void)tp_tableViewPreparedCell:(__kindof UITableViewCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld个", indexPath.row + 1];
}
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    return 40;
}
@end
