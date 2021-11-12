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
    self.faceSize = CGSizeMake(20, 20);
    self.tagImgSize = CGSizeMake(14, 14);
    self.highlightBackgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    
    self.atColor = [UIColor blueColor];
    self.subjectColor = [UIColor blueColor];
    self.keyColor = [UIColor blueColor];
    self.urlColor = [UIColor blueColor];
    
    self.emailColor= [UIColor blueColor];
    self.phoneColor = [UIColor blueColor];
}
@end
