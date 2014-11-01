//
//  CurrentLocationModel.m
//  JLY-Baidu
//
//  Created by Rui Zheng on 2014-11-01.
//  Copyright (c) 2014 Rui Zheng. All rights reserved.
//

#import "CurrentLocationModel.h"
#import "AppDelegate.h"
#import "MapViewController.h"

@implementation CurrentLocationModel

-(instancetype)init{
    self=[super init];
    if (self) {
        //get current location
        //初始化BMKLocationService
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate = self;
        //启动LocationService
        [_locService startUserLocationService];
    }
    return self;
}

- (void)didFailToLocateUserWithError:(NSError *)error{
    NSLog(@"Fail to get current location, %@", [error localizedDescription]);
}



- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    if (_mapView) {
        _mapView.centerCoordinate=userLocation.location.coordinate;
        [_mapView.delegate performSelector:@selector(addPinOnMap:) withObject:userLocation];
//         addPinOnMap:userLocation];

    }
    if (!KEEP_GPS_OPEN) {
        [_locService stopUserLocationService];
    }
    
}
@end
