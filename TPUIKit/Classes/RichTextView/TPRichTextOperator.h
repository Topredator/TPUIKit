//
//  TPRichTextOperator.h
//  TPUIKit
//
//  Created by Topredator on 2021/11/12.
//

#import <Foundation/Foundation.h>
@class TPRichTextLabelConfig;
NS_ASSUME_NONNULL_BEGIN

/// 富文本 操作类
@interface TPRichTextOperator : NSObject
@property (nonatomic, strong) TPRichTextLabelConfig *config;

+ (instancetype)operateWithConfig:(TPRichTextLabelConfig *)config;
/// 操作 属性字符串
- (void)operateAttributeString:(NSMutableAttributedString *)attString;
@end

NS_ASSUME_NONNULL_END
