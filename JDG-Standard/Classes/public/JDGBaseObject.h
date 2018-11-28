//
//  JDGBaseObject.h
//  JDG-Standard
//
//  Created by JDGan on 2018/11/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDGBaseObject : NSObject

@end


@interface JDGBaseListObject : JDGBaseObject
/**
 SB中cell的id
 */
@property (nonatomic,copy) NSString *cellIdentifier;
/**
 关联的数据
 */
@property (nonatomic, retain) id data;
/**
 为collectionView设计的尺寸字段
 */
@property (nonatomic,assign) CGSize itemSize;
/**
 为tableView设计的高度字段
 */
@property (nonatomic,assign) CGFloat itemHeight;

@end


@interface JDGBaseListSection : JDGBaseObject
/**
 关联的数据
 */
@property (nonatomic, retain) id data;
/**
 段子元素
 */
@property (nonatomic,retain) NSMutableArray<JDGBaseListObject *>* children;

@end

// 自定义的默认数据源数组
typedef NSMutableArray<JDGBaseListSection *>* JDGListDataSource;

NS_ASSUME_NONNULL_END
