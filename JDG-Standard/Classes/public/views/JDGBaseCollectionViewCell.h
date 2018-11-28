//
//  JDGBaseCollectionViewCell.h
//  JDG-Standard
//
//  Created by JDGan on 2018/11/28.
//

#import <UIKit/UIKit.h>
#import <JDG_Standard/JDGProtocols.h>
NS_ASSUME_NONNULL_BEGIN

@interface JDGBaseCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<JDGExtraDataProcessProtocol>delegate;

@property (nonatomic, weak) id data;

- (void)customizeWithData:(id)data;

+ (CGSize)cellSizeForData:(id)data;

+ (NSString *)defaultIdentifier;

@end

NS_ASSUME_NONNULL_END
