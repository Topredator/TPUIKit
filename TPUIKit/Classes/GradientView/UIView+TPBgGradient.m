//
//  UIView+TPBgGradient.m
//  TPUIKit
//
//  Created by Topredator on 2024/12/22.
//

#import "UIView+TPBgGradient.h"
#import <objc/runtime.h>

@interface UIView (TPBgGradient)
@property (nonatomic, strong) TPUIGradientLayer *tp_borderLayer;
@end

static char kTPGradientBorderLayer;
@implementation UIView (TPBgGradient)
- (TPUIGradientLayer *)tp_borderLayer {
    return objc_getAssociatedObject(self, &kTPGradientBorderLayer);
}
- (void)setTp_borderLayer:(TPUIGradientLayer *)tp_borderLayer {
    objc_setAssociatedObject(self, &kTPGradientBorderLayer, tp_borderLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)tp_addGradient:(TPUIGradientLayer *)layer {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self layoutIfNeeded];
        layer.frame = self.bounds;
        self.backgroundColor = [layer tp_colorWithSize:layer.frame.size];
    });
}

- (void)tp_addBorderGradient:(TPUIGradientLayer *)layer {
    [self tp_addBorderGradient:layer lineWidth:1 corners:UIRectCornerAllCorners cornerRadius:0];
}
- (void)tp_addBorderGradient:(TPUIGradientLayer *)layer lineWidth:(CGFloat)lineWidth corners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self layoutIfNeeded];
        layer.frame = self.bounds;
        CAShapeLayer *maskLayer = [CAShapeLayer new];
        maskLayer.lineWidth = lineWidth;
        maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)].CGPath;
        maskLayer.fillColor = UIColor.clearColor.CGColor;
        maskLayer.strokeColor = UIColor.whiteColor.CGColor;
        layer.mask = maskLayer;
        self.tp_borderLayer = layer;
        [self.layer addSublayer:layer];
    });
}
- (void)tp_removeBorderGradient {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self layoutIfNeeded];
        if (self.tp_borderLayer) {
            [self.tp_borderLayer removeFromSuperlayer];
            self.tp_borderLayer = nil;
        }
    });
}
@end
