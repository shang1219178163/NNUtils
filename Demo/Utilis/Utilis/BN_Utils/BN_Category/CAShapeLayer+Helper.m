//
//  CAShapeLayer+Helper.m
//  ProductTemplet
//
//  Created by hsf on 2018/9/29.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "CAShapeLayer+Helper.h"

@implementation CAShapeLayer (Helper)

+(CAShapeLayer *)layerWithRect:(CGRect)rect path:(CGPathRef)path strokeEnd:(CGFloat)strokeEnd fillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth{
    
    //初始化一个实例对象
    CAShapeLayer *layer = CAShapeLayer.layer;
    
    layer.frame        = rect;  //设置大小
    //        layer.position      = self.view.center;            //设置中心位置
    layer.path          = [UIBezierPath bezierPathWithOvalInRect:layer.bounds].CGPath; //设置绘制路径
    layer.strokeEnd     = strokeEnd;        //设置轮廓结束位置
    layer.fillColor     = fillColor.CGColor;   //设置填充颜色
    layer.strokeColor   = strokeColor.CGColor;      //设置划线颜色
    layer.lineWidth     = lineWidth;          //设置线宽
    layer.lineCap       = @"round";    //设置线头形状
    return layer;
}

+(CAShapeLayer *)layerWithSender:(CALayer *)sender path:(CGPathRef)path fillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor opacity:(CGFloat)opacity{
    
    //初始化一个实例对象
    CAShapeLayer *layer = CAShapeLayer.layer;
    layer.frame        = sender.bounds;;  //设置大小
    //        layer.position      = self.view.center;            //设置中心位置
    layer.fillColor     = fillColor.CGColor;   //设置填充颜色
    layer.strokeColor   = strokeColor.CGColor;      //设置划线颜色
    layer.backgroundColor = UIColor.clearColor.CGColor;
    
    layer.opacity = opacity;
    layer.path = path;
    
    return layer;
}

@end
