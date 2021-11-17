//
//  TPTextDisplayView.h
//  TPUIKit
//
//  Created by Topredator on 2021/11/12.
//

#import <UIKit/UIKit.h>
#import "TPRichTextLabelConfig.h"
#import "TPRichTextEnum.h"
NS_ASSUME_NONNULL_BEGIN


@class TPTextDisplayView;
@protocol TPTextDisplayViewDelegate <NSObject>
@optional
- (void)tp_textDisplayView:(TPTextDisplayView *)displayView
                 labelType:(TPRichTextLabelType)labelType
                   content:(NSString *)content;
@end

/*
 对于 text的格式:
 1、<tag type='image/link/video' value='image地址/link地址/video地址'></tag>
 2、<a href='https://www.baidu.com'>百度</a>
 3、@Topredator 两种表示:  <at value='id'>Topredator</at> 或 @{Topredator:123}
 4、#话题# 两种表示: #{话题:123} 或 <subject value='123'>话题</subject>
 5、特殊字
     <key value='123'>重点</key> 或 ${重点:123}
 */


/// 富文本 展示视图
@interface TPTextDisplayView : UIView
@property (nonatomic, weak) id <TPTextDisplayViewDelegate> delegate;
@property (nonatomic, copy) NSString *text;
/// 标签配置信息 font、color等
@property (nonatomic, strong) TPRichTextLabelConfig *config;

/// 获取内容高度
+ (CGFloat)getHeightWithText:(NSString *)text
                    rectSize:(CGSize)rectSize
                 labelConfig:(TPRichTextLabelConfig *)config;
@end

NS_ASSUME_NONNULL_END
