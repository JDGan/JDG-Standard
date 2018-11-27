//
//  JDGBaseViewController.h
//  JDG-Standard
//
//  Created by JDGan on 2018/11/27.
//

#import <UIKit/UIKit.h>

@protocol JDGExtraDataProcessProtocol <NSObject>
- (void)object:(id)object shouldProcessExtraData:(id)data;
@end

NS_ASSUME_NONNULL_BEGIN

@interface JDGBaseViewController : UIViewController
<JDGExtraDataProcessProtocol>

@end

NS_ASSUME_NONNULL_END
