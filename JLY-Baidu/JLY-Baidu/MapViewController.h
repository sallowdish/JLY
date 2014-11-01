//
//  FirstViewController.h
//  JLY-Baidu
//
//  Created by Rui Zheng on 2014-10-25.
//  Copyright (c) 2014 Rui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface MapViewController : UIViewController
-(void)addPinOnMap:(BMKUserLocation*) userLocation;

@end

