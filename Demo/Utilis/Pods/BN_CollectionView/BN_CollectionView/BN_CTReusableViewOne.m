
//
//  WHKCTReusableViewOne.m
//  HuiZhuBang
//
//  Created by BIN on 2018/4/13.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_CTReusableViewOne.h"
#import "BN_Globle.h"
#import "BN_Category.h"

@implementation BN_CTReusableViewOne

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    [self addSubview:self.imgView];
    [self addSubview:self.label];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imgView.frame = CGRectMake(kPadding, 0, 2, CGRectGetHeight(self.frame));
    self.label.frame = CGRectMake(kX_GAP, 0, CGRectGetWidth(self.frame) - kX_GAP*2, CGRectGetHeight(self.frame));
}


#pragma mark - -layz


@end
