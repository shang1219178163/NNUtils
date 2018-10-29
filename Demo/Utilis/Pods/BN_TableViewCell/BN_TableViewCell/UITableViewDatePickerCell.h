//
//  UITableViewDatePickerCell.h
//  Utilis
//
//  Created by hsf on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

#import "BN_DatePicker.h"

@interface UITableViewDatePickerCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) NSString * dateStr;

@property (nonatomic, strong) BN_DatePicker * datePicker;

@property (nonatomic, strong) void(^block)(UITableViewDatePickerCell *view, NSString * dateStr);

@end
