//
//  UILabel+TPTitleGradient.m
//  TPUIKit
//
//  Created by Topredator on 2024/12/22.
//

#import "UILabel+TPTitleGradient.h"

@implementation UILabel (TPTitleGradient)
- (void)tp_addTitleGradient:(TPUIGradientLayer *)layer {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self layoutIfNeeded];
        layer.frame = self.bounds;
        self.textColor = [layer tp_colorWithSize:layer.frame.size];
    });
}
@end
