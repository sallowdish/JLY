//
//  FirstViewController.m
//  JLY-Baidu
//
//  Created by Rui Zheng on 2014-10-25.
//  Copyright (c) 2014 Rui Zheng. All rights reserved.
//

#import "MapViewController.h"

#define KEEP_GPS_OPEN 0


@interface MapViewController () <BMKMapViewDelegate,BMKLocationServiceDelegate>
@property (strong,nonatomic) BMKMapView* mapView;
@property (strong,nonatomic) BMKLocationService* locService;
@property (strong,nonatomic) id<BMKAnnotation> myLocationPin;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //inilialize map
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.view = _mapView;
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    //get current location
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    
    _locService.delegate=nil;
}

- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);

    [self addPinOnMap:userLocation];
    
//    _mapView.showsUserLocation = YES;//显示定位图层
//    [_mapView updateLocationData:userLocation];
    _mapView.centerCoordinate=userLocation.location.coordinate;
    if (!KEEP_GPS_OPEN) {
        [_locService stopUserLocationService];
    }
    
}
-(void)addPinOnMap:(BMKUserLocation*) userLocation{
    if (!_myLocationPin) {
        BMKPointAnnotation* newAno=[[BMKPointAnnotation alloc] init];
        newAno.title=@"You are here";
        newAno.subtitle=[NSString stringWithFormat:@"%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude];
        _myLocationPin=(id<BMKAnnotation>)newAno;
    }
    _myLocationPin.coordinate=userLocation.location.coordinate;
    [_mapView addAnnotation:_myLocationPin];
}

-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]){
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        
        newAnnotationView.canShowCallout = YES;
        
        return newAnnotationView;
        
    }
    
    return nil;
    
}

-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
}

-(void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view{
    if ([view.annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPointAnnotation* pointAnno=view.annotation;
        NSLog(@"%@",pointAnno.title);
        [self performSegueWithIdentifier:@"AnnotationToDetailSegue" sender:view];
    }
}

- (void)didFailToLocateUserWithError:(NSError *)error{
    NSLog(@"Fail to get current location, %@", [error localizedDescription]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
