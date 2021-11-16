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
- (void)tp_textDisplayView:(TPTextDisplayView *)displayView labelType:(TPRichTextLabelType)labelType content:(NSString *)content;
@end

/// 富文本 展示视图
@interface TPTextDisplayView : UIView
@property (nonatomic, weak) id <TPTextDisplayViewDelegate> delegate;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) TPRichTextLabelConfig *config;

/// 获取内容高度
+ (CGFloat)getHeightWithText:(NSString *)text
                    rectSize:(CGSize)rectSize
                 labelConfig:(TPRichTextLabelConfig *)config;
@end

NS_ASSUME_NONNULL_END
