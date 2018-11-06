//
//  UITableViewOneCell.h
//  HuiZhuBang
//
//  Created by BIN on 2017/8/8.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

/**
 图片+文字+文字+图片
 */
@interface UITableViewOneCell : UITableViewCell

@property (nonatomic, strong) NSNumber * type;//0,labelRight右对齐;1左对齐

@end
