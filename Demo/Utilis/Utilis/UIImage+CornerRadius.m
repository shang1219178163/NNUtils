//
//  UIImage+CornerRadius.m
//  Utilis
//
//  Created by hsf on 2018/10/25.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UIImage+CornerRadius.h"
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (CornerRadius)


- (UIImage *)circleImage:(UIImage *)image {
    UIGraphicsBeginImageContext(image.size);
    //bezierPathWithOvalInRect方法后面传的Rect,可以看作(x,y,width,height),前两个参数是裁剪的中心点,后面两个决定裁剪的区域是圆形还是椭圆.
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //把路径设置为裁剪区域(超出裁剪区域以外的内容会自动裁剪掉)
    [path addClip];
    //把图片绘制到上下文当中
    [image drawAtPoint:CGPointZero];
    //从上下文当中生成一张新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    //返回新的图片
    return newImage;
}

//这种方法图片很多的话CUP消耗会高，内存占用也会暴增，而且后台线程绘制会比在主线程绘制占用更多的内存，不知道怎么解决？求大神指教！
- (UIImage *)circleImage:(UIImage *)image bounds:(CGRect)bounds{
    
    UIGraphicsBeginImageContext(image.size);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:CGRectGetHeight(bounds)*0.5];
    [path addClip];

    [image drawInRect:bounds];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

-(UIImage*) circleImage:(UIImage*)image inset:(CGFloat) inset {
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, UIColor.redColor.CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset*2.0f, image.size.height - inset*2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}


//SDWebImage处理图片时Core Graphics绘制圆角(最优)
//-(UIImage *)circleImageCG:(UIImage *)image{
//    
//    //UIImage绘制为圆角
//    int w = imageSize.width;
//    int h = imageSize.height;
//    int radius = imageSize.width/2;
//    
//    UIImage *img = image;
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
//    CGRect rect = CGRectMake(0, 0, w, h);
//    
//    CGContextBeginPath(context);
//    addRoundedRectToPath(context, rect, radius, radius);
//    CGContextClosePath(context);
//    CGContextClip(context);
//    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
//    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
//    img = [UIImage imageWithCGImage:imageMasked];
//    
//    CGContextRelease(context);
//    CGColorSpaceRelease(colorSpace);
//    CGImageRelease(imageMasked);
//    return img;
//    
//}


@end
