//
//  JDGCategorys.m
//  JDG-Standard
//
//  Created by JDGan on 2018/11/28.
//

#import "JDGCategorys.h"
#import "JDGMacroDefines.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>

@implementation NSString (HYRegex)

- (NSArray <NSString *>*)regexWithPattern:(NSString *)pattern {
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    //测试字符串
    NSArray *results = [regex matchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    NSMutableArray *rlts = [NSMutableArray array];
    [results enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSTextCheckingResult *r = obj;
        [rlts addObject:[self substringWithRange:r.range]];
    }];
    return rlts;
}

- (BOOL)regexMatchPattern:(NSString *)pattern {
    NSArray *arr = [self regexWithPattern:pattern];
    return arr.count > 0;
}

@end

@implementation UIImage (HYCustom)

+ (UIImage *)imageHYNamed:(NSString *)name {
    NSInteger scale = [[UIScreen mainScreen] scale];
    NSMutableString *imageName = [NSMutableString stringWithFormat:@"images/%@",name];
    if(scale > 0) {
        [imageName appendFormat:@"@%ldx",(long)scale];
    }
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:imageName ofType:@"png"];
    if(path == nil) {
        return [UIImage imageNamed:name];
    }
    return [UIImage imageWithContentsOfFile:path];
}

@end

@implementation UIView (HYCustom)

- (void)roundWithCornerRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)addDefaultCorner {
    [self roundWithCornerRadius:5];
}

- (void)addBorderWithColor:(UIColor *)color {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 0.5;
}

@end

@implementation JDGString

- (NSDictionary *)attributesDictionary {
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    if(self.font != nil) {
        [mDic setObject:self.font forKey:NSFontAttributeName];
    }
    
    if(self.color != nil) {
        [mDic setObject:self.color forKey:NSForegroundColorAttributeName];
    }
    
    if(self.paragraphStyle != nil) {
        [mDic setObject:self.paragraphStyle forKey:NSParagraphStyleAttributeName];
    }
    return mDic;
}

@end

@interface JDGStringFormatter ()
@property (nonatomic, retain) NSMutableArray <JDGString *>* stringArray;
@end

@implementation NSAttributedString (HYCustom)

+ (NSAttributedString *)jdg_makeAttributeString:(void (NS_NOESCAPE ^)(JDGStringFormatter *))block {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];
    JDGStringFormatter *formatter = [JDGStringFormatter new];
    block(formatter);
    for(JDGString *s in formatter.stringArray) {
        if(s.text.length <= 0) {continue;}
        NSMutableAttributedString *subString = [[NSMutableAttributedString alloc] initWithString:s.text];
        [subString addAttributes:s.attributesDictionary range:NSMakeRange(0, s.text.length)];
        [str appendAttributedString:subString];
    }
    return [[NSAttributedString alloc] initWithAttributedString:str];
}

@end



@implementation JDGStringFormatter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.stringArray = [NSMutableArray array];
    }
    return self;
}

- (JDGStringFormatter *(^)(AttributeObjectBlock block))add {
    return ^id(AttributeObjectBlock attributeBlock) {
        JDGString *attrString = [JDGString new];
        attributeBlock(attrString);
        [self.stringArray addObject:attrString];
        return self;
    };
}

@end

@implementation UILabel (AttributeTextAction)

- (BOOL)isTouch
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsTouch:(BOOL)isTouch
{
    objc_setAssociatedObject(self, @selector(isTouch), @(isTouch), OBJC_ASSOCIATION_ASSIGN);
}

- (NSMutableDictionary *)actionBlockDict
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setActionBlockDict:(NSMutableDictionary *)actionBlockDict
{
    objc_setAssociatedObject(self, @selector(actionBlockDict), actionBlockDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setJdg_tapBlock:(void (^)(NSInteger, NSAttributedString * _Nonnull))jdg_tapBlock {
    objc_setAssociatedObject(self, @"jdg_tapBlock", jdg_tapBlock, OBJC_ASSOCIATION_COPY);
    self.userInteractionEnabled = YES;
    JDGTextObject *textObject = [JDGTextObject new];
    self.textObject = textObject;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jdg_tapAction:)];
    [self addGestureRecognizer:tapGestureRecognizer];
}
- (void (^)(NSInteger, NSAttributedString *))jdg_tapBlock {
    return objc_getAssociatedObject(self, @"jdg_tapBlock");
}
- (void)setTextObject:(JDGTextObject *)textObject {
    objc_setAssociatedObject(self, @"textObject", textObject, OBJC_ASSOCIATION_RETAIN);
}
- (JDGTextObject *)textObject {
    return objc_getAssociatedObject(self, @"textObject");
}
#pragma mark -Event
- (void)jdg_tapAction:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:recognizer.view];
    //    NSLog(@"location = %@",NSStringFromCGPoint(location));
    WeakSelf;
    [self.textObject selectLocation:location ofLabel:(UILabel *)recognizer.view selectedBlock:^(NSInteger index, NSAttributedString *charAttributedString) {
        if (selfWeak.jdg_tapBlock) {
            selfWeak.jdg_tapBlock(index,charAttributedString);
        }
    }];
}

- (void)jdg_addAttributeText:(NSString *)string action:(AttributeActionBlock)actionBlock {
    WeakSelf;
    self.jdg_tapBlock = ^(NSInteger index, NSAttributedString *charAttributedString) {
        NSString *labelText = selfWeak.attributedText.string;
        NSRange range = [labelText rangeOfString:string];
        if(index >= range.location && index <= range.location+range.length) {
            if(actionBlock) {
                actionBlock(string);
            }
        }
    };
}

- (void)jdg_addAttributeTextArray:(NSArray <NSString *>*)stringArray action:(AttributeActionBlock)actionBlock {
    WeakSelf;
    self.jdg_tapBlock = ^(NSInteger index, NSAttributedString *charAttributedString) {
        NSString *labelText = selfWeak.attributedText.string;
        NSRange range;
        for(NSString *string in stringArray){
            range = [labelText rangeOfString:string];
            if(index >= range.location && index <= range.location+range.length) {
                if(actionBlock) {
                    actionBlock(string);
                    break;
                }
            }
        }
    };
}

@end


@implementation JDGTextObject

- (instancetype)init {
    self = [super init];
    if (self) {
        self.textStorage = [NSTextStorage new];
        self.layoutManager = [NSLayoutManager new];
        self.textContainer = [NSTextContainer new];
        [self.textStorage addLayoutManager:self.layoutManager];
        [self.layoutManager addTextContainer:self.textContainer];
    }
    return self;
}
- (void)selectLocation:(CGPoint)location
               ofLabel:(UILabel *)label
         selectedBlock:(void (^)(NSInteger index,NSAttributedString *string))selectedBlock {
    self.textContainer.size = label.bounds.size;
    self.textContainer.lineFragmentPadding = 0;
    self.textContainer.maximumNumberOfLines = label.numberOfLines;
    self.textContainer.lineBreakMode = label.lineBreakMode;
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:label.attributedText];
    NSRange textRange = NSMakeRange(0, attributedText.length);
    [attributedText addAttribute:NSFontAttributeName value:label.font range:textRange];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = label.textAlignment;
    [attributedText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    [self.textStorage setAttributedString:attributedText];
    
    CGSize textSize = [self.layoutManager usedRectForTextContainer:self.textContainer].size;
    //    location.x -= (CGRectGetWidth(self.label.frame) - textSize.width) / 2;
    location.y -= (CGRectGetHeight(label.frame) - textSize.height) / 2;
    
    NSUInteger glyphIndex = [self.layoutManager glyphIndexForPoint:location inTextContainer:self.textContainer];
    CGFloat fontPointSize = label.font.pointSize;
    [self.layoutManager setAttachmentSize:CGSizeMake(fontPointSize, fontPointSize) forGlyphRange:NSMakeRange(label.text.length - 1, 1)];
    NSAttributedString *attributedSubstring = [label.attributedText attributedSubstringFromRange:NSMakeRange(glyphIndex, 1)];
    CGRect glyphRect = [self.layoutManager boundingRectForGlyphRange:NSMakeRange(glyphIndex, 1)
                                                     inTextContainer:self.textContainer];
    if (!CGRectContainsPoint(glyphRect, location)) {
        if (CGRectContainsPoint(CGRectMake(0, 0, textSize.width, textSize.height), location)) {
            //            NSLog(@"in");
        }
        selectedBlock(-1,nil);
        return;
    }
    selectedBlock(glyphIndex,attributedSubstring);
}

@end


