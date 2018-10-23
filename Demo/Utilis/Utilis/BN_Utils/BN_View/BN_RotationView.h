//
//  BN_RotationView.h
//  BN_Animation
//
//  Created by BIN on 2018/9/21.
//  Copyright © 2018年 whkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BN_RotationView : UIView

@property (nonatomic, strong, readonly) UIImageView * imgView;

@property (nonatomic, strong, readonly) CAShapeLayer *layerFront;
@property (nonatomic, strong, readonly) CAShapeLayer *layerBack;

@property (nonatomic, strong, readonly) CABasicAnimation * animation;

@property (nonatomic, assign) BOOL isColorFollow;

@end
