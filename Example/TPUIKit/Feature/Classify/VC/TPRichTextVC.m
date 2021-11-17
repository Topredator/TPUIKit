//
//  TPRichTextVC.m
//  TPUIKit_Example
//
//  Created by Topredator on 2021/11/15.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import "TPRichTextVC.h"
#import <TPUIKit/TPTextDisplayView.h>
@interface TPRichTextVC () <TPTextDisplayViewDelegate>

@end

@implementation TPRichTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RichText";
    [TPRichTextEmoji.shared configEmojiBundleName:@"RichText"];
    [self setupSubviews];
}
- (void)setupSubviews {
    
    NSString *text = @"登录<at value='123'>点击试下</at>即代表<key value='234'>这是key啊</key>阅读<subject value='345'>项目</subject>[拜拜][哈哈][呵呵]luyanggold@163.com并<a href='www.baidu.com'>百度</a>同意${《学天教育服务协议》:123} 和 ${《第三方协议》} <tag type='image' value='xxx'>展示一张图片</tag>紧接着<tag type='video' value='xxx'>你猜猜是什么</tag>再来一个<tag type='link' value='https://www.baidu.com'>链接</tag>";
    
    TPTextDisplayView *displayView = [[TPTextDisplayView alloc] initWithFrame:CGRectZero];
    displayView.text = text;
    displayView.delegate = self;
    displayView.backgroundColor = [TPUI tp_t:234];
    [self.view addSubview:displayView];
    
    [displayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo([TPTextDisplayView getHeightWithText:text rectSize:CGSizeMake(TPUI.tp_screenWidth - 20, CGFLOAT_MAX) labelConfig:[TPRichTextLabelConfig new]]);
    }];
    
}
#pragma mark ------------------------  TPTextDisplayViewDelegate  ---------------------------
- (void)tp_textDisplayView:(TPTextDisplayView *)displayView labelType:(TPRichTextLabelType)labelType content:(NSString *)content {
    NSLog(@"type = %ld\ncontent = %@", labelType, content);
}
@end
