//
//  AppDelegate.h
//  JLY-Baidu
//
//  Created by Rui Zheng on 2014-10-25.
//  Copyright (c) 2014 Rui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BMKMapManager* _mapManager;

@end



