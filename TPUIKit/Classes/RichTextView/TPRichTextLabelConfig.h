//
//  TPRichTextLabelConfig.h
//  TPUIKit
//
//  Created by Topredator on 2021/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 富文本 标签配置
@interface TPRichTextLabelConfig : NSObject
/// 文本颜色
@property (nonatomic,strong) UIColor * textColor;
@property (nonatomic,strong) UIFont * font;
/// 字间隔
@property (nonatomic,assign) CGFloat fontSpace;
/// 表情尺寸(长宽相等)
@property (nonatomic,assign) CGSize faceSize;
/// 表情偏移
@property (nonatomic,assign) CGFloat faceOffset;
/// 标签图片尺寸
@property (nonatomic,assign) CGSize tagImgSize;
/// 行间隔
@property (nonatomic,assign) CGFloat lineSpace;
/// 默认为-1(<0为不限制行数)
@property (nonatomic,assign) NSInteger numberOfLines;

/// url下划线
@property (nonatomic,assign) BOOL urlUnderLine;
/// email下划线
@property (nonatomic,assign) BOOL emailUnderLine;
/// phone下划线
@property (nonatomic,assign) BOOL phoneUnderLine;

/// 高亮圆角
@property (nonatomic,assign) CGFloat highlightBackgroundRadius;
/// 高亮背景颜色
@property (nonatomic,strong) UIColor * highlightBackgroundColor;
/// 高亮背景偏移
@property (nonatomic,assign) CGFloat highlightBackgroundOffset;
/// 高亮背景高度调整
@property (nonatomic,assign) CGFloat highlightBackgroundAdjustHeight;
/// 是否自动计算并调整高度()，如果打开，效率将降低一丢丢儿
@property (nonatomic,assign,getter=isAutoHeight) BOOL autoHeight;

@property (nonatomic,strong) UIColor * atColor;
@property (nonatomic,strong) UIColor * subjectColor;
@property (nonatomic,strong) UIColor * keyColor;
@property (nonatomic,strong) UIColor * urlColor;
@property (nonatomic,strong) UIColor * emailColor;
@property (nonatomic,strong) UIColor * phoneColor;        
@end

NS_ASSUME_NONNULL_END
