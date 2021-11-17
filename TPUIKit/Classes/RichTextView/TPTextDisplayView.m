//
//  TPTextDisplayView.m
//  TPUIKit
//
//  Created by Topredator on 2021/11/12.
//

#import "TPTextDisplayView.h"
#import "TPRichTextOperator.h"
#import <CoreText/CoreText.h>
#import "TPRichTextEmoji.h"
@interface TPTextDisplayView ()
@property (nonatomic, strong) NSMutableDictionary *keyRectDict;
@property (nonatomic, strong) NSMutableDictionary *keyAttributeDict;
@property (nonatomic, copy) NSString *currentKey;
@property (nonatomic, copy) NSArray *currentKeyRectArray;
@property (nonatomic, assign) BOOL private_autoHeight;
@property (nonatomic, assign) BOOL private_need_calc_height;
@end

@implementation TPTextDisplayView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initData];
    }
    return self;
}
- (void)initData {
    self.config = [TPRichTextLabelConfig new];
    self.keyRectDict = @{}.mutableCopy;
    self.keyAttributeDict = @{}.mutableCopy;
}

- (void)setText:(NSString *)text {
    _text = text;
    [self setNeedsDisplay];
}
- (void)setConfig:(TPRichTextLabelConfig *)config {
    _config = config;
    _private_autoHeight = config.isAutoHeight;
    _private_need_calc_height = _private_autoHeight;
}
+ (NSMutableAttributedString *)transformAttributeStringWithText:(NSString *)text config:(TPRichTextLabelConfig *)config {
    UIFont * font = config.font;
    CGFloat fontSpace = config.fontSpace;
    CGFloat lineSpace = config.lineSpace;
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    //设置字体
    [attString addAttribute:NSFontAttributeName
                      value:(id)font
                      range:NSMakeRange(0, attString.length)];
    //设置字体颜色
    [attString addAttribute:NSForegroundColorAttributeName
                      value:(id)config.textColor.CGColor
                      range:NSMakeRange(0, attString.length)];
    //设置字距
    [attString addAttribute:NSKernAttributeName
                      value:[NSNumber numberWithFloat:fontSpace]
                      range:NSMakeRange(0, attString.length)];
    // 行间距 对齐模式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [attString addAttribute:NSParagraphStyleAttributeName
                      value:paragraphStyle
                      range:NSMakeRange(0, attString.length)];
    return attString;
}
+ (CGFloat)getHeightWithText:(NSString *)text rectSize:(CGSize)rectSize labelConfig:(TPRichTextLabelConfig *)config {
    if (!text) return 0;
    NSMutableAttributedString *attString = [TPTextDisplayView transformAttributeStringWithText:text config:config];
    TPRichTextOperator *operator = [TPRichTextOperator operateWithConfig:config];
    [operator operateAttributeString:attString];
    CGRect viewRect = CGRectMake(0, 0, rectSize.width, rectSize.height);//CGRectGetHeight(self.bounds)
    
    //创建一个用来描画文字的路径，其区域为当前视图的bounds  CGPath
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathAddRect(pathRef, NULL, viewRect);
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attString);
    
    //创建由framesetter管理的frame，是描画文字的一个视图范围  CTFrame
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, 0), pathRef, nil);
    
    CFArrayRef lines = CTFrameGetLines(frameRef);
    CFIndex lineCount = CFArrayGetCount(lines);
    
    
    CFRelease(pathRef);
    CFRelease(frameRef);
    CFRelease(framesetterRef);
    
    
    CGFloat frameHeight = 0;
    if(config.numberOfLines < 0){
        frameHeight = lineCount * (config.font.lineHeight + config.lineSpace) + config.lineSpace;
    }else{
        frameHeight = config.numberOfLines * (config.font.lineHeight + config.lineSpace) + config.lineSpace;
    }
    
    //四舍五入函数，否则可能会出现一条黑线
    return roundf(frameHeight);
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (!self.text) return;
    
    [self.keyRectDict removeAllObjects];
    [self.keyAttributeDict removeAllObjects];
    
    BOOL isAutoHeight = self.config.isAutoHeight;
    UIFont * font = self.config.font;
    NSInteger numberOfLines = self.config.numberOfLines;
    CGFloat lineSpace = self.config.lineSpace;
    CGSize faceSize = self.config.faceSize;
    CGFloat faceOffset = self.config.faceOffset;
    
    CGFloat highlightBackgroundRadius = self.config.highlightBackgroundRadius;
    UIColor * highlightBackgroundColor = self.config.highlightBackgroundColor;
    
    
    NSMutableAttributedString *attString = [TPTextDisplayView transformAttributeStringWithText:self.text config:self.config];
    
    TPRichTextOperator *operator = [TPRichTextOperator operateWithConfig:self.config];
    [operator operateAttributeString:attString];
    
    // 绘制 上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(contextRef, self.backgroundColor.CGColor);
    
    CGContextSetTextMatrix(contextRef, CGAffineTransformIdentity);
    CGContextTranslateCTM(contextRef, 0, CGRectGetHeight(self.bounds)); // 此处用计算出来的高度
    CGContextScaleCTM(contextRef, 1.0, -1.0);
    
    CGRect viewRect = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGFLOAT_MAX);
    //创建一个用来描画文字的路径，其区域为当前视图的bounds  CGPath
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathAddRect(pathRef, NULL, viewRect);
    
    //创建一个framesetter用来管理描画文字的frame  CTFramesetter
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attString);
    
    //创建由framesetter管理的frame，是描画文字的一个视图范围  CTFrame
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, 0), pathRef, nil);
    
    CFArrayRef lines = CTFrameGetLines(frameRef);
    CFIndex lineCount = CFArrayGetCount(lines);
    
    if (_private_autoHeight && _private_need_calc_height) {
        CFRelease(pathRef);
        CFRelease(frameRef);
        CFRelease(framesetterRef);
        
        _private_autoHeight = NO;
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:0.01];
            dispatch_async(dispatch_get_main_queue(), ^{
                CGRect frame = weakSelf.frame;
                frame.size.height = roundf(lineCount * (font.lineHeight + lineSpace) + lineSpace);
                weakSelf.frame = frame;
                [weakSelf setNeedsDisplay];
            });
        });
        return;
    }
    _private_autoHeight = isAutoHeight;
    CGPoint lineOrigins[lineCount];
    CTFrameGetLineOrigins(frameRef, CFRangeMake(0, 0), lineOrigins);
    
    //绘制高亮区域
    if(self.currentKeyRectArray){
        NSInteger a_count = _currentKeyRectArray.count;
        
        for (int i = 0; i < a_count; i++) {
            NSValue * rectValue =_currentKeyRectArray[i];
            CGRect rect = [rectValue CGRectValue];
            CGPathRef path = [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:highlightBackgroundRadius] CGPath];
            CGContextSetFillColorWithColor(contextRef, highlightBackgroundColor.CGColor);
            CGContextAddPath(contextRef, path);
            CGContextFillPath(contextRef);
        }
    }
    
    CGFloat frameY = 0;
    CGFloat lineHeight = font.lineHeight + lineSpace;
    
    CGRect prevImgRect = CGRectZero;
    for (int i = 0; i < lineCount; i++) {
        if (!isAutoHeight && (numberOfLines >= 0 && !(i < numberOfLines))) break;
        CTLineRef lineRef= CFArrayGetValueAtIndex(lines, i);
        CGPoint lineOrigin = lineOrigins[i];
        frameY = CGRectGetHeight(self.bounds) - (i + 1) * lineHeight - font.descender;
        lineOrigin.y = frameY;
        
        CGContextSetTextPosition(contextRef, lineOrigin.x, lineOrigin.y);
        CTLineDraw(lineRef, contextRef);
        
        CFArrayRef runs = CTLineGetGlyphRuns(lineRef);
        for (int j = 0; j < CFArrayGetCount(runs); j++) {
            CTRunRef runRef = CFArrayGetValueAtIndex(runs, j);
            CGFloat runAscent;
            CGFloat runDescent;
            CGRect runRect;
            runRect.size.width = CTRunGetTypographicBounds(runRef, CFRangeMake(0,0), &runAscent, &runDescent, NULL);
            runRect = CGRectMake(lineOrigin.x + CTLineGetOffsetForStringIndex(lineRef, CTRunGetStringRange(runRef).location, NULL),
                                 lineOrigin.y ,
                                 runRect.size.width,
                                 runAscent + runDescent);
            
            NSDictionary * attributes = (__bridge NSDictionary *)CTRunGetAttributes(runRef);
            NSString * keyAttribute = [attributes objectForKey:@"keyAttribute"];
            if (keyAttribute) {
                CGFloat runAscent,runDescent;
                CGFloat runWidth  = CTRunGetTypographicBounds(runRef, CFRangeMake(0,0), &runAscent, &runDescent, NULL);
                CGFloat runPointX = runRect.origin.x + lineOrigin.x;
                CGFloat runPointY = lineOrigin.y-faceOffset;
                
                CGRect keyRect = CGRectZero;
                char firstCharAttribute = [keyAttribute characterAtIndex:0];
                if (firstCharAttribute == 'F') {
                    
                    NSArray * imageNameArr = [keyAttribute componentsSeparatedByString:@"("];
                    NSString * imageName = (imageNameArr.count > 1) ? [imageNameArr[0] substringWithRange:NSMakeRange(2, ((NSString *)imageNameArr[0]).length -2)] : keyAttribute;
                    UIImage *image = [TPRichTextEmoji emojiName:imageName];
                    if (image) {
                        if ([keyAttribute hasPrefix:@"F:tagLink"] ||
                            [keyAttribute hasPrefix:@"F:tagVideo"] ||
                            [keyAttribute hasPrefix:@"F:tagPhoto"]) {
                            keyRect = CGRectMake(runPointX, runPointY + (lineHeight - self.config.tagImgSize.height)/2.0, self.config.tagImgSize.width, self.config.tagImgSize.height);
                            prevImgRect = CGRectMake(runPointX,
                                                     lineOrigin.y - (lineHeight + self.config.highlightBackgroundAdjustHeight - lineSpace) / 4 - self.config.highlightBackgroundOffset,
                                                     self.config.tagImgSize.width,
                                                     lineHeight + self.config.highlightBackgroundAdjustHeight);
                        } else {
                            keyRect = CGRectMake(runPointX, runPointY, faceSize.width,faceSize.height);
                        }
                        CGContextDrawImage(contextRef, keyRect, image.CGImage);
                    }
                } else if (firstCharAttribute == 'I' ||
                           firstCharAttribute == 'V' ||
                           firstCharAttribute == 'L' ||
                           firstCharAttribute == 'H' ||
                           firstCharAttribute == 'U' ||
                           firstCharAttribute == '@' ||
                           firstCharAttribute == '#' ||
                           firstCharAttribute == '$' ||
                           firstCharAttribute == 'E' ||
                           firstCharAttribute == 'P') {
                    keyRect = CGRectMake(runPointX,
                                         lineOrigin.y - (lineHeight + self.config.highlightBackgroundAdjustHeight - lineSpace) / 4 - self.config.highlightBackgroundOffset,
                                         runWidth,
                                         lineHeight + self.config.highlightBackgroundAdjustHeight);
                    
                    NSMutableArray * obj = [self.keyAttributeDict objectForKey:keyAttribute];
                    if (obj == nil) {
                        obj = [NSMutableArray new];
                        if (firstCharAttribute == 'H' ||
                            firstCharAttribute == 'T') {
                            CGFloat t_w = 0;
                            if (keyRect.origin.x == 0.0f) {
                                [obj addObject:[NSValue valueWithCGRect:prevImgRect]];
                                [self.keyRectDict setObject:keyAttribute forKey:[NSValue valueWithCGRect:prevImgRect]];
                            } else {
                                t_w = self.config.tagImgSize.width;
                            }
                            keyRect = CGRectMake(keyRect.origin.x-t_w, CGRectGetMinY(keyRect), CGRectGetWidth(keyRect)+t_w, CGRectGetHeight(keyRect));
                        }
                    }
                    NSInteger objCount = obj.count;
                    BOOL rep = NO;
                    for (int rect_index = 0; rect_index < objCount; rect_index++){
                        NSValue * rectValue = obj[rect_index];
                        CGRect rect_value = [rectValue CGRectValue];
                        if (rect_value.origin.y == keyRect.origin.y) {
                            rect_value.size.width += keyRect.size.width;
                            [obj replaceObjectAtIndex:rect_index withObject:[NSValue valueWithCGRect:rect_value]];
                            rep = YES;
                            break;
                        }
                    }
                    if (!rep) {
                        [obj addObject:[NSValue valueWithCGRect:keyRect]];
                    }
                    [self.keyAttributeDict setObject:obj forKey:keyAttribute];
                    [self.keyRectDict setObject:keyAttribute forKey:[NSValue valueWithCGRect:keyRect]];
                }
            }
        }
    }
    
    CFRelease(pathRef);
    CFRelease(frameRef);
    CFRelease(framesetterRef);
}


#pragma mark ------------------------  Touches  ---------------------------
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    _private_need_calc_height = NO;
    CGPoint location = [(UITouch *)[touches anyObject] locationInView:self];
    CGPoint runLocation = CGPointMake(location.x, self.frame.size.height - location.y);
    [self.keyRectDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
        CGRect rect = [((NSValue *)key) CGRectValue];
        if (CGRectContainsPoint(rect, runLocation)) {
            NSArray * objArr = [self.keyAttributeDict objectForKey:obj];
            if (objArr) {
                self.currentKeyRectArray = objArr;
                [self setNeedsDisplay];
            }
        }
    }];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    _private_need_calc_height = NO;
    //以下注释打开后 触摸移动时内存消耗比较严重
    ///***
    CGPoint location = [(UITouch *)[touches anyObject] locationInView:self];
    CGPoint runLocation = CGPointMake(location.x, self.frame.size.height - location.y);
    [self.keyRectDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        CGRect rect = [((NSValue *)key) CGRectValue];
        if (CGRectContainsPoint(rect, runLocation)) {
            NSArray * objArr = [self.keyAttributeDict objectForKey:obj];
            if (objArr && (![self.currentKey isEqualToString:obj])) {
                self.currentKey = obj;
                self.currentKeyRectArray = objArr;
                [self setNeedsDisplay];
            }
        }
    }];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    _private_need_calc_height = NO;
    self.currentKey = nil;
    self.currentKeyRectArray = nil;
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    _private_need_calc_height = NO;
    
    CGPoint location = [(UITouch *)[touches anyObject] locationInView:self];
    CGPoint runLocation = CGPointMake(location.x, self.frame.size.height - location.y);
    __weak typeof(self) weakSelf = self;
    [self.keyRectDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        CGRect rect = [((NSValue *)key) CGRectValue];
        if (CGRectContainsPoint(rect, runLocation)) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(tp_textDisplayView:labelType:content:)]) {
                char ch_key = [obj characterAtIndex:0];
                TPRichTextLabelType type = TPRichTextLabelTypeNone;
                if (ch_key == 'U') {
                    type = TPRichTextLabelTypeUrl;
                } else if(ch_key == '@') {
                    type = TPRichTextLabelTypeUser;
                } else if(ch_key == '#') {
                    type = TPRichTextLabelTypeTopic;
                } else if(ch_key == '$') {
                    type = TPRichTextLabelTypeKey;
                } else if(ch_key == 'E') {
                    type = TPRichTextLabelTypeEmail;
                } else if(ch_key == 'P') {
                    type = TPRichTextLabelTypePhone;
                } else if(ch_key == 'H') {
                    type = TPRichTextLabelTypeLinkA;
                } else if(ch_key == 'I') {
                    type = TPRichTextLabelTypeImageTag;
                } else if (ch_key == 'L') {
                    type = TPRichTextLabelTypeLinkTag;
                } else if (ch_key == 'V') {
                    type = TPRichTextLabelTypeVideoTag;
                }
                NSRange endRange = [((NSString *)obj) rangeOfString:@"{"];
                NSString *content = [obj substringWithRange:NSMakeRange(1, endRange.location - 1)];
                [weakSelf.delegate tp_textDisplayView:weakSelf labelType:type content:content];
            }
        }
    }];
    self.currentKey = nil;
    self.currentKeyRectArray = nil;
    [self setNeedsDisplay];
}

@end
