//
//  UITableViewDateRangeCell.h
//  Utilis
//
//  Created by hsf on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

@interface UITableViewDateRangeCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) BN_TextField * textFieldLeft;
@property (nonatomic, strong) BN_TextField * textFieldRight;

@property (nonatomic, strong) void(^block)(UITableViewDateRangeCell *view, NSString * dateStart, NSString * dateEnd, id obj, NSInteger idx);

@end
