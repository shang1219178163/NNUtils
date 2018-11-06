//
//  MapViewController.m
//  Utilis
//
//  Created by hsf on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "MapViewController.h"

#import "BN_Globle.h"
#import "BN_Category.h"

#import "BN_Map.h"
#import "MAPinAnnotationView+Helper.h"

@interface MapViewController ()<MAMapViewDelegate, AMapNaviDriveManagerDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapNaviPoint *startPoint;
@property (nonatomic, strong) AMapNaviPoint *endPoint;

@property (nonatomic, assign) BOOL isMultipleRoutePlan;

@end

@implementation MapViewController

-(MAMapView *)mapView{
    if (!_mapView) {
//        _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(20, 20, kScreen_width - 40, CGRectGetHeight(self.view.bounds) - 40)];
//        _mapView.delegate = self;

        _mapView = BN_Map.shared.mapView;
    }
    return _mapView;
    
}

-(void)dealloc{
    [AMapNaviDriveManager destroyInstance];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor ;
    self.view.backgroundColor = UIColor.greenColor ;
    
    self.title = self.controllerName;
    //为了方便展示驾车多路径规划，选择了固定的起终点
    self.startPoint = [AMapNaviPoint locationWithLatitude:39.993135 longitude:116.474175];
    self.endPoint   = [AMapNaviPoint locationWithLatitude:39.908791 longitude:116.321257];
    

    self.mapView.frame = self.view.bounds;
    [self.view addSubview:self.mapView];
    
    AMapNaviDriveManager.sharedInstance.delegate = self;

}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self initAnnotations];
    DDLog(@"%@",@(self.mapView.annotations.count));
    
    [self routePlanAction];
    
    
    NSString *a = NSStringFromClass(self.class);
    NSString *b = NSStringFromClass(self.class);
    DDLog(@"%p,%p",a,b);
    
    
}

- (void)initAnnotations{
    MAPointAnnotation *annoBegin = [[MAPointAnnotation alloc] init];
//    annoBegin.coordinate = CLLocationCoordinate2DMake(self.startPoint.latitude, self.startPoint.longitude);
    annoBegin.coordinate = CLCoordinateFromNaviPoint(self.startPoint);
    annoBegin.title = @"北京,东南方";
    annoBegin.subtitle = NSStringFromCoordinate(annoBegin.coordinate);
    annoBegin.type = kPointTypeStart;
    
    [self.mapView addAnnotation:annoBegin];
    
    MAPointAnnotation *annoEnd = [[MAPointAnnotation alloc] init];
//    annoEnd.coordinate = CLLocationCoordinate2DMake(self.endPoint.latitude, self.endPoint.longitude);
    annoEnd.coordinate = CLCoordinateFromNaviPoint(self.endPoint);
    annoEnd.title = @"北京,西南方";
    annoEnd.subtitle = NSStringFromCoordinate(annoEnd.coordinate);
    annoEnd.type = kPointTypeEnd;
    
    [self.mapView addAnnotation:annoEnd];
}


#pragma mark - Button Action

- (void)routePlanAction{
    //进行单路径规划
    self.isMultipleRoutePlan = NO;
    AMapNaviDrivingStrategy strategy = ConvertDrivingPreferenceToDrivingStrategy(self.isMultipleRoutePlan,
                                                                                 NO,
                                                                                 NO,
                                                                                 NO,
                                                                                 NO);
    
    [AMapNaviDriveManager.sharedInstance calculateDriveRouteWithStartPoints:@[self.startPoint]
                                                                  endPoints:@[self.endPoint]
                                                                  wayPoints:nil
                                                            drivingStrategy:strategy];
    
}

#pragma mark - Handle Navi Routes

- (void)showNaviRoutes{
    if ([AMapNaviDriveManager.sharedInstance.naviRoutes count] <= 0){
        return;
    }
    
    [self.mapView removeOverlays:self.mapView.overlays];
    
    //将路径显示到地图上
    for (NSNumber *aRouteID in AMapNaviDriveManager.sharedInstance.naviRoutes.allKeys){
        AMapNaviRoute *aRoute = [AMapNaviDriveManager.sharedInstance.naviRoutes objectForKey:aRouteID];
        int count = (int)[[aRoute routeCoordinates] count];
        
        //添加路径Polyline
        CLLocationCoordinate2D *coords = (CLLocationCoordinate2D *)malloc(count * sizeof(CLLocationCoordinate2D));
        for (int i = 0; i < count; i++){
            AMapNaviPoint *coordinate = [[aRoute routeCoordinates] objectAtIndex:i];
            coords[i].latitude = [coordinate latitude];
            coords[i].longitude = [coordinate longitude];
        }
        
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coords count:count];
        
        SelectableOverlay *selectablePolyline = [[SelectableOverlay alloc] initWithOverlay:polyline];
        [selectablePolyline setRouteID:[aRouteID integerValue]];
        
        [self.mapView addOverlay:selectablePolyline];
        free(coords);
        
    }
    
    [self.mapView showAnnotations:self.mapView.annotations animated:NO];
    
    [self selectNaviRouteWithID:[AMapNaviDriveManager.sharedInstance.naviRoutes.allKeys.firstObject integerValue]];
}

- (void)selectNaviRouteWithID:(NSInteger)routeID{
    //在开始导航前进行路径选择
    if ([AMapNaviDriveManager.sharedInstance selectNaviRouteWithRouteID:routeID]){
        [self selecteOverlayWithRouteID:routeID];
    }
    else{
        NSLog(@"路径选择失败!");
    }
}

- (void)selecteOverlayWithRouteID:(NSInteger)routeID{
    [self.mapView.overlays enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id<MAOverlay> overlay, NSUInteger idx, BOOL *stop)
     {
         if ([overlay isKindOfClass:[SelectableOverlay class]]){
             SelectableOverlay *selectableOverlay = overlay;
             
             /* 获取overlay对应的renderer. */
             MAPolylineRenderer * overlayRenderer = (MAPolylineRenderer *)[self.mapView rendererForOverlay:selectableOverlay];
             
             if (selectableOverlay.routeID == routeID){
                 /* 设置选中状态. */
                 selectableOverlay.selected = YES;
                 
                 /* 修改renderer选中颜色. */
                 overlayRenderer.fillColor   = selectableOverlay.selectedColor;
                 overlayRenderer.strokeColor = selectableOverlay.selectedColor;
                 
                 /* 修改overlay覆盖的顺序. */
                 [self.mapView exchangeOverlayAtIndex:idx withOverlayAtIndex:self.mapView.overlays.count - 1];
             }
             else{
                 /* 设置选中状态. */
                 selectableOverlay.selected = NO;
                 
                 /* 修改renderer选中颜色. */
                 overlayRenderer.fillColor   = selectableOverlay.regularColor;
                 overlayRenderer.strokeColor = selectableOverlay.regularColor;
             }
         }
     }];
}


#pragma mark - AMapNaviDriveManager Delegate

- (void)driveManager:(AMapNaviDriveManager *)driveManager error:(NSError *)error{
    NSLog(@"error:{%ld - %@}", (long)error.code, error.localizedDescription);
}

- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager{
    NSLog(@"onCalculateRouteSuccess");
    
    //算路成功后显示路径
    [self showNaviRoutes];
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager onCalculateRouteFailure:(NSError *)error{
    NSLog(@"onCalculateRouteFailure:{%ld - %@}", (long)error.code, error.localizedDescription);
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager didStartNavi:(AMapNaviMode)naviMode{
    NSLog(@"didStartNavi");
}

- (void)driveManagerNeedRecalculateRouteForYaw:(AMapNaviDriveManager *)driveManager{
    NSLog(@"needRecalculateRouteForYaw");
}

- (void)driveManagerNeedRecalculateRouteForTrafficJam:(AMapNaviDriveManager *)driveManager{
    NSLog(@"needRecalculateRouteForTrafficJam");
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager onArrivedWayPoint:(int)wayPointIndex{
    NSLog(@"onArrivedWayPoint:%d", wayPointIndex);
}

- (BOOL)driveManagerIsNaviSoundPlaying:(AMapNaviDriveManager *)driveManager{
    return NO;
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType{
    NSLog(@"playNaviSoundString:{%ld:%@}", (long)soundStringType, soundString);
}

- (void)driveManagerDidEndEmulatorNavi:(AMapNaviDriveManager *)driveManager{
    NSLog(@"didEndEmulatorNavi");
}

- (void)driveManagerOnArrivedDestination:(AMapNaviDriveManager *)driveManager{
    NSLog(@"onArrivedDestination");
}



#pragma mark - MAMapView Delegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]){
        static NSString *pinIdentifier = @"pinIdentifier";
        MAPinAnnotationView *pinView = [MAPinAnnotationView viewWithMapView:mapView annotation:annotation identifier:pinIdentifier];
        
        return pinView;
    }
    return nil;
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay{
    if ([overlay isKindOfClass:[SelectableOverlay class]]){
        SelectableOverlay * selectableOverlay = (SelectableOverlay *)overlay;
        id<MAOverlay> actualOverlay = selectableOverlay.overlay;
        
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:actualOverlay];
        
        polylineRenderer.lineWidth = 8.f;
        polylineRenderer.strokeColor = selectableOverlay.isSelected ? selectableOverlay.selectedColor : selectableOverlay.regularColor;
        
        return polylineRenderer;
    }
    
    return nil;
}

@end
