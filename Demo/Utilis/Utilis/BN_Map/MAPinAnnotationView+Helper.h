//
//  MAPinAnnotationView+Helper.h
//  Utilis
//
//  Created by hsf on 2018/10/23.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAPinAnnotationView (Helper)

+(instancetype)viewWithMapView:(MAMapView *)mapView annotation:(id<MAAnnotation>)annotation identifier:(NSString *)identifier;
+(instancetype)viewWithMapView:(MAMapView *)mapView annotation:(id<MAAnnotation>)annotation;

@end

NS_ASSUME_NONNULL_END
