//
//  WHKTableViewTwelveCell.m
//  HuiZhuBang
//
//  Created by BIN on 2017/9/14.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewTwelveCell.h"
#import "BN_Globle.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"

@interface WHKTableViewTwelveCell ()

@end

@implementation WHKTableViewTwelveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{


}

-(void)layoutSubviews{
    [super layoutSubviews];
    


    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
