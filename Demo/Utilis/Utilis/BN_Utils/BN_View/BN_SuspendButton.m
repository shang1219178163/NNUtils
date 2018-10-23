//
//  SuspendButton.m
//  suspendBtnDemo
//
//  Created by BIN on 2017/12/12.
//  Copyright © 2017年 郭永红. All rights reserved.
//

#import "BN_SuspendButton.h"

#import "BN_Globle.h"

static CGFloat kW_SuspendBtn = 50;

@interface BN_SuspendButton ()

@property (nonatomic, strong) UIViewController *parController;
@property (nonatomic, assign) CGSize viewSize;

@end

@implementation BN_SuspendButton

+(instancetype)spBtnRect:(CGRect)rect image:(id)image parController:(UIViewController *)parController{
    
    BN_SuspendButton * spBtn = [[self alloc]initWithFrame:rect];
//    spBtn.isLock = YES;
    spBtn.parController = parController;
    if ([image isKindOfClass:[NSString class]]) image = [UIImage imageNamed:image];
    if (CGRectEqualToRect(rect, CGRectZero)){
        spBtn.frame = CGRectMake(kScreen_width - kW_SuspendBtn, 200, kW_SuspendBtn, kW_SuspendBtn);

    }
    else{
        spBtn.frame = rect;
        
    }
    spBtn.viewSize = CGSizeMake(CGRectGetWidth(spBtn.frame), CGRectGetHeight(spBtn.frame));
    
    
//    [spBtn setImage:image forState:UIControlStateNormal];
    [spBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    // 按钮点击事件
    spBtn.backgroundColor = UIColor.clearColor;
    // 禁止高亮
    spBtn.adjustsImageWhenHighlighted = NO;
    // 置顶（只是显示置顶，但响应事件会被后来者覆盖！）
    spBtn.layer.zPosition = 1;
    [parController.view addSubview:spBtn];
    
    
    spBtn.imageView.contentMode = UIViewContentModeScaleToFill;
    
    //创建移动手势事件
    UIPanGestureRecognizer *panRcognize = [[UIPanGestureRecognizer alloc] initWithTarget:spBtn action:@selector(handleActionPan:)];
    [panRcognize setMinimumNumberOfTouches:1];
    [panRcognize setEnabled:YES];
    [panRcognize delaysTouchesEnded];
    [panRcognize cancelsTouchesInView];
    [spBtn addGestureRecognizer:panRcognize];
    
    return spBtn;
}

-(void)setPadding:(CGFloat)padding{
    _padding = padding;
    CGPoint stopPoint = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    if (stopPoint.x - _viewSize.width/2.0 <= 0) {
        stopPoint = CGPointMake(_viewSize.width/2.0 + _padding, stopPoint.y);
    }
    
    if (stopPoint.x + kW_SuspendBtn/2.0 >= kScreen_width) {
        stopPoint = CGPointMake(kScreen_width - _viewSize.width/2.0 - _padding, stopPoint.y);
    }
    
    if (stopPoint.y - _viewSize.height/2.0 <= 0) {
        if ([self.parController isKindOfClass:[UINavigationController class]]) {
            stopPoint = CGPointMake(stopPoint.x, 64 + _viewSize.height/2.0 + _padding);
        }else{
            stopPoint = CGPointMake(stopPoint.x, _viewSize.height/2.0 + _padding);
            
        }
    }
    
    if (stopPoint.y + _viewSize.height/2.0 >= kScreen_height) {
        stopPoint = CGPointMake(stopPoint.x, kScreen_height - _viewSize.height/2.0 - _padding);
    }
    self.center = stopPoint;
}

/*
 *  悬浮按钮移动事件处理
 */
- (void)handleActionPan:(UIPanGestureRecognizer *)recognizer
{
    if (_isLock == YES) {
        return;
    }
    //移动状态
    UIGestureRecognizerState recState =  recognizer.state;
    
    switch (recState) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [recognizer translationInView:[self superview]];
            recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGPoint stopPoint = CGPointMake(0, kScreen_height / 2.0);
            
            if (recognizer.view.center.x < kScreen_width / 2.0) {
                if (recognizer.view.center.y <= kScreen_height/2.0) {
                    //左上
                    if (recognizer.view.center.x >= recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, _viewSize.height/2.0);
                    }else{
                        stopPoint = CGPointMake(_viewSize.height/2.0, recognizer.view.center.y);
                    }
                }else{
                    //左下
                    if (recognizer.view.center.x >= kScreen_height - recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, kScreen_height - _viewSize.height/2.0);
                    }else{
                        stopPoint = CGPointMake(_viewSize.height/2.0, recognizer.view.center.y);
                    }
                }
            }else{
                if (recognizer.view.center.y <= kScreen_height/2.0) {
                    //右上
                    if (kScreen_width - recognizer.view.center.x  >= recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, _viewSize.height/2.0);
                    }else{
                        stopPoint = CGPointMake(kScreen_width - _viewSize.height/2.0, recognizer.view.center.y);
                    }
                }else{
                    //右下
                    if (kScreen_width - recognizer.view.center.x  >= kScreen_height - recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, kScreen_height - _viewSize.height/2.0);
                    }else{
                        stopPoint = CGPointMake(kScreen_width - _viewSize.height/2.0,recognizer.view.center.y);
                    }
                }
            }
            
            if (stopPoint.x - _viewSize.width/2.0 <= 0) {
                stopPoint = CGPointMake(_viewSize.width/2.0 + _padding, stopPoint.y);
            }
            
            if (stopPoint.x + kW_SuspendBtn/2.0 >= kScreen_width) {
                stopPoint = CGPointMake(kScreen_width - _viewSize.width/2.0 - _padding, stopPoint.y);
            }
            
            if (stopPoint.y - _viewSize.height/2.0 <= 0) {
                if ([self.parController isKindOfClass:[UINavigationController class]]) {
                    stopPoint = CGPointMake(stopPoint.x, 64 + _viewSize.height/2.0 + _padding);
                }else{
                    stopPoint = CGPointMake(stopPoint.x, _viewSize.height/2.0 + _padding);
                    
                }
            }
            
            if (stopPoint.y + _viewSize.height/2.0 >= kScreen_height) {
                stopPoint = CGPointMake(stopPoint.x, kScreen_height - _viewSize.height/2.0 - _padding);
            }
            
            [UIView animateWithDuration:0.35 animations:^{
                recognizer.view.center = stopPoint;
            }];
        }
            break;
        default:
            break;
    }
    [recognizer setTranslation:CGPointMake(0, 0) inView:[self superview]];
}

/*
- (void)handleActionPan:(UIPanGestureRecognizer *)recognizer
{
    if (_isLock == YES) {
        return;
    }
    //移动状态
    UIGestureRecognizerState recState =  recognizer.state;
    
    switch (recState) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [recognizer translationInView:[self superview]];
            recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGPoint stopPoint = CGPointMake(0, kScreen_height / 2.0);
            
            if (recognizer.view.center.x < kScreen_width / 2.0) {
                if (recognizer.view.center.y <= kScreen_height/2.0) {
                    //左上
                    if (recognizer.view.center.x >= recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, kW_SuspendBtn/2.0);
                    }else{
                        stopPoint = CGPointMake(kW_SuspendBtn/2.0, recognizer.view.center.y);
                    }
                }else{
                    //左下
                    if (recognizer.view.center.x >= kScreen_height - recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, kScreen_height - kW_SuspendBtn/2.0);
                    }else{
                        stopPoint = CGPointMake(kW_SuspendBtn/2.0, recognizer.view.center.y);
                    }
                }
            }else{
                if (recognizer.view.center.y <= kScreen_height/2.0) {
                    //右上
                    if (kScreen_width - recognizer.view.center.x  >= recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, kW_SuspendBtn/2.0);
                    }else{
                        stopPoint = CGPointMake(kScreen_width - kW_SuspendBtn/2.0, recognizer.view.center.y);
                    }
                }else{
                    //右下
                    if (kScreen_width - recognizer.view.center.x  >= kScreen_height - recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, kScreen_height - kW_SuspendBtn/2.0);
                    }else{
                        stopPoint = CGPointMake(kScreen_width - kW_SuspendBtn/2.0,recognizer.view.center.y);
                    }
                }
            }
            
            if (stopPoint.x - kW_SuspendBtn/2.0 <= 0) {
                stopPoint = CGPointMake(kW_SuspendBtn/2.0 + _padding, stopPoint.y);
            }
            
            if (stopPoint.x + kW_SuspendBtn/2.0 >= kScreen_width) {
                stopPoint = CGPointMake(kScreen_width - kW_SuspendBtn/2.0 - _padding, stopPoint.y);
            }
            
            if (stopPoint.y - kW_SuspendBtn/2.0 <= 0) {
                if ([self.parController isKindOfClass:[UINavigationController class]]) {
                    stopPoint = CGPointMake(stopPoint.x, 64 + kW_SuspendBtn/2.0 + _padding);
                }else{
                    stopPoint = CGPointMake(stopPoint.x, kW_SuspendBtn/2.0 + _padding);

                }
            }
            
            if (stopPoint.y + kW_SuspendBtn/2.0 >= kScreen_height) {
                stopPoint = CGPointMake(stopPoint.x, kScreen_height - kW_SuspendBtn/2.0 - _padding);
            }
            
            [UIView animateWithDuration:0.35 animations:^{
                recognizer.view.center = stopPoint;
            }];
        }
            break;
        default:
            break;
    }
    [recognizer setTranslation:CGPointMake(0, 0) inView:[self superview]];
}
*/


@end
