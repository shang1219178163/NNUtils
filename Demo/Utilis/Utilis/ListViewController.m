//
//  ListViewController.m
//  Utilis
//
//  Created by hsf on 2018/10/25.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "ListViewController.h"

#import "BN_Category.h"
#import "BN_TableViewCell.h"

#import <UIImageView+WebCache.h>
#import <YYWebImage.h>


@interface ListViewController ()

@property(nonatomic, strong) NSArray *imgList;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"list";
    
    self.imgList = @[@"https://www.huizhubang.com/attachment/rotation/9.jpg",
                   @"https://www.huizhubang.com/attachment/rotation/8.jpg",
                    @"https://www.huizhubang.com/attachment/rotation/7.jpg",];
    
    for (NSInteger i = 0; i < 20; i++) {
        [self.dataList addObject:@"1"];
        
    }
    [self.view addSubview:self.tableView];
    
    @weakify(self);
    self.block = ^(UIViewController * _Nonnull controller, NSString * _Nonnull title) {
        @strongify(self);
        self.tableView.backgroundColor = UIColor.randomColor;
        
    };
    
}

- (void)handlActionBack{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.hidesBarsOnSwipe = YES;
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 60;
//
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewZeroCell *cell = [UITableViewZeroCell cellWithTableView:tableView];
    cell.textLabel.text = NSStringFromIndexPath(indexPath);
    NSInteger idx = arc4random() % self.imgList.count;
    NSURL *url = [NSURL URLWithString:self.imgList[idx]];
    
    [cell.imageView yy_setImageWithURL:url
                      placeholder:nil
                          options:YYWebImageOptionSetImageWithFadeAnimation
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                             progress = (float)receivedSize / expectedSize;
                         }
                        transform:^UIImage *(UIImage *image, NSURL *url) {
                            image = [image yy_imageByResizeToSize:CGSizeMake(100, 100) contentMode:UIViewContentModeCenter];
                            return [image yy_imageByRoundCornerRadius:50];
                            
                        }
                       completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
                           if (from == YYWebImageFromDiskCache) {
//                               NSLog(@"load from disk cache");
                           }
                       }];
    return cell;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewZeroCell *cell = [UITableViewZeroCell cellWithTableView:tableView];
//    cell.textLabel.text = NSStringFromIndexPath(indexPath);
//    NSInteger idx = arc4random() % self.imgList.count;
//    NSURL *url = [NSURL URLWithString:self.imgList[idx]];

//    [cell.imageView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//
//        cell.imageView.image = image;
//    }];
//    return cell;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.block) {
        self.block(self, NSStringFromIndexPath(indexPath));
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UILabel * label = [[UILabel alloc]initWithFrame:CGRectZero];
//    label.text = @"     左滑删除";
    label.textColor = [UIColor redColor];
    return label;

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;

}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

@end
