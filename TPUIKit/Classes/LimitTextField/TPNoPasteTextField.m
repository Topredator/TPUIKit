//
//  TPNoPasteTextField.m
//  TPUIKit
//
//  Created by Topredator on 2024/10/15.
//

#import "TPNoPasteTextField.h"

@implementation TPNoPasteTextField

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(paste:)) {
        //禁止粘贴
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}
@end
