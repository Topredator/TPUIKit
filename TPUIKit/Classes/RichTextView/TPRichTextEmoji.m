//
//  TPTextEmoji.m
//  TPUIKit
//
//  Created by Topredator on 2021/11/12.
//

#import "TPRichTextEmoji.h"

@interface TPRichTextEmoji ()
@property (nonatomic, strong) NSMutableDictionary *emojis;
@property (nonatomic, strong) NSBundle *resourceBundle;
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
- (void)configEmojiBundleName:(NSString *)bundleName {
    NSURL *bundleUrl = [NSBundle.mainBundle URLForResource:bundleName withExtension:@"bundle"];
    self.resourceBundle = [NSBundle bundleWithURL:bundleUrl];
    NSString *plistPath = [self.resourceBundle.resourcePath stringByAppendingPathComponent:@"/emoji.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    if (!dic) return;
    [self.emojis addEntriesFromDictionary:dic];
}
/// 所有 emoji信息
- (NSDictionary *)allEmojis {
    return self.emojis.copy;
}
+ (UIImage *)emojiName:(NSString *)emojiName {
    if (![TPRichTextEmoji shared].resourceBundle) {
        NSString *reason = @"-- 请使用[TPRichTextEmoji.shared configEmojiBundleName:xx] 设置外部资源包地址 --";
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:reason
                                     userInfo:nil];
    }
    if (@available(iOS 13.0, *)) {
        return [UIImage imageNamed:emojiName
                          inBundle:[TPRichTextEmoji shared].resourceBundle
                 withConfiguration:nil];
    } else {
        return [UIImage imageNamed:emojiName
                          inBundle:[TPRichTextEmoji shared].resourceBundle
     compatibleWithTraitCollection:nil];
    }
}
#pragma mark ------------------------  lazy method  ---------------------------
- (NSMutableDictionary *)emojis {
    if (!_emojis) {
        _emojis = @{}.mutableCopy;
    }
    return _emojis;
}
@end
