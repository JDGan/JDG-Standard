//
//  JDGBaseCollectionViewCell.m
//  JDG-Standard
//
//  Created by JDGan on 2018/11/28.
//

#import "JDGBaseCollectionViewCell.h"

@implementation JDGBaseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)customizeWithData:(id)data {
    self.data = data;
}

+ (CGSize)cellSizeForData:(id)data {
    if (@available(iOS 10.0, *)) {
        return UICollectionViewFlowLayoutAutomaticSize;
    } else {
        return CGSizeZero;
    }
}

+ (NSString *)defaultIdentifier {
    return NSStringFromClass(self.class);
}

@end
