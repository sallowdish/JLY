//
//  CurrentLocationModel.h
//  JLY-Baidu
//
//  Created by Rui Zheng on 2014-11-01.
//  Copyright (c) 2014 Rui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"

@interface CurrentLocationModel : NSObject <BMKLocationServiceDelegate>
@property (weak,nonatomic) BMKMapView* mapView;
@property (strong,nonatomic) BMKLocationService* locService;
@end
