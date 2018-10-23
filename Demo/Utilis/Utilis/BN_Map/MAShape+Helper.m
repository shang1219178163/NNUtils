//
//  MAShape+Helper.m
//  Utilis
//
//  Created by hsf on 2018/10/23.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "MAShape+Helper.h"

#import <objc/runtime.h>

@implementation MAShape (Helper)

-(NSString *)type{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setType:(NSString *)type{
    objc_setAssociatedObject(self, @selector(type), type, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)obj{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setObj:(id)obj{
    objc_setAssociatedObject(self, @selector(obj), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
