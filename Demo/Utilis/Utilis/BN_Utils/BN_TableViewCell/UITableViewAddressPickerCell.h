//
//  UITableViewAddressPickerCell.h
//  Utilis
//
//  Created by hsf on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

#import "BN_PickerViewAddress.h"

@interface UITableViewAddressPickerCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) NSString * addressInfo;

@property (nonatomic, strong) BN_PickerViewAddress * pickerAddress;

@property (nonatomic, strong) void(^block)(UITableViewAddressPickerCell *view, NSString * addressInfo);

@end


