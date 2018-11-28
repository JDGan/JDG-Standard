//
//  JDGBaseViewController.h
//  JDG-Standard
//
//  Created by JDGan on 2018/11/27.
//

#import <UIKit/UIKit.h>
#import <JDG-Standard/JDGMacroDefines.h>
#import <JDG-Standard/JDGBaseObject.h>
#import <JDG-Standard/JDGProtocols.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDGBaseViewController : UIViewController
<JDGExtraDataProcessProtocol>

// 基础页面数据源
@property(nonatomic, retain) JDGListDataSource dataSource;

/**
 创建并通过storyboard初始化视图控制器
 */
+ (instancetype)create;
/**
 获取视图所属的storyboard，如果为nil，create方法返回为nil
 子视图请自行实现
 */
+ (NSString *)storyBoardName;

/**
 刷新主题子视图，所有含主题的子视图需要在该方法内赋值，viewDidLoad会自动调用一次
 */
- (void)refreshThemeSubviews;

@end

NS_ASSUME_NONNULL_END
