//
//  UITableViewSegmentCell.h
//  Utilis
//
//  Created by hsf on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

@interface UITableViewSegmentCell : UITableViewCell

@property (nonatomic, strong) UISegmentedControl * segmentCtrl;
@property (nonatomic, strong) NSArray * segmentItems;

@end

