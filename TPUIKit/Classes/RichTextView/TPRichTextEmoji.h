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
/// 配置plist文件地址 及 图片文件夹地址
- (void)configEmojiPlistPath:(NSString *)plistPath filePath:(NSString *)filePath;
/// 所有 emoji信息
- (NSDictionary *)allEmojis;
@end

NS_ASSUME_NONNULL_END
