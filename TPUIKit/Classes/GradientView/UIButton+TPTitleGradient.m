//
//  UIButton+TPTitleGradient.m
//  TPUIKit
//
//  Created by Topredator on 2024/12/22.
//

#import "UIButton+TPTitleGradient.h"

@implementation UIButton (TPTitleGradient)
- (void)tp_addTitleGradient:(TPUIGradientLayer *)layer {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self layoutIfNeeded];
        layer.frame = CGRectMake(0, 0, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
        [self setTitleColor:[layer tp_colorWithSize:layer.frame.size] forState:UIControlStateNormal];
    });
}
@end
