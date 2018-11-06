//
//  MyCollectionViewCell.m
//  CollectionViewDemo1
//
//  Created by IOS.Mac on 16/10/27.
//  Copyright © 2016年 com.elepphant.pingchuan. All rights reserved.
//

#import "BN_CTViewCellSeven.h"

#import "BN_Globle.h"

@implementation BN_CTViewCellSeven

- (void)prepareForReuse {
    [super prepareForReuse];
    self.imgView.image = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls {
    self.contentView.backgroundColor = UIColor.whiteColor;
    
    self.imgView.userInteractionEnabled = YES;
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    self.label.adjustsFontSizeToFitWidth = YES;
    self.label.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];

    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.label];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imgView.frame = self.contentView.bounds;
    self.label.frame = CGRectMake(0, self.height - kH_LABEL, self.width, kH_LABEL);
    
}

//-(UIImageView *)imageView{
//    if (!_imageView) {
//        _imageView = ({
//            UIImageView * imgView = [[UIImageView alloc]init];
//            imgView.userInteractionEnabled = YES;
//            imgView.contentMode = UIViewContentModeScaleAspectFit;
//            imgView.contentMode = UIViewContentModeScaleAspectFill;
//
//          imgView.backgroundColor = UIColor.randomColor;
//
//            imgView;
//        });
//    }
//    return _imageView;
//}
//
//-(UILabel *)label{
//    if (!_label) {
//        _label = ({
//            UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
//            label.textAlignment = NSTextAlignmentCenter;
//            label.textColor = UIColor.redColor;
//            label.backgroundColor = UIColor.yellowColor;
//
//            label;
//        });
//    }
//    return _label;
//}


@end
