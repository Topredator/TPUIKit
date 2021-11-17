//
//  TPTextEmoji.h
//  TPUIKit
//
//  Created by Topredator on 2021/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 富文本 emoji配置
@interface TPRichTextEmoji : NSObject
+ (instancetype)shared;
/// 设置外部 资源
- (void)configEmojiBundleName:(NSString *)bundleName;
/// 所有 emoji信息
- (NSDictionary *)allEmojis;
+ (UIImage * _Nullable)emojiName:(NSString *)emojiName;
@end

NS_ASSUME_NONNULL_END
