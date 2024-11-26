//
//  TPLine.m
//  TPUIKit
//
//  Created by Topredator on 2024/10/15.
//

#import "TPLine.h"

@implementation TPLine
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self commonInit];
}

- (void)commonInit
{
    self.backgroundColor = [UIColor clearColor];
    self.linePixelWidth = 1;
    self.linePointWidth = 1;
    self.lineAlignment = TPLineAlignmentHorizontalTop;
    self.lineOptions = TPLineOptionNone;
    self.dashLengths = @[@8, @2];
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGFloat lineWidth = self.lineOptions & TPLineOptionPixel ? self.linePixelWidth : self.linePointWidth * [UIScreen mainScreen].scale;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //关闭抗锯齿
    CGContextSetAllowsAntialiasing(ctx,NO);
    CGContextBeginPath(ctx);
    CGContextSetStrokeColorWithColor(ctx, self.lineColor.CGColor);
    //设置虚线
    if (self.lineOptions & TPLineOptionDash) {
        CGFloat dashLengths[2] = {[self.dashLengths[0] floatValue], [self.dashLengths[1] floatValue]};
        CGContextSetLineDash(ctx, 0,  dashLengths, 2);
    }
    CGContextSetLineWidth(ctx, lineWidth);
    CGFloat x1 = self.lineAlignment == TPLineAlignmentVerticalRight ? rect.size.width : 0;
    CGFloat y1 = self.lineAlignment == TPLineAlignmentHorizontalBottom ? rect.size.height : 0;
    CGFloat x2 = self.lineAlignment > 0 ? rect.size.width : x1;
    CGFloat y2 = self.lineAlignment < 0 ? rect.size.height : y1;
    CGContextMoveToPoint(ctx, x1, y1);
    CGContextAddLineToPoint(ctx, x2, y2);
    CGContextStrokePath(ctx);
}
@end
