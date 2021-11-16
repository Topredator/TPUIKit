//
//  TPRichTextEnum.h
//  TPUIKit
//
//  Created by Topredator on 2021/11/12.
//

#ifndef TPRichTextEnum_h
#define TPRichTextEnum_h


/// 富文本 标签类型
typedef NS_ENUM(NSInteger, TPRichTextLabelType) {
    TPRichTextLabelTypeNone,
    TPRichTextLabelTypeImageTag,  // image
    TPRichTextLabelTypeVideoTag, // Video
    TPRichTextLabelTypeLinkTag, // Link
    TPRichTextLabelTypeLinkA, // <a></a>
    TPRichTextLabelTypeUrl, // 链接www.baidu.com
    TPRichTextLabelTypeEmail, // xxxxx@163.com
    TPRichTextLabelTypeKey, 
    TPRichTextLabelTypePhone, // 0571-12345678 或者 13800000000
    TPRichTextLabelTypeUser, // @Topredator
    TPRichTextLabelTypeTopic, // #话题#
    TPRichTextLabelTypeEmoji, // 👍🏻😘
    
};


#endif /* TPRichTextEnum_h */
