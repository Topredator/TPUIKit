//
//  TPClassifyItem.m
//  TPUIKit_Example
//
//  Created by Topredator on 2021/11/15.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import "TPClassifyItem.h"
#import "TPRichTextVC.h"
@implementation TPClassifyItem
+ (instancetype)itemName:(NSString *)name type:(ClassifyItemType)type {
    TPClassifyItem *item = [[self alloc] init];
    item.name = name;
    item.type = type;
    return item;
}
- (void)execute {
    switch (self.type) {
        case RichText: {
            [TPUINavigator pushViewController:TPRichTextVC.new animated:YES];
        }
            break;
            
        default:
            break;
    }
}
@end
