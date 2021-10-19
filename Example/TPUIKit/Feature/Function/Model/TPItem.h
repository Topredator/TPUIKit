//
//  TPItem.h
//  TPUIKit_Example
//
//  Created by Topredator on 2021/10/19.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, ItemType) {
    Alert,
    Blank,
    Toast,
    Tabbar,
    Banner
};

@interface TPItem : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) ItemType type;
+ (instancetype)itemName:(NSString *)name type:(ItemType)type;
/// 执行
- (void)execute;

@end

NS_ASSUME_NONNULL_END
