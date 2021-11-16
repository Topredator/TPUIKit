//
//  TPClassifyRow.h
//  TPUIKit_Example
//
//  Created by Topredator on 2021/11/15.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import <TPFoundation/TPFoundation.h>
#import "TPClassifyItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPClassifyRow : TPTableRow
@property (nonatomic, strong) TPClassifyItem *item;
+ (instancetype)itemRow:(TPClassifyItem *)item;
@end

NS_ASSUME_NONNULL_END
