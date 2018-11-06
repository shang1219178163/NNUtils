//
//  MAPinAnnotationView+Helper.m
//  Utilis
//
//  Created by hsf on 2018/10/23.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "MAPinAnnotationView+Helper.h"

@implementation MAPinAnnotationView (Helper)

static NSString *_identifer = @"MAPinAnnotationView";

+(instancetype)viewWithMapView:(MAMapView *)mapView annotation:(id<MAAnnotation>)annotation identifier:(NSString *)identifier{

    MAPinAnnotationView *view = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (view == nil){
        view = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                  reuseIdentifier:identifier];
    }
    
    view.animatesDrop   = NO;
    view.canShowCallout = YES;
    view.draggable      = NO;
    
    view.pinColor = (annotation == mapView.annotations.lastObject ? MAPinAnnotationColorRed : MAPinAnnotationColorGreen);
    
    return view;
}

+(instancetype)viewWithMapView:(MAMapView *)mapView annotation:(id<MAAnnotation>)annotation{
//    NSString *identifier = NSStringFromClass(self.class);
//    return [self viewWithMapView:mapView annotation:annotation identifier:identifier];
    return [self viewWithMapView:mapView annotation:annotation identifier:_identifer];

}

@end
