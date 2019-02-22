//
//  TPUIKitDefine.m
//  TPUIKit
//
//  Created by Topredator on 2019/2/22.
//

#import "TPUIKitDefine.h"


UIImage *TPModuleImage(NSString *imageName) {
    NSBundle *bundle = [NSBundle bundleForClass:[TPUIKitDefine class]];
    return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
}

@implementation TPUIKitDefine

@end
