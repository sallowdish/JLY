//
//  FirstViewController.m
//  JLY-Baidu
//
//  Created by Rui Zheng on 2014-10-25.
//  Copyright (c) 2014 Rui Zheng. All rights reserved.
//

#import "MapViewController.h"
#import "CurrentLocationModel.h"


@interface MapViewController () <BMKMapViewDelegate>
@property (strong,nonatomic) BMKMapView* mapView;
@property (strong,nonatomic) id<BMKAnnotation> myLocationPin;
@property (strong,nonatomic) CurrentLocationModel* curLocationModel;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //inilialize map
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.frame];
    _mapView.autoresizingMask=self.view.autoresizingMask;

    [self.view insertSubview:_mapView atIndex:0];
    
    self.curLocationModel=[[CurrentLocationModel alloc] init];
    self.curLocationModel.mapView=_mapView;
    
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
    
    self.curLocationModel.locService.delegate=nil;
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
