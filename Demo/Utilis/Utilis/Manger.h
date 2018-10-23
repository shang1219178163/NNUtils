//
//  Manger.h
//  Utilis
//
//  Created by hsf on 2018/10/23.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Manger : NSObject

+(id)shared;

+(void)destoryShared;
    
@end

NS_ASSUME_NONNULL_END
