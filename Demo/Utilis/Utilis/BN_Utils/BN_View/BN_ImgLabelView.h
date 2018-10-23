//
//  BN_ImgLabelView.h
//  HuiZhuBang
//
//  Created by BIN on 2017/9/27.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BN_ImgLabelView : UIView

@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) UILabel * labelTitle;

+ (BN_ImgLabelView *)labWithImage:(id)image imageSize:(CGSize)imageSize;

//+ (BN_ImgLabelView *)labWithRect:(CGRect)rect image:(id)image imageSize:(CGSize)imageSize;

@end
