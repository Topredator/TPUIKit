//
//  TPRichTextLabelConfig.m
//  TPUIKit
//
//  Created by Topredator on 2021/11/12.
//

#import "TPRichTextLabelConfig.h"

@implementation TPRichTextLabelConfig
- (instancetype)init {
    self = [super init];
    if (self) {
        [self defaultData];
    }
    return self;
}
- (void)defaultData {
    self.textColor = [UIColor blackColor];
    self.font = [UIFont systemFontOfSize:16];
    self.numberOfLines = -1;
    self.faceOffset = 6;
    self.lineSpace = 4.0;
    self.faceSize = CGSizeMake(22, 22);
    self.tagImgSize = CGSizeMake(14, 14);
    self.highlightBackgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    self.highlightBackgroundOffset = 2.5;
    
    self.atColor = [self defaultColor];
    self.subjectColor = [self defaultColor];
    self.keyColor = [self defaultColor];
    self.urlColor = [self defaultColor];
    
    self.emailColor = [self defaultColor];
    self.phoneColor = [self defaultColor];
    self.autoHeight = YES;
}
- (UIColor *)defaultColor {
    return [UIColor colorWithRed:62 / 255.0
                           green:104 / 255.0
                            blue:162 / 255.0
                           alpha:1.0];
}
@end
