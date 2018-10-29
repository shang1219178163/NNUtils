//
//  WeakProxy.h
//  Utilis
//
//  Created by hsf on 2018/10/29.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeakProxy : NSProxy

@property (nonatomic, weak, readonly) id target;
- (instancetype)initWithTarget:(id)target;
+ (instancetype)proxyWithTarget:(id)target;

@end


