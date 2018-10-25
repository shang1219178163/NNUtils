//
//  ListViewController.m
//  Utilis
//
//  Created by hsf on 2018/10/25.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "ListViewController.h"

#import "BN_Category.h"
#import "BN_TableView.h"

#import <UIImageView+WebCache.h>
#import <YYWebImage.h>

@interface ListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) NSArray *imgList;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imgList = @[@"https://www.huizhubang.com/attachment/rotation/9.jpg",
                   @"https://www.huizhubang.com/attachment/rotation/8.jpg",
                    @"https://www.huizhubang.com/attachment/rotation/7.jpg",];
    
    for (NSInteger i = 0; i < 5000; i++) {
        [self.dataList addObject:@"1"];
        
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WHKTableViewZeroCell *cell = [WHKTableViewZeroCell cellWithTableView:tableView];
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
                               NSLog(@"load from disk cache");
                           }
                       }];
    return cell;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    WHKTableViewZeroCell *cell = [WHKTableViewZeroCell cellWithTableView:tableView];
//    cell.textLabel.text = NSStringFromIndexPath(indexPath);
//    NSInteger idx = arc4random() % self.imgList.count;
//    NSURL *url = [NSURL URLWithString:self.imgList[idx]];

//    [cell.imageView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//
//        cell.imageView.image = image;
//    }];
//    return cell;
//}


@end
