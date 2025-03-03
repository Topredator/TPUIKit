//
//  TPClassifyItem.h
//  TPUIKit_Example
//
//  Created by Topredator on 2021/11/15.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ClassifyItemType) {
    RichText // 富文本
};

@interface TPClassifyItem : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) ClassifyItemType type;
+ (instancetype)itemName:(NSString *)name type:(ClassifyItemType)type;
/// 执行
- (void)execute;
@end

NS_ASSUME_NONNULL_END
