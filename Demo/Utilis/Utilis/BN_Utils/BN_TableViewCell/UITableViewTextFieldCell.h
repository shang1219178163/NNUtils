//
//  UITableViewTextFieldCell.h
//  Utilis
//
//  Created by hsf on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

@interface UITableViewTextFieldCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) NSString * string;
@property (nonatomic, strong) void(^block)(UITableViewTextFieldCell *view, NSString * string);

@end


