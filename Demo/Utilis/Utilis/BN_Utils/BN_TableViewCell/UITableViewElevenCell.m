//
//  UITableViewElevenCell.m
//  HuiZhuBang
//
//  Created by BIN on 2017/9/13.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "UITableViewElevenCell.h"
#import "BN_Globle.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"

#import "BN_RadioView.h"

@interface UITableViewElevenCell ()
 
@end

@implementation UITableViewElevenCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字+文字+单选按钮
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftSub];
    [self.contentView addSubview:self.radioView];
    

}

-(void)layoutSubviews{
    [super layoutSubviews];
    

    //文字+文字+图片
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    CGSize labLeftSubSize = [self sizeWithText:self.labelLeftSub.text font:self.labelLeftSub.font width:CGFLOAT_MAX];
    
    CGFloat YGap = kY_GAP;
    CGFloat padding = kPadding;
    
    CGFloat lableLeftH = kH_LABEL;
    
    CGSize imgViewRightSize = CGSizeMake(30, 30);
    CGRect imgViewRightRect = CGRectMake(CGRectGetWidth(self.contentView.frame) - imgViewRightSize.width -  YGap, (CGRectGetHeight(self.contentView.frame) - imgViewRightSize.height)/2.0, imgViewRightSize.width, imgViewRightSize.height);

    //控件1
    CGRect titleRect = CGRectMake(YGap, YGap, labLeftSize.width, lableLeftH);
    CGRect titleSubRect = CGRectMake(CGRectGetMaxX(titleRect) + padding*2, CGRectGetMinY(titleRect), labLeftSubSize.width, lableLeftH);

    self.radioView.frame = imgViewRightRect;

    self.labelLeft.frame = titleRect;
    self.labelLeftSub.frame = titleSubRect;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - layz


@end
