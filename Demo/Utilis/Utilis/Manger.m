//
//  Manger.m
//  Utilis
//
//  Created by hsf on 2018/10/23.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "Manger.h"

@implementation Manger

static dispatch_once_t onceToken;
static Manger *_instance = nil;

+(id)shared{
    dispatch_once(&onceToken, ^{
        _instance = [[Manger alloc]init];
    });
    return _instance;
    
}

+(void)destoryShared{
    onceToken = 0;
    _instance = nil;
    
}

@end
