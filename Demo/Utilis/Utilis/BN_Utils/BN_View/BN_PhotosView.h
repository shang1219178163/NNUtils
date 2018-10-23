//
//  BN_PhotosView.h
//  HuiZhuBang
//
//  Created by BIN on 2017/10/19.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//
/**
 点击任意地方,弹出全屏图片展示
 用法
 BN_PhotosView * dispalyView = [[BN_PhotosView alloc]initWithImages:self.images];
 [dispalyView show];
 */
#import <UIKit/UIKit.h>

@interface BN_PhotosView : UIView

-(instancetype)initWithImages:(NSArray *)images;

-(void)show;
-(void)shwAtIndex:(NSInteger)index;

-(void)dismiss;

@end
