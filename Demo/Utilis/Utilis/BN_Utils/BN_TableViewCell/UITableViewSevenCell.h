//
//  UITableViewSevenCell.h
//  HuiZhuBang
//
//  Created by BIN on 2017/8/18.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

#import "BN_LabGroupView.h"

/**
 (不推荐)平行多个label
 */
@interface UITableViewSevenCell : UITableViewCell

@property (nonatomic, strong) BN_LabGroupView* groupView;


@end
