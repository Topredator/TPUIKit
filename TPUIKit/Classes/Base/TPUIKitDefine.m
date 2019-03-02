//
//  TPUIKitDefine.m
//  TPUIKit
//
//  Created by Topredator on 2019/2/22.
//
#import "TPUIKitDefine.h"

UIImage *TPModuleImage(NSString *name) {
    NSBundle *bundle = [NSBundle bundleForClass:[TPUIKitDefine class]];
    return [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
}

@implementation TPUIKitDefine
@end
