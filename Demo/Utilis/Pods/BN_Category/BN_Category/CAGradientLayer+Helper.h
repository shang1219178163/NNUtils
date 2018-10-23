//
//  CAGradientLayer+Helper.h
//  BN_Animation
//
//  Created by hsf on 2018/10/16.
//  Copyright © 2018年 世纪阳天. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAGradientLayer (Helper)

+(CAGradientLayer *)layerWithRect:(CGRect)rect colors:(NSArray *)colors start:(CGPoint)start end:(CGPoint)end;

@end

NS_ASSUME_NONNULL_END
