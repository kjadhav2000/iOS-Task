//
//  MapViewController.h
//  iOS task
//
//  Created by Kundan Jadhav on 05/04/15.
//  Copyright (c) 2015 Kundan Jadhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface MapViewController : UIViewController
{
    NSDictionary * location;
    NSString* Place_name;
}
- (IBAction)dismiss:(id)sender;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic,strong)NSDictionary* location;
@property(nonatomic,strong)NSString* Place_name;

@end
