//
//  BN_ShareView.h
//  BINAlertView
//
//  Created by hsf on 2018/5/18.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BN_ShareView : UIView

@property (nonatomic, copy) void(^block)(BN_ShareView * view, NSIndexPath * indexPath);

- (void)show;

@end
