//
//  TPRichTextOperator.m
//  TPUIKit
//
//  Created by Topredator on 2021/11/12.
//

#import "TPRichTextOperator.h"
#import "TPRichTextLabelConfig.h"
#import "TPRichTextEmoji.h"

@interface TPRichTextOperator ()
@property (nonatomic, copy) NSDictionary *emojis;
@property (nonatomic, strong) NSMutableArray *regularResults;
@end

@implementation TPRichTextOperator
+ (instancetype)operateWithConfig:(TPRichTextLabelConfig *)config {
    TPRichTextOperator *operator = [[self alloc] init];
    operator.config = config;
    return operator;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}
- (void)initData {
    self.emojis = [TPRichTextEmoji shared].allEmojis;
    self.regularResults = @[].mutableCopy;
}
- (void)operateAttributeString:(NSMutableAttributedString *)attString {
    [self.regularResults removeAllObjects];
    
}
#pragma mark ------------------------  image / video / link  ---------------------------
- (void)operateTagWithAttString:(NSMutableAttributedString *)attString {
    NSMutableString * attStr = attString.mutableString;
    NSString *regularStr = @"<tag type='[a-zA-Z0-9_]*' value='((?!<\\/tag>).)*'>((?!<\\/tag>).)*</tag>";
    NSError *error = nil;
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:regularStr
                                                                                options:NSRegularExpressionCaseInsensitive
                                                                                  error:&error];
    if (error) return;
    // 匹配结果
    NSArray *allMatches = [expression matchesInString:attStr
                                              options:0
                                                range:NSMakeRange(0, attStr.length)];
    NSInteger forIndex = 0;
    NSInteger startIndex = -1;
    // 遍历匹配到结果
    for (NSTextCheckingResult *match in allMatches) {
        // 结果所在的range
        NSRange matchRange = match.range;
        // 记录开始位置
        if (startIndex == -1) {
            startIndex = matchRange.location;
        } else {
            startIndex = matchRange.location - forIndex;
        }
        // 结果字符串  <tag type='link' value='www.baidu.com'>百度</tag>
        NSString *subString = [attStr substringWithRange:NSMakeRange(startIndex, matchRange.length)];
        // text内容
        NSString *content = nil;
        // 替换的text
        NSString *replaceStr = nil;
        /*
         @[
            @"<tag type='link' value='www.baidu.com",
            @"百度</tag>"
         ]
         */
        NSArray *contentArray = [subString componentsSeparatedByString:@"'>"];
        if (contentArray.count != 2) continue;
        /*
         @[
            @"<tag type=",
            @"link",
            @"value=",
            @"www.baidu.com"
         ]
         */
        NSArray *attributeArray = [contentArray[0] componentsSeparatedByString:@"'"];
        // 百度</tag>
        NSString *t_str = contentArray[1];
        // link
        NSString *tagType = attributeArray[1];
        // www.baidu.com
        content = attributeArray[3];
        
        NSString *tagName = @"[linka]";
        if ([tagType isEqualToString:@"link"]) {
            tagName = @"[linka]";
        } else if ([tagType isEqualToString:@"image"]) {
            tagName = @"[linkp]";
        } else if ([tagType isEqualToString:@"video"]) {
            tagName = @"[linkv]";
        } else {
            continue;
        }
        // [linka]百度
        replaceStr = [NSString stringWithFormat:@"%@%@", tagName, [t_str substringWithRange:NSMakeRange(0, t_str.length - 6)]];
        // 替换原有位置的text 为  [linka]百度
        [attString replaceCharactersInRange:NSMakeRange(startIndex, matchRange.length) withString:replaceStr];
        
        NSRange range = NSMakeRange(startIndex, replaceStr.length);
        // 现有位置 添加文字颜色属性
        [attString addAttribute:NSForegroundColorAttributeName
                          value:(id)self.config.urlColor.CGColor
                          range:range];
        // 自定义添加  属性key
        [attString addAttribute:@"keyAttribute"
                          value:[NSString stringWithFormat:@"T%@{%@}", content, [NSValue valueWithRange:range]]
                          range:range];
        
        [self.regularResults addObject:[NSValue valueWithRange:range]];
        forIndex += subString.length - replaceStr.length;
    }
}
#pragma mark ------------------------  url  ---------------------------
- (void)operateUrlWithAttString:(NSMutableAttributedString *)attString {
    NSMutableString * attStr = attString.mutableString;
    NSString *regularStr = [NSString stringWithFormat:@"<a href='(((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%@^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%@^&*+?:_/=<>]*)?))'>((?!<\\/a>).)*<\\/a>|(((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%@^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%@^&*+?:_/=<>]*)?))",@"%",@"%",@"%",@"%"];
    NSError *error = nil;
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:regularStr
                                                                                options:NSRegularExpressionCaseInsensitive
                                                                                  error:&error];
    if (error) return;
    // 匹配结果
    NSArray *allMatches = [expression matchesInString:attStr
                                              options:0
                                                range:NSMakeRange(0, attStr.length)];
    NSInteger forIndex = 0;
    NSInteger startIndex = -1;
    for (NSTextCheckingResult *match in allMatches) {
        NSRange matchRange = match.range;
        if (startIndex == -1) {
            startIndex = matchRange.location;
        } else {
            startIndex = matchRange.location - forIndex;
        }
        // 结果字符串 <a href='https://www.baidu.com'>百度</a>
        NSString *subString = [attStr substringWithRange:NSMakeRange(startIndex, matchRange.length)];
        NSString *content = nil;
        NSString *replaceStr = nil;
        if ([subString hasPrefix:@"<a"]) { // 标签形式 <a href=''>百度</a>
            /*
             @[
                @"<a href='https://www.baidu.com",
                @"百度</a>"
             ]
             */
            NSArray *contentArray = [subString componentsSeparatedByString:@"'>"];
            /*
             @[
                @"<a href=",
                @"https://www.baidu.com"
             ]
             */
            NSArray *attributeArray = [contentArray[0] componentsSeparatedByString:@"'"];
            // https://www.baidu.com
            content = attributeArray[1];
            // 百度</a>
            NSString *t_str = contentArray[1];
            NSString *url_pre = @"[linka]";
            // [linka]百度
            replaceStr = [NSString stringWithFormat:@"%@%@", url_pre, [t_str substringWithRange:NSMakeRange(0, t_str.length - 4)]];
            // 替换
            [attString replaceCharactersInRange:NSMakeRange(startIndex, matchRange.length)
                                     withString:replaceStr];
            NSRange range = NSMakeRange(startIndex, replaceStr.length);
            [attString addAttribute:NSForegroundColorAttributeName
                              value:(id)self.config.urlColor.CGColor
                              range:range];
            // 自定义 属性key
            [attString addAttribute:@"keyAttribute"
                              value:[NSString stringWithFormat:@"H%@{%@}", content, [NSValue valueWithRange:range]]
                              range:range];
            [self.regularResults addObject:[NSValue valueWithRange:range]];
            forIndex += subString.length - replaceStr.length;
        } else { // 链接地址形式  https://www.baidu.com
            replaceStr = [NSString stringWithFormat:@"%@", subString];
            [attString replaceCharactersInRange:NSMakeRange(startIndex, matchRange.length)
                                     withString:replaceStr];
            NSRange range = NSMakeRange(startIndex, replaceStr.length);
            [attString addAttribute:NSForegroundColorAttributeName
                              value:(id)self.config.urlColor.CGColor
                              range:range];
            // 自定义 属性key
            [attString addAttribute:@"keyAttribute"
                              value:[NSString stringWithFormat:@"U%@{%@}", content, [NSValue valueWithRange:range]]
                              range:range];
            // url 有下划线
            if (self.config.urlUnderLine) {
                [attString addAttribute:NSUnderlineStyleAttributeName
                                  value:(id)[NSNumber numberWithInt:NSUnderlineStyleSingle]
                                  range:range];
            }
            [self.regularResults addObject:[NSValue valueWithRange:range]];
            forIndex += subString.length - replaceStr.length;
        }
    }
}
#pragma mark ------------------------  email  ---------------------------
- (void)operateEmailWithAttString:(NSMutableAttributedString *)attString {
    NSMutableString * attStr = attString.mutableString;
    NSString *regularStr = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSError *error = nil;
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:regularStr
                                                                                options:NSRegularExpressionCaseInsensitive
                                                                                  error:&error];
    if (error) return;
    // 匹配结果
    NSArray *allMatches = [expression matchesInString:attStr
                                              options:0
                                                range:NSMakeRange(0, attStr.length)];
    for (NSTextCheckingResult *match in allMatches) {
        NSRange matchRange = match.range;
        NSValue *rangeValue = [NSValue valueWithRange:matchRange];
        NSString *subString = [attStr substringWithRange:matchRange];
        [attString addAttribute:NSForegroundColorAttributeName
                          value:(id)self.config.emailColor.CGColor
                          range:matchRange];
        // 自定义 属性key
        [attString addAttribute:@"keyAttribute"
                          value:[NSString stringWithFormat:@"E%@{%@}", subString, rangeValue]
                          range:matchRange];
        // 下划线
        if (self.config.emailUnderLine) {
            [attString addAttribute:NSUnderlineStyleAttributeName
                              value:(id)[NSNumber numberWithInt:NSUnderlineStyleSingle]
                              range:matchRange];
        }
        [self.regularResults addObject:rangeValue];
    }
}
#pragma mark ------------------------  Phone  ---------------------------
- (void)operatePhoneWithAttString:(NSMutableAttributedString *)attString {
    NSMutableString * attStr = attString.mutableString;
    NSString *regularStr = @"\\d{3}-\\d{8}|\\d{3}-\\d{7}|\\d{4}-\\d{8}|\\d{4}-\\d{7}|1+[358]+\\d{9}|\\d{8}|\\d{7}";
    NSError *error = nil;
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:regularStr
                                                                                options:NSRegularExpressionCaseInsensitive
                                                                                  error:&error];
    if (error) return;
    // 匹配结果
    NSArray *allMatches = [expression matchesInString:attStr
                                              options:0
                                                range:NSMakeRange(0, attStr.length)];
    for (NSTextCheckingResult *match in allMatches) {
        NSRange matchRange = match.range;
        BOOL isContinue = NO;
        for (NSValue *value in self.regularResults) {
            if (NSMaxRange(NSIntersectionRange(matchRange, value.rangeValue)) > 0) {
                isContinue = YES;
                break;
            }
        }
        if (isContinue) continue;
        
        NSString *subString = [attStr substringWithRange:matchRange];
        NSValue *rangeValue = [NSValue valueWithRange:matchRange];
        
        [attString addAttribute:NSForegroundColorAttributeName
                          value:(id)self.config.phoneColor.CGColor
                          range:matchRange];
        // 自定义 属性key
        [attString addAttribute:@"keyAttribute"
                          value:[NSString stringWithFormat:@"P%@{%@}", subString, rangeValue]
                          range:matchRange];
        // 下划线
        if (self.config.phoneUnderLine) {
            [attString addAttribute:NSUnderlineStyleAttributeName
                              value:(id)[NSNumber numberWithInt:NSUnderlineStyleSingle]
                              range:matchRange];
        }
    }
}
#pragma mark ------------------------  @ #xx# <key></key> <subject></subject> <at></at> ---------------------------
- (void)operateOtherAttrString:(NSMutableAttributedString *)attString {
    NSMutableString * attStr = attString.mutableString;
    NSString *regularStr = @"<key>((?!<\\/key>).)*<\\/key>|<subject>((?!<\\/subject>).)*<\\/subject>|<at>((?!<\\/at>).)*<\\/at>|[\\$#@]\\{((?!\\}).)*\\}|\\[[a-zA-Z0-9_\\u3400-\\u9FFF]+\\]";
    NSError *error = nil;
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:regularStr
                                                                                options:NSRegularExpressionCaseInsensitive
                                                                                  error:&error];
    if (error) return;
    // 匹配结果
    NSArray *allMatches = [expression matchesInString:attStr
                                              options:0
                                                range:NSMakeRange(0, attStr.length)];
    NSInteger forIndex = 0;
    NSInteger startIndex = -1;
    
    for (NSTextCheckingResult *match in allMatches) {
        NSRange matchRange = match.range;
        if (startIndex == -1) {
            startIndex = matchRange.location;
        } else {
            startIndex = matchRange.location - forIndex;
        }
        
        NSString *subString = [attStr substringWithRange:NSMakeRange(startIndex, matchRange.length)];
        NSString *content = nil;
        NSString *replaceStr = nil;
        if ([subString hasPrefix:@"<at>"]) {
            content = [subString substringWithRange:NSMakeRange(4, subString.length - 9)];
            replaceStr = [NSString stringWithFormat:@"@%@", content];
            
            [attString replaceCharactersInRange:NSMakeRange(startIndex, matchRange.length)
                                     withString:replaceStr];
            NSRange range = NSMakeRange(startIndex, matchRange.length - 8);
            [attString addAttribute:NSForegroundColorAttributeName
                              value:(id)self.config.atColor.CGColor
                              range:range];
            [attString addAttribute:@"keyAttribute"
                              value:[NSString stringWithFormat:@"@%@{%@}", content, [NSValue valueWithRange:range]]
                              range:range];
            forIndex += 8;
            continue;
        } else if ([subString hasPrefix:@"<subject>"]) {
            content = [subString substringWithRange:NSMakeRange(9, subString.length-19)];
            
            replaceStr = [NSString stringWithFormat:@"#%@#",content];
            
            [attString replaceCharactersInRange:NSMakeRange(startIndex, matchRange.length) withString:replaceStr];
            
            NSRange range = NSMakeRange(startIndex, matchRange.length-17);//9
            
            [attString addAttribute:NSForegroundColorAttributeName
                              value:(id)self.config.subjectColor.CGColor
                              range:range];
            [attString addAttribute:@"keyAttribute"
                              value:[NSString stringWithFormat:@"#%@{%@}",content,[NSValue valueWithRange:range]]
                              range:range];
            
            forIndex += 17;
            continue;
        } else if ([subString hasPrefix:@"<key>"]) {
            content = [subString substringWithRange:NSMakeRange(5, subString.length-11)];
            
            replaceStr = [NSString stringWithFormat:@"%@",content];
            
            [attString replaceCharactersInRange:NSMakeRange(startIndex, matchRange.length) withString:replaceStr];
            
            NSRange range = NSMakeRange(startIndex, matchRange.length-11);
            
            [attString addAttribute:NSForegroundColorAttributeName
                              value:(id)self.config.keyColor.CGColor
                              range:range];
            [attString addAttribute:@"keyAttribute"
                              value:[NSString stringWithFormat:@"$%@{%@}",content, [NSValue valueWithRange:range]]
                              range:range];

            forIndex += 11;
            continue;
        }
        char firstChar = [subString characterAtIndex:0];
        switch (firstChar) {
            case '@': {
                content = [subString substringWithRange:NSMakeRange(2, subString.length - 3)];
                NSArray *contentArray = [content componentsSeparatedByString:@":"];
                NSInteger tempLength = 0;
                if(contentArray.count > 1) {
                    replaceStr = [NSString stringWithFormat:@"@%@",contentArray[0]];
                    tempLength = ((NSString *)contentArray[1]).length + 1;
                    forIndex += tempLength;
                } else {
                    replaceStr = [NSString stringWithFormat:@"@%@",content];
                }
            }
                break;
            case '$': {}
                break;
            case '#': {}
                break;
            case '[': {}
                break;
            default:
                break;
        }
    }
}
@end
