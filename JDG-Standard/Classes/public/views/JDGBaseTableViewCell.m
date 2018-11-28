//
//  JDGBaseTableViewCell.m
//  JDG-Standard
//
//  Created by JDGan on 2018/11/28.
//

#import "JDGBaseTableViewCell.h"

@implementation JDGBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.separatorInset = UIEdgeInsetsZero;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)customizeWithData:(id)data {
    self.data = data;
}

+ (CGFloat)cellHeightForData:(id)data {
    return UITableViewAutomaticDimension;
}

+ (NSString *)defaultIdentifier {
    return NSStringFromClass(self.class);
}

@end
