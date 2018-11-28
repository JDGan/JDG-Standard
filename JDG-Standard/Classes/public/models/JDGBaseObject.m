//
//  JDGBaseObject.m
//  JDG-Standard
//
//  Created by JDGan on 2018/11/27.
//

#import "JDGBaseObject.h"

@implementation JDGBaseObject

@end


@implementation JDGBaseListObject

@end


@implementation JDGBaseListSection

- (instancetype)init
{
    self = [super init];
    if (self) {
        _children = [NSMutableArray array];
    }
    return self;
}

@end
