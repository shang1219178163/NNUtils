//
//  BN_GroupViewZero.h
//  BINAlertView
//
//  Created by BIN on 2018/3/23.
//  Copyright © 2018年 SouFun. All rights reserved.
//

/*
 子视图为button
 */

#import <UIKit/UIKit.h>

@class BN_GroupViewZero;

typedef void (^BN_GroupViewZeroBlock)(BN_GroupViewZero * groupView, id selectedItems, NSString *title, BOOL isOnlyOne);

@interface BN_GroupViewZero : UIView

@property (nonatomic, strong) NSArray * items;

@property (nonatomic, strong) NSArray * chooseList;

@property (nonatomic, strong) UIColor * colorBackNormal;
@property (nonatomic, strong) UIColor * colorBackSelected;

@property (nonatomic, assign) BOOL isOnlyOne;

@property (nonatomic, copy) BN_GroupViewZeroBlock viewBlock;

- (id)initWithRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding selectedList:(NSArray *)selectedList;

+ (BN_GroupViewZero *)viewWithRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding selectedList:(NSArray *)selectedList;

@end
