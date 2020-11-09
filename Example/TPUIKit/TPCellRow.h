//
//  TPCellRow.h
//  TPUIKit_Example
//
//  Created by Topredator on 2020/11/9.
//  Copyright © 2020 Topredator. All rights reserved.
//

#import <TPFoundation/TPFoundation.h>
#import <TPUIKit/TPUIBaseTableViewCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPCell : TPUIBaseTableViewCell

@end


@interface TPCellRow : TPTableRow
+ (instancetype)rowWithTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
