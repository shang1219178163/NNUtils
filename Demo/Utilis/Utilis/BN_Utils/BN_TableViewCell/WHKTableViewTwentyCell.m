//
//  WHKTableViewTwentyCell.m
//  HuiZhuBang
//
//  Created by BIN on 2017/9/25.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewTwentyCell.h"
#import "BN_Globle.h"

@interface WHKTableViewTwentyCell ()


@end

@implementation WHKTableViewTwentyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    /*
     图片+文字
     图片+文字
     图片+文字
    */
//    self.labViewOne = [[BN_ImgLabelView alloc]init];
//    self.labViewTwo = [[BN_ImgLabelView alloc]init];
//    self.labViewThree = [[BN_ImgLabelView alloc]init];
//
//    [self.contentView addSubview:self.labViewOne];
//    [self.contentView addSubview:self.labViewTwo];
//    [self.contentView addSubview:self.labViewThree];
//
//    [self.contentView addSubview:self.imgViewRight];
    
 
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    /*图片+文字
     图片+文字          箭头
     图片+文字
     */
    
//    CGFloat XYGap = kY_GAP;
//    //控件>
//    CGSize imgViewRightSize = CGSizeMake(25, 25);
//    CGRect imgViewRightRect = CGRectMake(CGRectGetWidth(self.contentView.frame) - imgViewRightSize.width -  XYGap, (CGRectGetHeight(self.contentView.frame) - imgViewRightSize.height)/2.0, imgViewRightSize.width, imgViewRightSize.height);
//    self.imgViewRight.frame = imgViewRightRect;
//
//
//    CGRect labViewRectOne = CGRectMake(XYGap, XYGap, CGRectGetMinX(imgViewRightRect) - XYGap, 20);
//    CGRect labViewRectTwo = CGRectMake(XYGap, CGRectGetMaxY(labViewRectOne), CGRectGetWidth(labViewRectOne), CGRectGetHeight(labViewRectOne));
//    CGRect labViewRectThree = CGRectMake(XYGap, CGRectGetMaxY(labViewRectTwo), CGRectGetWidth(labViewRectOne), CGRectGetHeight(labViewRectOne));
//
//    self.labViewOne.frame = labViewRectOne;
//    self.labViewTwo.frame = labViewRectTwo;
//    self.labViewThree.frame = labViewRectThree;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
