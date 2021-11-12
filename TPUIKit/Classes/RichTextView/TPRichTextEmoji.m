//
//  TPTextEmoji.m
//  TPUIKit
//
//  Created by Topredator on 2021/11/12.
//

#import "TPRichTextEmoji.h"

@interface TPRichTextEmoji ()
@property (nonatomic, strong) NSMutableDictionary *emojis;
@end

static TPRichTextEmoji *emoji = nil;
@implementation TPRichTextEmoji
+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        emoji = [TPRichTextEmoji new];
    });
    return emoji;
}
- (void)configEmojiPlistPath:(NSString *)plistPath filePath:(NSString *)filePath {
    NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile:filePath];
    if (!config) return;
    [self.emojis addEntriesFromDictionary:config];
}
/// 所有 emoji信息
- (NSDictionary *)allEmojis {
    return self.emojis.copy;
}
#pragma mark ------------------------  lazy method  ---------------------------
- (NSMutableDictionary *)emojis {
    if (!_emojis) {
        _emojis = @{}.mutableCopy;
    }
    return _emojis;
}
@end
