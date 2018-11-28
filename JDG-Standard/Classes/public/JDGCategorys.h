//
//  JDGCategorys.h
//  JDG-Standard
//
//  Created by JDGan on 2018/11/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class JDGString;
typedef void(^AttributeObjectBlock)(JDGString *object);
typedef void(^AttributeActionBlock)(NSString *string);

#pragma mark - NSString
@interface NSString (HYRegex)
/**
 匹配正则的字符串结果数组
 */
- (NSArray <NSString *>*)regexWithPattern:(NSString *)pattern;
/**
 是否匹配正则
 */
- (BOOL)regexMatchPattern:(NSString *)pattern;
@end
#pragma mark - UIImage
@interface UIImage (HYCustom)
/**
 用imageWithContentsOfFile:path实现named方法的封装
 */
+ (UIImage *)imageHYNamed:(NSString *)name;

@end
#pragma mark - UIView
@interface UIView (HYCustom)

- (void)roundWithCornerRadius:(CGFloat)radius;

- (void)addDefaultCorner;

- (void)addBorderWithColor:(UIColor *)color;

@end
#pragma mark - NSAttributedString
@interface JDGString : NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, retain) UIColor *color;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) NSParagraphStyle *paragraphStyle;
- (NSDictionary *)attributesDictionary;
@end

@interface JDGStringFormatter : NSObject

- (JDGStringFormatter * (^)(AttributeObjectBlock))add;

@end

@interface NSAttributedString (HYCustom)

+ (NSAttributedString *)jdg_makeAttributeString:(void(NS_NOESCAPE ^)(JDGStringFormatter *formatter))block;

@end
#pragma mark - UILabel
@interface JDGTextObject : NSObject
@property (nonatomic,retain) NSTextStorage *textStorage;
@property (nonatomic,retain) NSLayoutManager *layoutManager;
@property (nonatomic,retain) NSTextContainer *textContainer;
/**
 * 获取UILabel点击的位置
 */
- (void)selectLocation:(CGPoint)location
               ofLabel:(UILabel *)label
         selectedBlock:(void (^)(NSInteger index,NSAttributedString *string))selectedBlock;

@end

@interface UILabel (AttributeTextAction)

@property (nonatomic,retain) JDGTextObject *textObject;
/**
 * 点击回调
 */
@property (nonatomic,copy) void (^jdg_tapBlock)(NSInteger index,NSAttributedString *string);
/**
 给字符串添加点击事件
 */
- (void)jdg_addAttributeText:(NSString *)string action:(AttributeActionBlock)actionBlock;
- (void)jdg_addAttributeTextArray:(NSArray <NSString *>*)stringArray action:(AttributeActionBlock)actionBlock;

@end


NS_ASSUME_NONNULL_END
