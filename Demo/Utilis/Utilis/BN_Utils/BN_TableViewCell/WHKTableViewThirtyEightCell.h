//
//  WHKTableViewThirtyEightCell.h
//  HuiZhuBang
//
//  Created by BIN on 2017/11/13.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"
#import "BN_ImgLabelView.h"

@interface WHKTableViewThirtyEightCell : UITableViewCell

@property (nonatomic, strong) UIButton * btn;

@property (nonatomic, strong) UILabel * labTitle;
@property (nonatomic, strong) UILabel * labRight;

@property (nonatomic, strong) BN_ImgLabelView * imgLabViewOne;
@property (nonatomic, strong) BN_ImgLabelView * imgLabViewTwo;

@property (nonatomic, strong) UIView * lineTop;

+(instancetype)cellWithTableView:(UITableView *)tableview;

@property (nonatomic, copy) void (^block)(WHKTableViewThirtyEightCell *cell, UIButton *sender);


@end
