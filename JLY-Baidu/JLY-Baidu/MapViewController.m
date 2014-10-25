//
//  FirstViewController.m
//  JLY-Baidu
//
//  Created by Rui Zheng on 2014-10-25.
//  Copyright (c) 2014 Rui Zheng. All rights reserved.
//

#import "MapViewController.h"


@interface MapViewController () <BMKMapViewDelegate>
@property (strong,nonatomic) BMKMapView* mapView;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [super viewDidLoad];
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.view = _mapView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
