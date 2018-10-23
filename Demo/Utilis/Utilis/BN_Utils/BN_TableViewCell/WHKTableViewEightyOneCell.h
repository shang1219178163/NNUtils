//
//  WHKTableViewEightyOneCell.h
//  HuiZhuBang
//
//  Created by BIN on 2018/5/9.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

@interface WHKTableViewEightyOneCell : UITableViewCell

@property (nonatomic, strong) NSArray *itemManger;

@property (nonatomic, copy) void(^block)(WHKTableViewEightyOneCell * view, UIImageView * obj, UILabel * item, NSInteger idx);

@end
