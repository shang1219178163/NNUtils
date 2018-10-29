//
//  BN_Map.m
//  Utilis
//
//  Created by hsf on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BN_Map.h"


CLLocationCoordinate2D CLCoordinateFromString(NSString *coordinateStr) {
    if (![coordinateStr containsString:@","]) {
        return CLLocationCoordinate2DMake(0.0, 0.0);
    }
    coordinateStr = [coordinateStr stringByReplacingOccurrencesOfString:@"" withString:@" "];
    coordinateStr = [coordinateStr stringByReplacingOccurrencesOfString:@"" withString:@"{"];
    coordinateStr = [coordinateStr stringByReplacingOccurrencesOfString:@"" withString:@"}"];
    
    NSArray * array = [coordinateStr componentsSeparatedByString:@","];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([array.firstObject doubleValue], [array.lastObject doubleValue]);
    return coordinate;
}

CLLocationCoordinate2D CLCoordinateFromNaviPoint(AMapNaviPoint *point) {
    return CLLocationCoordinate2DMake(point.latitude, point.longitude);
}

CLLocationCoordinate2D CLCoordinateFromGeoPoint(AMapGeoPoint *point) {
    return CLLocationCoordinate2DMake(point.latitude, point.longitude);
}

NSString *NSStringFromCoordinate(CLLocationCoordinate2D coordinate) {
    return [NSString stringWithFormat:@"{%.8f,%.8f}",coordinate.latitude,coordinate.longitude];
}

NSString *NSStringFromPlacemark(CLPlacemark *placemark) {
    return [NSString stringWithFormat:@"{%@,%@,%@}",placemark.name,placemark.subLocality,placemark.administrativeArea];
}

NSString *NSStringFromPoint(AMapGeoPoint *point) {
    return [NSString stringWithFormat:@"%.8f,%.8f",point.latitude,point.longitude];
}

NSString *NSStringFromNaviPoint(AMapNaviPoint *point) {
    return [NSString stringWithFormat:@"%.8f,%.8f",point.latitude,point.longitude];
}


AMapNaviPoint *MapNaviPointFromCoordinate(CLLocationCoordinate2D coordinate) {
    return [AMapNaviPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
}

AMapGeoPoint *MapGeoPointFromCoordinate(CLLocationCoordinate2D coordinate) {
    return [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
}

@interface BN_Map ()

@property (nonatomic, strong) NSUserDefaults *userDefaults;

@property (nonatomic, assign) BOOL isSearch;

@property (nonatomic, strong) NSString *currentLatitude ;
@property (nonatomic, strong) NSString *currentLongitude ;

@property (nonatomic, strong) AMapGeocodeSearchRequest *GeocodeRequest;

@property (nonatomic, strong) AMapPOIAroundSearchRequest *POIAroundRequest;
@property (nonatomic, strong) AMapPOIKeywordsSearchRequest *POIKeywordsRequest;
@property (nonatomic, strong) AMapInputTipsSearchRequest *InputTipsRequest;

@property (nonatomic, strong) AMapDrivingRouteSearchRequest *DrivingRequest;

@property (nonatomic, strong) MapLocationInfoModel * locationModel;
@property (nonatomic, strong) AMapNaviRoute * naviRoute;

@end

@implementation BN_Map
static BN_Map * _singleton = nil;

#pragma mark - - shared
+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[BN_Map alloc] init];
        
    });
    return _singleton;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [super allocWithZone:zone];
    });
    return _singleton;
}


-(NSString *)currentLatitude{
    return [NSUserDefaults.standardUserDefaults valueForKey:kUserLatitude];
}

-(NSString *)currentLongitude{
    return [NSUserDefaults.standardUserDefaults valueForKey:kUserLongitude];
    
}

-(MapLocationInfoModel *)locationModel{
    if (!_locationModel) {
        _locationModel = [[MapLocationInfoModel alloc]init];
        
    }
    return _locationModel;
}

/**
 4种大头针样式,当前位置,普通大头针,起点,终点
 */
-(NSDictionary *)annoDict{
    if (!_annoDict) {
        _annoDict = @{
                         kPointTypeUser    :   @"map_userLocation@2x.png",
                         kPointTypeDefault :   @"map_point_Default@2x.png",
                         kPointTypeStart   :   @"map_point_start@2x.png",
                         kPointTypeEnd     :   @"map_point_end@2x.png",
                         };
    }
    return _annoDict;
}

// 开始定位
- (void)startSerialLocationWithReGeocode:(BOOL)reGeocode {
    if (![self hasAccessRightOfLocation]) {
        return ;
    }
    //持续定位是否返回逆地理信息，默认NO。
    self.locationManager.locatingWithReGeocode = reGeocode;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    //开始持续定位
    [self.locationManager startUpdatingLocation];
}

// 停止定位
- (void)stopSerialLocation {
    [self.locationManager stopUpdatingLocation];
    
}

// 开始单次定位
- (void)startSingleLocationWithReGeocode:(BOOL)reGeocode handler:(MapLocationHandler)handler {
    self.locationHandler = handler;
    
    if (![self hasAccessRightOfLocation]) {
        return ;
    }
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    self.locationManager.locationTimeout = 2;
    self.locationManager.reGeocodeTimeout = 2;
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    @weakify(self)
    [self.locationManager requestLocationWithReGeocode:reGeocode completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        @strongify(self);
        if (self.locationHandler) self.locationHandler(location, regeocode, nil, error);
        
        if (error){
            DDLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            if (error.code == AMapLocationErrorLocateFailed){
                return;
            }
        }
        
        if (regeocode){
            DDLog(@"reGeocode:%@", regeocode);
        }
    }];
}

- (void)startSerialLocationHandler:(MapLocationHandler)handler {
    self.locationHandler = handler;
    
}

- (void)didUpdateUserLocationLocationHandler:(MapLocationHandler)handler{
    self.locationHandler = handler;
    
}

#pragma mark - AMapLocationManager
// 定位错误
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error {
    if (error) {
        DDLog(@"error:%@",error)
        if (self.locationHandler) self.locationHandler(nil, nil, manager, error);
        
    }
}

// 定位结果
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)newLocation reGeocode:(AMapLocationReGeocode *)reGeocode{
    if (self.locationHandler) self.locationHandler(newLocation, reGeocode, manager, nil);
        
        }

#pragma mark - MapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    
    DDLog(@"didUpdateUserLocation\n___%@->%@",NSStringFromCoordinate(userLocation.coordinate),userLocation.title);
    if (self.didUpdateUserHandler) self.didUpdateUserHandler(mapView, userLocation, updatingLocation, nil);
        
    
}

- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    if (error) {
        DDLog(@"error:%@",error)
        if (self.didUpdateUserHandler) self.didUpdateUserHandler(mapView, nil, nil, error);
        
    }
}

- (void)mapViewDidFailLoadingMap:(MAMapView *)mapView withError:(NSError *)error{
    if (error) {
        DDLog(@"error:%@",error)
        if (self.didUpdateUserHandler) self.didUpdateUserHandler(mapView, nil, nil, error);
        
    }
}

#pragma mark - MAMapView展示元素
/* 大头针 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]]){
        static NSString *pointIdentifier = @"pointIdentifier";
        MAPinAnnotationView *pinView = [MAPinAnnotationView viewWithMapView:mapView annotation:annotation identifier:pointIdentifier];
        
        MAPointAnnotation * anno = (MAPointAnnotation *)annotation;
        NSString * imgKey = [self.annoDict.allKeys containsObject:anno.type] ? anno.type : kPointTypeDefault;
        pinView.image = [UIImage imageNamed:self.annoDict[imgKey]];
        return pinView;
    }
    return nil;
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay{
    // 自定义定位精度对应的MACircleView
    if (overlay == mapView.userLocationAccuracyCircle){
        MACircleRenderer *accuracyCircleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        
        accuracyCircleRenderer.lineWidth    = 2.f;
        accuracyCircleRenderer.strokeColor  = [UIColor lightGrayColor];
        accuracyCircleRenderer.fillColor    = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
        
        //通过颜色隐藏精度圈
        accuracyCircleRenderer.strokeColor  = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.0];
        accuracyCircleRenderer.fillColor    = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.0];
        
        return accuracyCircleRenderer;
    }
    
    if ([overlay isKindOfClass:[SelectableOverlay class]]){
        SelectableOverlay * selectableOverlay = (SelectableOverlay *)overlay;
        id<MAOverlay> actualOverlay = selectableOverlay.overlay;
        
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:actualOverlay];
        
        polylineRenderer.lineWidth = 8.f;
        polylineRenderer.strokeColor = selectableOverlay.isSelected ? selectableOverlay.selectedColor : selectableOverlay.regularColor;
        
        return polylineRenderer;
    }
    
    if ([overlay isKindOfClass:[MAPolyline class]]){
        //初始化一个路线类型的view
        MAPolylineRenderer *polygonView = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        //设置线宽颜色等
        polygonView.lineWidth = 5.f;
        polygonView.strokeColor = [UIColor colorWithRed:0.015 green:0.658 blue:0.986 alpha:1.000];
        polygonView.fillColor = [UIColor colorWithRed:0.940 green:0.771 blue:0.143 alpha:0.800];
        polygonView.lineJoinType = kMALineJoinRound;//连接类型
        //返回view，就进行了添加
        return polygonView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate{
    
    //    DDLog(@"distance___%@",[BN_Map distanceBetweenBeginPoint:self.coordinateBegin endPoint:self.coordinateEnd type:@0]);
    //    [self addAnnotionCoordinate:coordinate title:kPointTypeEnd];
}


#pragma mark - -others
- (void)saveLocation:(CLLocation *)location {
    // 纬度
    NSString *currentLatitude = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    // 经度
    NSString *currentLongitude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    
    [NSUserDefaults.standardUserDefaults setObject:currentLatitude forKey:kUserLatitude];
    [NSUserDefaults.standardUserDefaults setObject:currentLongitude forKey:kUserLongitude];
    [NSUserDefaults.standardUserDefaults synchronize];
    
}

- (BOOL)hasAccessRightOfLocation{
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)) {
        return YES;
    } else {
        DDLog(@"请打开定位权限!");
        
        return NO;
    }
}

- (BOOL)hasLocation {
    return [self.currentLatitude length] && [self.currentLongitude length];
}

- (void)reGeocodeSearchWithRequest:(AMapReGeocodeSearchRequest *)request handler:(MapReGeocodeSearchHandler)handler{
    self.reGeocodeSearchHandler = handler;
    
    [self.searchAPI AMapReGoecodeSearch:request];
    
}

- (void)geocodeSearchWithAddress:(NSString *)address city:(NSString *)city handler:(MapGeocodeSearchHandler)handler{
    self.geocodeSearchHandler = handler;
    
    //    AMapGeocodeSearchRequest *request = [[AMapGeocodeSearchRequest alloc] init];
    
    self.GeocodeRequest.address = address;
    self.GeocodeRequest.city = city;
    [self.searchAPI AMapGeocodeSearch:self.GeocodeRequest];
    
}

#pragma mark - 周边搜索

- (void)aroundSearchCoordinate:(CLLocationCoordinate2D)coordinate keywords:(NSString *)keywords pageIndex:(NSInteger)pageIndex handler:(MapPOISearchHandler)handler {
    self.POISearchHandler = handler;
    
    //    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    self.POIAroundRequest.location          = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    self.POIAroundRequest.keywords          = keywords;
    /* 按照距离排序. */
    self.POIAroundRequest.sortrule          = 0;
    self.POIAroundRequest.requireExtension  = YES;
    self.POIAroundRequest.page              = pageIndex;
    
    [self.searchAPI AMapPOIAroundSearch:self.POIAroundRequest];
}

#pragma mark - 关键字搜索
- (void)keywordsSearchWithKeywords:(NSString *)keywords city:(NSString *)city page:(NSInteger)page handler:(MapPOISearchHandler)handler{
    self.POISearchHandler = handler;
    //    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    self.POIKeywordsRequest.keywords            = keywords;
    self.POIKeywordsRequest.city                = city;
    //    request.types               = @"高等院校";
    self.POIKeywordsRequest.requireExtension    = YES;
    
    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    self.POIKeywordsRequest.cityLimit           = YES;
    //    request.requireSubPOIs      = YES;
    self.POIKeywordsRequest.page = page;
    [self.searchAPI AMapPOIKeywordsSearch:self.POIKeywordsRequest];
}

#pragma mark - 提示搜索
- (void)tipsSearchWithKeywords:(NSString *)key city:(NSString *)city handler:(MapInputTipsHandler)handler{
    self.tipsHandler = handler;
    //    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    
    self.InputTipsRequest.keywords  = key;
    self.InputTipsRequest.city      = city;
    self.InputTipsRequest.cityLimit = YES;
    [self.searchAPI AMapInputTipsSearch:self.InputTipsRequest];
}

-(void)routeSearchBeginPoint:(CLLocationCoordinate2D)beginPoint endPoint:(CLLocationCoordinate2D)endPoint strategy:(NSInteger)strategy type:(NSNumber *)type handler:(MapRouteHandler)handler{
    self.routeHandler = handler;
    //    AMapDrivingRouteSearchRequest *request = [[AMapDrivingRouteSearchRequest alloc] init];
    
    self.DrivingRequest.requireExtension = YES;
    self.DrivingRequest.strategy = strategy ;
    /* 出发点. */
    self.DrivingRequest.origin = [AMapGeoPoint locationWithLatitude:beginPoint.latitude
                                                          longitude:beginPoint.longitude];
    /* 目的地. */
    self.DrivingRequest.destination = [AMapGeoPoint locationWithLatitude:endPoint.latitude
                                                               longitude:endPoint.longitude];
    
    [self.searchAPI AMapDrivingRouteSearch:self.DrivingRequest];
    
}

#pragma mark - AMapSearchDelegate

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
    NSAssert(response.geocodes, @"response.geocodes = nil");
    
    if (self.geocodeSearchHandler) {
        self.geocodeSearchHandler(request, response, nil);
    }
    
    if (self.locationModel.geocodeResponse) {
        self.locationModel.geocodeResponse = response;
    }
    
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    NSAssert(response.regeocode, @"response.regeocode = nil");
    
    if (self.reGeocodeSearchHandler) {
        self.reGeocodeSearchHandler(request, response, nil);
    }
    
    if (self.locationModel.reGeocodeResponse) {
        self.locationModel.reGeocodeResponse = response;
    }
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    NSAssert(response.pois, @"response.pois = nil");
    
    //    for(AMapPOI *poi in response.pois){
    //        DDLog(@"%@.%@-%@-%@",poi.name,poi.district,poi.businessArea,poi.address);
    //    }
    
    if (self.POISearchHandler) {
        self.POISearchHandler(request,response, nil);
    }
    
    if (self.locationModel.POISearchResponse) {
        self.locationModel.POISearchResponse = response;
    }
}

/* 输入提示回调. */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response{
    NSAssert(response.tips, @"response.tips = nil");
    
    if (self.tipsHandler) {
        self.tipsHandler(request,response, nil);
    }
    
    if (self.locationModel.inputTipsResponse) {
        self.locationModel.inputTipsResponse = response;
    }
}

//实现路径搜索的回调函数
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response{
    NSAssert(response.route, @"response.route = nil");
    
    if (self.routeHandler) {
        self.routeHandler(request, response, nil);
    }
    
    if (self.locationModel.RouteResponse) {
        self.locationModel.RouteResponse = response;
    }
    
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    
    if (error) {
        if (self.geocodeSearchHandler)      self.geocodeSearchHandler(request, nil, error);
        if (self.reGeocodeSearchHandler)    self.reGeocodeSearchHandler(request, nil, error);
        if (self.POISearchHandler)          self.POISearchHandler(request,nil, error);
        if (self.tipsHandler)               self.tipsHandler(request,nil, error);
        if (self.routeHandler)              self.routeHandler(request, nil, error);
        
    }
}

#pragma mark - -other funtions
+ (NSString *)distanceBetweenBegin:(CLLocationCoordinate2D )beginPoint end:(CLLocationCoordinate2D )endPoint type:(NSNumber *)type{
    
    MAMapPoint begin = MAMapPointForCoordinate(beginPoint);
    MAMapPoint end = MAMapPointForCoordinate(endPoint);
    
    CLLocationDistance distance =  MAMetersBetweenMapPoints(begin, end);
    NSString * distanceStr = [@(distance) stringValue];
    
    switch (type.integerValue) {//返回米
        case 0:
        {
            return distanceStr;
        }
            break;
        case 1:
        {
            distanceStr = [@(distance/1000.0) stringValue];//返回公里/千米
            return distanceStr;
        }
            break;
        default:
            break;
    }
    return nil;
}

/* 获取指定title的针 */
+ (MAPointAnnotation *)getPointAnnotationTitle:(NSString *)title mapView:(MAMapView *)mapView{
    
    if (mapView.annotations) {
        for (id obj in mapView.annotations) {
            if ([obj isKindOfClass:[MAPointAnnotation class]]) {
                
                MAPointAnnotation * pointAnnotation = (MAPointAnnotation *)obj;
                if ([pointAnnotation.title isEqualToString:title]) {
                    
                    return pointAnnotation;
                }
            }
        }
    }
    return nil;
}

/* 展示当前路线方案. */

//在地图上显示当前选择的路径
- (void)presentCurrentRouteBeginPoint:(CLLocationCoordinate2D )beginPoint
                             endPoint:(CLLocationCoordinate2D )endPoint
                             response:(AMapRouteSearchResponse *)response{
    
    AMapNaviPoint * start = [AMapNaviPoint locationWithLatitude:beginPoint.latitude longitude:beginPoint.longitude];
    AMapNaviPoint * end = [AMapNaviPoint locationWithLatitude:endPoint.latitude longitude:endPoint.longitude];

    //进行单路径规划
    self.isMultipleRoutePlan = NO;
    AMapNaviDrivingStrategy strategy = ConvertDrivingPreferenceToDrivingStrategy(self.isMultipleRoutePlan,//多路径
                                                                                  NO,                       //躲避拥堵
                                                                                  NO,                       //避免收费
                                                                                  NO,                       //不走高速
                                                                                  NO);                      //高速优先

    [AMapNaviDriveManager.sharedInstance calculateDriveRouteWithStartPoints:@[start]
                                                                    endPoints:@[end]
                                                                    wayPoints:nil
                                                              drivingStrategy:strategy];
    
}

+ (NSString *)locationInfo:(id)obj{
    
    NSString *addressInfo = @"";
    if ([obj isKindOfClass:[AMapReGeocode class]]) {
        AMapReGeocode * regeocode = (AMapReGeocode *)obj;
        addressInfo = [NSString stringWithFormat:@"province:%@,city:%@,district:%@,town:%@,neighborhood:%@,building:%@,street:%@,streetNumber:%@",
                       regeocode.addressComponent.province,
                       regeocode.addressComponent.city,
                       regeocode.addressComponent.district,
                       regeocode.addressComponent.township,
                       regeocode.addressComponent.neighborhood,
                       regeocode.addressComponent.building,
                       regeocode.addressComponent.streetNumber.street,
                       regeocode.addressComponent.streetNumber.number
                       ];
        
    }else if ([obj isKindOfClass:[AMapLocationReGeocode class]]) {
        AMapLocationReGeocode *regeocode = (AMapLocationReGeocode *)obj;
        addressInfo = [NSString stringWithFormat:@"province:%@,city:%@,district:%@,street:%@,streetNumber:%@",
                       regeocode.province,
                       regeocode.city,
                       regeocode.district,
                       regeocode.street,
                       regeocode.number
                       ];
        
    }
    return addressInfo;
}

#pragma mark - layz
- (MAMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height - kH_StatusBar - kH_NaviagtionBar)];
        _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _mapView.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _mapView.distanceFilter = kCLLocationAccuracyKilometer;
        _mapView.headingFilter  = 60;
        _mapView.zoomLevel = 16;
     
        ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
        _mapView.showsCompass = YES;
        [_mapView setCompassImage:[UIImage imageNamed:@"map_address_compass@2x.png"]];
        //自定义定位经度圈样式
        _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
        //后台定位
        _mapView.pausesLocationUpdatesAutomatically = NO;
        _mapView.allowsBackgroundLocationUpdates = NO;//iOS9以上系统必须配置
//        _mapView.showsUserLocation = YES;
//        _mapView.userTrackingMode = MAUserTrackingModeFollow;
     
        _mapView.delegate = self;
    }
    return _mapView;
}

- (AMapLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
        _locationManager.delegate = self;
        
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationManager.locationTimeout = 2;
        _locationManager.reGeocodeTimeout = 2;
        
        //iOS 9（不包含iOS 9） 之前设置允许后台定位参数，保持不会被系统挂起
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        _locationManager.allowsBackgroundLocationUpdates = NO;
        
        _locationManager.locatingWithReGeocode = YES;//返回地理信息
    }
    return _locationManager;
}

- (AMapSearchAPI *)searchAPI{
    if (!_searchAPI) {
        _searchAPI = [[AMapSearchAPI alloc] init];
        _searchAPI.delegate = self;
    }
    return _searchAPI;
}

-(AMapGeocodeSearchRequest *)GeocodeRequest{
    if (!_GeocodeRequest) {
        _GeocodeRequest = [[AMapGeocodeSearchRequest alloc]init];
    }
    return _GeocodeRequest;
}

-(AMapPOIAroundSearchRequest *)POIAroundRequest{
    if (!_POIAroundRequest) {
        _POIAroundRequest = [[AMapPOIAroundSearchRequest alloc] init];
        
    }
    return _POIAroundRequest;
}

-(AMapPOIKeywordsSearchRequest *)POIKeywordsRequest{
    if (!_POIKeywordsRequest) {
        _POIKeywordsRequest = [[AMapPOIKeywordsSearchRequest alloc]init];
    }
    return _POIKeywordsRequest;
}

-(AMapInputTipsSearchRequest *)InputTipsRequest{
    if (!_InputTipsRequest) {
        _InputTipsRequest = [[AMapInputTipsSearchRequest alloc]init];
    }
    return _InputTipsRequest;
}

-(AMapDrivingRouteSearchRequest *)DrivingRequest{
    if (!_DrivingRequest) {
        _DrivingRequest = [[AMapDrivingRouteSearchRequest alloc]init];
        
    }
    return _DrivingRequest;
}


-(AMapTip *)mapTipFromPoi:(AMapPOI *)mapPoi{
    
    AMapTip * mapTip = [[AMapTip alloc]init];
    mapTip.uid = mapPoi.uid;
    mapTip.name = mapPoi.name;
    mapTip.adcode = mapPoi.adcode;
    mapTip.district = mapPoi.district;
    mapTip.address = mapPoi.address;
    mapTip.location = mapPoi.location;
    mapTip.typecode = mapPoi.typecode;
    
    return mapTip;
}

@end


@implementation MapLocationInfoModel

-(AMapLocationReGeocode *)locationReGeocode{
    
    if (!_locationReGeocode) {
        _locationReGeocode = [[AMapLocationReGeocode alloc]init];
        
    }
    return _locationReGeocode;
}

-(AMapReGeocodeSearchResponse *)reGeocodeResponse{
    if (!_reGeocodeResponse) {
        _reGeocodeResponse = [[AMapReGeocodeSearchResponse alloc]init];
        
    }
    return _reGeocodeResponse;
}

-(AMapGeocodeSearchResponse *)geocodeResponse{
    if (!_geocodeResponse) {
        _geocodeResponse = [[AMapGeocodeSearchResponse alloc]init];
        
    }
    return _geocodeResponse;
}

-(AMapInputTipsSearchResponse *)inputTipsResponse{
    if (!_inputTipsResponse) {
        _inputTipsResponse = [[AMapInputTipsSearchResponse alloc]init];
        
    }
    return _inputTipsResponse;
    
}

-(AMapRouteSearchResponse *)RouteResponse{
    if (!_RouteResponse) {
        _RouteResponse = [[AMapRouteSearchResponse alloc]init];
        
    }
    return _RouteResponse;
}

-(AMapPOISearchResponse *)POISearchResponse{
    if (!_POISearchResponse) {
        _POISearchResponse = [[AMapPOISearchResponse alloc]init];
    }
    return _POISearchResponse;
}

@end


