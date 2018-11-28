//
//  JDGProtocols.h
//  Pods
//
//  Created by JDGan on 2018/11/28.
//

#ifndef JDGProtocols_h
#define JDGProtocols_h

@protocol JDGExtraDataProcessProtocol <NSObject>
- (void)object:(id)object shouldProcessExtraData:(id)data;
@end

#endif /* JDGProtocols_h */
