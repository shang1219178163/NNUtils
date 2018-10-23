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
//#import "BN_TableView.h"
//#import "BN_CollectionView.h"

#import "Manger.h"

@interface MainViewController ()


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor ;
    self.view.backgroundColor = UIColor.whiteColor ;

    self.title = self.controllerName;

    DDLog(@"_%p_%p_",Manger.shared,Manger.shared)
    [Manger destoryShared];
    DDLog(@"_%p_%p_",Manger.shared,Manger.shared)

}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    

    
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    WHKTableViewOneCell * cell = [WHKTableViewOneCell cellWithTableView:tableView];
//    UITableViewDatePickerCell * cell = [UITableViewDatePickerCell cellWithTableView:tableView];
//
//    return cell;
//
//}

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
