//
//  BN_CycleCollectionView.m
//  CollectionViewDemo1
//
//  Created by hsf on 2018/11/5.
//  Copyright © 2018年 com.elepphant.pingchuan. All rights reserved.
//

#import "BN_CycleCTView.h"

#import "BN_Globle.h"
#import "BN_Category.h"
#import "BN_CTViewCellSeven.h"

@implementation BN_CycleCTView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = UIColor.whiteColor;

        self.collectionView.pagingEnabled = YES;
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];

    }
    return self;
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    [self.collectionView reloadData];

}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.pageControl.numberOfPages = [self.collectionView numberOfItemsInSection:0];
    CGSize size = [self.pageControl sizeForNumberOfPages:self.pageControl.numberOfPages];
    
    CGRect rect = self.pageControl.frame;
    rect.size = size;
    rect.origin.x = CGRectGetMaxX(self.collectionView.frame) - CGRectGetWidth(rect) - kX_GAP;
    self.pageControl.frame = rect;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame) - 30, CGRectGetWidth(self.collectionView.frame), 30)];
        _pageControl.numberOfPages = [self.collectionView numberOfItemsInSection:0];
        _pageControl.currentPage = 0;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.defersCurrentPageDisplay = YES;
        _pageControl.pageIndicatorTintColor = UIColor.greenColor;
        _pageControl.currentPageIndicatorTintColor = UIColor.redColor;
        
    }
    return _pageControl;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = ({
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
            layout.itemSize = CGSizeMake(130, 130);
            layout.itemSize = CGSizeMake(CGRectGetWidth(self.bounds), 130);
            
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            layout.minimumLineSpacing = 0;
            layout.minimumInteritemSpacing = 0;
            
            UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
            collectionView.backgroundColor = [UIColor whiteColor];
            collectionView.delegate = self;
            collectionView.dataSource = self;
            collectionView.scrollsToTop = NO;
            collectionView.showsVerticalScrollIndicator = NO;
            collectionView.showsHorizontalScrollIndicator = NO;
            collectionView.dictClass = @{
                                         UICollectionElementKindSectionItem   :     @[
                                                 @"BN_CTViewCellSeven",
                                                 ],
                                         };
            collectionView;
        });
        
    }
    return _collectionView;
}


#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imgList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    id image = self.imgList[indexPath.row];

    BN_CTViewCellSeven * view = [BN_CTViewCellSeven viewWithCollectionView:collectionView indexPath:indexPath];
    [view.imgView loadImage:image defaultImg:@"img_failedDefault.png"];
    view.label.text = NSStringFromIndexPath(indexPath);
    
    return view;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    

}

#pragma mark - -scrollView

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%.2f,%.2f,%.2f",scrollView.contentOffset.x, CGRectGetWidth(scrollView.frame),scrollView.contentSize.width);
    
    //    UICollectionView * view = (UICollectionView *)scrollView;
    //    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)view.collectionViewLayout;
    //    NSInteger index = (scrollView.contentOffset.x + layout.itemSize.width*0.5)/layout.itemSize.width;
    
    self.pageControl.currentPage = (NSInteger)scrollView.contentOffset.x/CGRectGetWidth(scrollView.frame);
    
    CGFloat width = CGRectGetWidth(scrollView.frame);
    if (scrollView.contentOffset.x > (scrollView.contentSize.width - width)) {
        scrollView.contentOffset = CGPointMake(0, 0);
        
    }
    else if (scrollView.contentOffset.x < 0) {
        scrollView.contentOffset = CGPointMake(scrollView.contentSize.width - width,0);
        
    }
}


//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%.2f,%.2f,%.2f",scrollView.contentOffset.x, CGRectGetWidth(scrollView.frame),scrollView.contentSize.width);
//
//    CGFloat width = CGRectGetWidth(scrollView.frame);
//    if (scrollView.contentOffset.x > (scrollView.contentSize.width - width)) {
//        scrollView.contentOffset = CGPointMake(0, 0);
//    }
//    else if (scrollView.contentOffset.x < 0) {
//        scrollView.contentOffset = CGPointMake(scrollView.contentSize.width - width,0);
//
//    }
//}




@end

