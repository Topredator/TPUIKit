//
//  TPLine.h
//  TPUIKit
//
//  Created by Topredator on 2024/10/15.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TPLineAlignment) {
    TPLineAlignmentHorizontalTop = 1,
    TPLineAlignmentHorizontalBottom = 2,
    TPLineAlignmentVerticalLeft = -1,
    TPLineAlignmentVerticalRight = -2
};

typedef NS_OPTIONS(NSUInteger, TPLineOptionMask) {
    TPLineOptionNone = 0,
    TPLineOptionPixel = 1 << 0,
    TPLineOptionDash = 1 << 1,
};

/// 自定义线条
@interface TPLine : UIView
///(default is HEXCOLOR(@"#E3E3E3"))
@property (nonatomic, strong) UIColor *lineColor UI_APPEARANCE_SELECTOR;
///(线的像素宽度 default is 1px)
@property (nonatomic, assign) CGFloat linePixelWidth;
///(线的点宽度 default is 1)
@property (nonatomic, assign) CGFloat linePointWidth;
///(default is TPLineOptionNone)
@property (nonatomic, assign) TPLineOptionMask lineOptions;
///(default is TPLineAlignmentHorizontalTop)
@property (nonatomic, assign) TPLineAlignment lineAlignment;
///虚线的线段长短
@property (nonatomic, strong) NSArray *dashLengths;
@end

