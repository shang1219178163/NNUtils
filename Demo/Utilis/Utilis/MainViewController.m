//
//  MainViewController.m
//  Utilis
//
//  Created by hsf on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "MainViewController.h"

#import "BN_Globle.h"
#import "BN_Category.h"

//#import "BN_Utils.h"
//#import "BN_View.h"
#import "BN_TableViewCell.h"
//#import "BN_CollectionView.h"

#import "Manger.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) NSDictionary * dic;

@end

@implementation MainViewController

-(NSDictionary *)dic{
    if (!_dic) {
        _dic = @{
                 @1 :   @"分类一",
                 @2 :   @"分类二",
                 @3 :   @"分类三",

                 };
    }
    return _dic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor ;

    self.title = self.controllerName;

    [self createBarItemTitle:@"Left" imageName:nil isLeft:YES isHidden:NO handler:^(id obj,  UIButton * item, NSInteger idx) {
        DDLog(@"%@",item.titleLabel.text);
    }];
    
    [self createBarItemTitle:@"Right" imageName:nil isLeft:NO isHidden:NO handler:^(id obj,  UIButton * item, NSInteger idx) {
        [self goController:@"ListViewController" title:@"List" obj:nil];
        
        //动画
//        [self pushController:@"ListViewController" item:item type:@0];
//        [self presentController:@"ListViewController" item:item type:@0 completion:nil];
    }];
    
    
//    DDLog(@"_%p_%p_",Manger.shared,Manger.shared)
//    [Manger destoryShared];
//    DDLog(@"_%p_%p_",Manger.shared,Manger.shared)

    self.dataList = @[
                      @"UITableViewDatePickerCell",
                      @"UITableViewDateRangeCell",
                      @"UITableViewSegmentCell",
                      @"UITableViewStepCell",
                      @"UITableViewPickerListCell",
                      @"UITableViewAddressPickerCell",
                      @"UITableViewTextFieldCell",
                      @"UITableViewTextViewCell",

                      ].mutableCopy;
 
    [self.view addSubview:self.tableView];
    [self.view getViewLayer];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.dataList.count - 1) {
        return 180;
    }
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

//    UITableViewDatePickerCell * cell = [UITableViewDatePickerCell cellWithTableView:tableView];

    switch (indexPath.row) {
        case 0:
        {
            UITableViewDatePickerCell * cell = [UITableViewDatePickerCell cellWithTableView:tableView];
            cell.labelLeft.text = @"日期选择:";
            return cell;

        }
            break;
        case 1:
        {
            UITableViewDateRangeCell * cell = [UITableViewDateRangeCell cellWithTableView:tableView];
            cell.labelLeft.text = @"日期选择:";

            return cell;
        }
            break;
        case 2:
        {
            UITableViewSegmentCell * cell = [UITableViewSegmentCell cellWithTableView:tableView];
            cell.labelLeft.text = @"商品数量:";

            return cell;
        }
            break;
        case 3:
        {
            UITableViewStepCell * cell = [UITableViewStepCell cellWithTableView:tableView];
            cell.labelLeft.text = @"商品名称:";

            return cell;
        }
            break;
        case 4:
        {
            
            UITableViewPickerListCell * cell = [UITableViewPickerListCell cellWithTableView:tableView];
            cell.labelLeft.text = @"商品分类:";
            cell.dic = self.dic;
            
            return cell;
        }
            break;
        case 5:
        {
            
            UITableViewAddressPickerCell * cell = [UITableViewAddressPickerCell cellWithTableView:tableView];
            cell.labelLeft.text = @"商家地址:";
          

            return cell;
        }
            break;
        case 6:
        {
            UITableViewTextFieldCell * cell = [UITableViewTextFieldCell cellWithTableView:tableView];
            cell.labelLeft.text = @"输入姓名:";
            
            return cell;
        }
            break;
            
        case 7:
        {
            UITableViewTextViewCell * cell = [UITableViewTextViewCell cellWithTableView:tableView];
            cell.labelLeft.text = @"备注信息:";

            return cell;
        }
            break;
        case 8:
        {
            WHKTableViewZeroCell * cell = [WHKTableViewZeroCell cellWithTableView:tableView];

            CGRect rect = CGRectMake(10, 10, kScreen_width - 20, 30);
            UITextField * textField = [UIView createTextFieldWithRect:rect text:@"测试" placeholder:nil font:16 textAlignment:NSTextAlignmentLeft keyboardType:UIKeyboardTypeDefault];
            
            [cell.contentView addSubview:textField];
            
            [cell.contentView getViewLayer];
            
            return cell;
        }
            break;
        default:
            DDLog(@"%@",NSStringFromIndexPath(indexPath));
            break;
    }
    return nil;

}

//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    BN_CTViewCellOne * cell = [BN_CTViewCellOne viewWithCollectionView:collectionView indexPath:indexPath];
//
//
//    return cell;
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
