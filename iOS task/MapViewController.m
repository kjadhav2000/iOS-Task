//
//  MapViewController.m
//  iOS task
//
//  Created by Kundan Jadhav on 05/04/15.
//  Copyright (c) 2015 Kundan Jadhav. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize location,mapView,Place_name;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //  NSLog(@"%@",location);
    CLLocationCoordinate2D coord;
    coord.latitude = [[location objectForKey:@"lat"]floatValue];
    coord.longitude = [[location objectForKey:@"lng"]floatValue];
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = coord;
    point.title = Place_name;
    [self.mapView addAnnotation:point];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
