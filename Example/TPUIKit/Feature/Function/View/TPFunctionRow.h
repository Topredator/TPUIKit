//
//  TPFunctionRow.h
//  TPUIKit_Example
//
//  Created by Topredator on 2021/10/19.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import <TPFoundation/TPTableRow.h>
#import "TPItem.h"

NS_ASSUME_NONNULL_BEGIN
@interface TPFunctionRow : TPTableRow
+ (instancetype)itemRow:(TPItem *)item;
@end

NS_ASSUME_NONNULL_END
