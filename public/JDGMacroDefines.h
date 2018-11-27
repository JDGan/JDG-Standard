//
//  JDGMacroDefines.h
//  Pods
//
//  Created by JDGan on 2018/11/27.
//

#ifndef JDGMacroDefines_h
#define JDGMacroDefines_h

#pragma mark - 自定义通用线程
#define MainThread(block)                                   \
    if ([NSThread isMainThread]) {                          \
        block();                                            \
    } else {                                                \
        dispatch_async(dispatch_get_main_queue(), block);   \
    }

#define GlobalThread(block)                                 \
    if ([NSThread isMainThread]) {                          \
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),block);\
    } else {                                                \
        block();                                            \
    }

#pragma mark - 自定义blocks
typedef void(^VoidBlock)(void);
typedef void(^DataBlock)(id data);
typedef void(^SuccessDataBlock)(BOOL success, id data);

#endif /* JDGMacroDefines_h */
