//
//  BN_CTReusableViewTwo.m
//  HuiZhuBang
//
//  Created by BIN on 2018/5/14.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_CTReusableViewTwo.h"
#import "BN_Globle.h"
#import "BN_Category.h"

@implementation BN_CTReusableViewTwo

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    /*
     文字
     文字(大号字)
     */
    [self addSubview:self.label];
    [self addSubview:self.labelSub];

    self.labelSub.font = [UIFont systemFontOfSize:36];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.label.frame = CGRectMake(0, kY_GAP, self.width, kH_LABEL);
    self.labelSub.frame = CGRectMake(0, CGRectGetMaxY(self.label.frame)+kPadding, self.width, self.height - CGRectGetHeight(self.label.frame) - kY_GAP - kPadding);

}


#pragma mark - -layz



@end
