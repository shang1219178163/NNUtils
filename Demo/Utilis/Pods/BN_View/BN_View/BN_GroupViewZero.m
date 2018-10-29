//
//  BN_GroupViewZero.m
//  BINAlertView
//
//  Created by BIN on 2018/3/23.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "BN_GroupViewZero.h"

#import "BN_Globle.h"
#import "BN_Category.h"

@interface BN_GroupViewZero ()

@property (nonatomic, strong ,readwrite) NSMutableArray * selectedList;

@end

@implementation BN_GroupViewZero

-(NSMutableArray *)selectedList{
    if (!_selectedList) {
        _selectedList = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _selectedList;
    
}

+ (BN_GroupViewZero *)viewWithRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding selectedList:(NSArray *)selectedList{
    
    BN_GroupViewZero *view = [[BN_GroupViewZero alloc]initWithRect:rect items:items numberOfRow:numberOfRow itemHeight:itemHeight padding:padding selectedList:selectedList];
    return view;
}


- (id)initWithRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding selectedList:(NSArray *)selectedList{
    self = [super init];
    if (self) {
        self.items = items;
        
        [self.selectedList removeAllObjects];
        [self.selectedList addObjectsFromArray:selectedList];
        
        //    CGFloat padding = 15;
        //    CGFloat viewHeight = 30;
        //    NSInteger numberOfRow = 4;
        NSInteger rowCount = items.count % numberOfRow == 0 ? items.count/numberOfRow : items.count/numberOfRow + 1;
        //
        self.frame = CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), rowCount * itemHeight + (rowCount - 1) * padding);
        self.backgroundColor = UIColor.greenColor;
        
        CGSize viewSize = CGSizeMake((CGRectGetWidth(self.frame) - (numberOfRow-1)*padding)/numberOfRow, itemHeight);
        for (NSInteger i = 0; i< items.count; i++) {
            
            CGFloat w = viewSize.width;
            CGFloat h = viewSize.height;
            CGFloat x = w * ( i % numberOfRow) + padding * ( i % numberOfRow);
            CGFloat y =  (i / numberOfRow) * (h + padding);
            
            NSString * title = items[i];
            CGRect btnRect = CGRectMake(x, y, w, h);
            NSNumber * type = [selectedList containsObject:title] ? @"8": @"0";
            UIButton * btn = [UIView createBtnWithRect:btnRect title:title font:15 image:nil tag:kTAG_BTN+i type:type target:self aSelector:@selector(handleActionBtn:)];
            
            if ([self.selectedList containsObject:title]) {
                [self handleSender:btn backgroudColor:UIColor.themeColor textColor:UIColor.whiteColor layerColor:UIColor.themeColor];
                
            }
            else{
                [self handleSender:btn backgroudColor:UIColor.whiteColor textColor:kC_TextColor layerColor:UIColor.lineColor];
                
            }
            [self addSubview:btn];
            
        }
    }
    return self;
}


-(void)setIsOnlyOne:(BOOL)isOnlyOne{
    _isOnlyOne = isOnlyOne;
    if (isOnlyOne == YES && self.selectedList.count > 1) {
//        NSAssert(isOnlyOne == YES && self.selectedList.count == 1, @"isOnlyOne = yes代表单选");
        
        self.selectedList = [NSMutableArray arrayWithObject: [self.selectedList lastObject]];
        for (UIButton *sender in self.subviews) {
            NSString * title = sender.titleLabel.text;
            if ([self.selectedList containsObject:title]) {
                [self handleSender:sender backgroudColor:UIColor.themeColor textColor:UIColor.whiteColor layerColor:UIColor.themeColor];
                
            }else{
                [self handleSender:sender backgroudColor:UIColor.whiteColor textColor:kC_TextColor_Title layerColor:UIColor.lineColor];
                
            }
        }
    }
}

- (void)handleActionBtn:(UIButton *)sender{
    
//    DDLog(@"isOnlyOne__%@",@(self.isOnlyOne));
    
    NSString * title = sender.titleLabel.text;
    if (self.isOnlyOne == NO) {
        if (![self.selectedList containsObject:title]) {
            [self.selectedList addObject:title];
            [self handleSender:sender backgroudColor:UIColor.themeColor textColor:UIColor.whiteColor layerColor:UIColor.themeColor];
            
        }else{
            [self.selectedList removeObject:title];
            [self handleSender:sender backgroudColor:UIColor.whiteColor textColor:kC_TextColor_Title layerColor:UIColor.lineColor];
            
        }
    }
    else{
        
        if ([self.selectedList containsObject:title]) {
        
        }
        else{
            [self.selectedList removeAllObjects];
            for (UIButton *btn in self.subviews) {

                if ([btn isEqual:sender]) {
                    [self.selectedList addObject:title];
                    [self handleSender:btn backgroudColor:UIColor.themeColor textColor:UIColor.whiteColor layerColor:UIColor.themeColor];

                }else{
                    [self handleSender:btn backgroudColor:UIColor.whiteColor textColor:kC_TextColor_Title layerColor:UIColor.lineColor];

                }
            }
        }
    }
    
    if (self.viewBlock) {
        self.viewBlock(self, self.selectedList, title, self.isOnlyOne);

    }
}


-(void)setColorBackNormal:(UIColor *)colorBackNormal{
    
    for (UIButton *sender in self.subviews) {
        if ([self.selectedList containsObject:sender.titleLabel.text]) {
            [self handleSender:sender backgroudColor:UIColor.themeColor textColor:UIColor.whiteColor layerColor:UIColor.themeColor];
            
        }else{
            [self handleSender:sender backgroudColor:colorBackNormal textColor:kC_TextColor_Title layerColor:UIColor.lineColor];
            
        }
    }
}

-(void)setColorBackSelected:(UIColor *)colorBackSelected{
    for (UIButton *sender in self.subviews) {
        if ([self.selectedList containsObject:sender.titleLabel.text]) {
            [self handleSender:sender backgroudColor:colorBackSelected textColor:UIColor.whiteColor layerColor:UIColor.themeColor];
            
        }else{
            [self handleSender:sender backgroudColor:UIColor.whiteColor textColor:kC_TextColor_Title layerColor:UIColor.lineColor];
            
        }
    }
}

- (void)handleSender:(UIButton *)sender backgroudColor:(UIColor *)backgroudColor textColor:(UIColor *)textColor layerColor:(UIColor *)layerColor{
    
    [sender setBackgroundImage:UIImageFromColor(backgroudColor) forState:UIControlStateNormal];
    [sender setTitleColor:textColor forState:UIControlStateNormal];
    
    [sender showLayerColor:layerColor];
    
}


//- (void)handleBackgroudColor:(UIColor *)backgroudColor textColor:(UIColor *)textColor layerColor:(UIColor *)layerColor{
//
//    [sender setBackgroundImage:UIImageFromColor(UIColor.themeColor] forState:UIControlStateNormal];
//    [sender setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//
//    [sender showLayerColor:UIColor.themeColor];
//
//}

-(void)setChooseList:(NSArray *)chooseList{
    [self.selectedList removeAllObjects];
    for (UIButton *btn in self.subviews) {
        NSString * title = btn.titleLabel.text;
        if ([chooseList containsObject:title]) {
            [self.selectedList addObject:title];
            [self handleSender:btn backgroudColor:UIColor.themeColor textColor:UIColor.whiteColor layerColor:UIColor.themeColor];
            
        }else{
            [self handleSender:btn backgroudColor:UIColor.whiteColor textColor:kC_TextColor_Title layerColor:UIColor.lineColor];
            
        }
    }
}

-(NSArray *)chooseList{
    return self.selectedList;
    
}

@end
