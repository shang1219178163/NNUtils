//
//  UITableViewTextViewCell.h
//  Utilis
//
//  Created by hsf on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

@interface UITableViewTextViewCell : UITableViewCell

@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) void(^block)(UITableViewTextViewCell *view, UITextView * textView);

@end

