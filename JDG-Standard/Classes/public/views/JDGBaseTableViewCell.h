//
//  JDGBaseTableViewCell.h
//  JDG-Standard
//
//  Created by JDGan on 2018/11/28.
//

#import <UIKit/UIKit.h>
#import <JDG-Standard/JDGProtocols.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDGBaseTableViewCell : UITableViewCell

@property (nonatomic, weak) id<JDGExtraDataProcessProtocol>delegate;

@property (nonatomic, weak) id data;

- (void)customizeWithData:(id)data;

+ (CGFloat)cellHeightForData:(id)data;

+ (NSString *)defaultIdentifier;

@end

NS_ASSUME_NONNULL_END
