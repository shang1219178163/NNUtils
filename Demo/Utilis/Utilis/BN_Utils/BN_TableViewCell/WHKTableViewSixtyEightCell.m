//
//  WHKTableViewSixtyEightCell.m
//  HuiZhuBang
//
//  Created by BIN on 2018/4/10.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewSixtyEightCell.h"
#import "BN_Globle.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"

@interface WHKTableViewSixtyEightCell ()

@end

@implementation WHKTableViewSixtyEightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字+文字+文字+文字+文字
    [self.contentView addSubview:self.labelOne];
    [self.contentView addSubview:self.labelTwo];
    [self.contentView addSubview:self.labelThree];
    [self.contentView addSubview:self.labelFour];
    [self.contentView addSubview:self.labelFive];
     
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //    CGSize labOneSize = [self sizeWithText:self.labelOne.text font:self.labelOne.font width:CGFLOAT_MAX];
    
    //文字+文字
    CGFloat YGap = (CGRectGetHeight(self.contentView.frame) - kH_LABEL_SMALL*2)/2.0;
    CGFloat padding = kPadding;
    NSInteger itemCount = 5;
    CGFloat width = (kScreen_width - (itemCount-1)*padding - kX_GAP*2)/itemCount;
    width = floorf(width);
    
    self.labelOne.frame     = CGRectMake(kX_GAP, YGap, width, kH_LABEL_SMALL*2);
    self.labelTwo.frame     = CGRectMake(CGRectGetMaxX(self.labelOne.frame)+padding, YGap, width, kH_LABEL_SMALL*2);
    self.labelThree.frame   = CGRectMake(CGRectGetMaxX(self.labelTwo.frame)+padding, YGap, width, kH_LABEL_SMALL*2);
    self.labelFour.frame    = CGRectMake(CGRectGetMaxX(self.labelThree.frame)+padding, YGap, width, kH_LABEL_SMALL*2);
    self.labelFive.frame    = CGRectMake(CGRectGetMaxX(self.labelFour.frame)+padding, YGap, width, kH_LABEL_SMALL*2);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(UILabel *)labelOne{
    if (!_labelOne) {
        _labelOne = [UIView createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL type:@0 font:kFZ_Third backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentCenter];
    }
    return _labelOne;
}

-(UILabel *)labelTwo{
    if (!_labelTwo) {
        _labelTwo = [UIView createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+1 type:@0 font:kFZ_Third backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentCenter];
    }
    return _labelTwo;
}

-(UILabel *)labelThree{
    if (!_labelThree) {
        _labelThree = [UIView createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+2 type:@0 font:kFZ_Third backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentCenter];
    }
    return _labelThree;
}
-(UILabel *)labelFour{
    if (!_labelFour) {
        _labelFour = [UIView createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+3 type:@0 font:kFZ_Third backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentCenter];
    }
    return _labelFour;
}
-(UILabel *)labelFive{
    if (!_labelFive) {
        _labelFive = [UIView createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+4 type:@0 font:kFZ_Third backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentCenter];
    }
    return _labelFive;
}

@end
