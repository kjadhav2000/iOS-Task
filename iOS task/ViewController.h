//
//  ViewController.h
//  iOS task
//
//  Created by Kundan Jadhav on 03/04/15.
//  Copyright (c) 2015 Kundan Jadhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate>

{
    NSMutableArray *pname,*paddress,*prating,*imageId,*latArr,*lngArr;

}
- (IBAction)SelectRadius:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *settingButton;
-(IBAction)switchToCategoryFromButton:(id)sender;
@property (nonatomic, retain) CLLocationManager *locationMgr;
@property (nonatomic, retain) CLLocation *lastLocation;
@property(nonatomic,strong)NSDictionary* PlacesArray;
- (IBAction)showFavourites:(id)sender;
@end

