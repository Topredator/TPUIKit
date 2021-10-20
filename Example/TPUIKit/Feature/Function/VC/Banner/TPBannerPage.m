//
//  TPBannerPage.m
//  TPUIKit_Example
//
//  Created by Topredator on 2021/10/20.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import "TPBannerPage.h"

@interface TPBannerPage ()
@property (nonatomic, strong) TPUIMarginLabel *textLabel;
@end

@implementation TPBannerPage
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews {
    [self addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
- (void)configText:(NSString *)text {
    self.textLabel.text = text;
}
#pragma mark ------------------------  lazy method  ---------------------------
- (TPUIMarginLabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [TPUIMarginLabel marginLabel:UIEdgeInsetsZero];
        _textLabel.font = [TPUI tp_font:13 weight:FontRegular];
        _textLabel.textColor = UIColor.redColor;
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}
@end
