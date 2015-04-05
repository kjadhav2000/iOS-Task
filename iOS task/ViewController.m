//
//  ViewController.m
//  iOS task
//
//  Created by Kundan Jadhav on 03/04/15.
//  Copyright (c) 2015 Kundan Jadhav. All rights reserved.
//
#define GDQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define APIKEY @"AIzaSyA5XeY-uF_VDJHB02SfRYds38mKAg-FKuo"

#import "ViewController.h"
#import "UIColor+FlatUI.h"
#import "RWBlurPopover.h"
#import "RWTestViewController.h"
#import "PlacesTableViewController.h"
#import "AppDelegate.h"
#import "Places.h"
#import "favouriteViewController.h"
#import "MBProgressHUD.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize settingButton,PlacesArray;
//@synthesize locationMgr,lastLocation;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    PlacesArray=[[NSDictionary alloc]init];

    
    
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.barTintColor = [UIColor wetAsphaltColor];;
  // self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor : [UIColor whiteColor]};
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //self.navigationItem.prompt=NSLocalizedString(@"Please_select_City", @"Please select City");
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(handleEnterForeground)name:@"xyzUIApplicationWillEnterForegroundNotification"object: nil];
    
    
    [self CheckLocationServices];
    
    self.locationMgr = [[CLLocationManager alloc] init];
    self.locationMgr.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationMgr.delegate = self;
    NSString *ver1 = [[UIDevice currentDevice] systemVersion];
    float ver_float1 = [ver1 floatValue];
    
    if (ver_float1 >= 8.0)
    {
        [self.locationMgr requestWhenInUseAuthorization];
        
    }

    [self.locationMgr startUpdatingLocation];
    self.lastLocation = nil;


}

-(void)CheckLocationServices  //check location servies are enabled
{
    if(![CLLocationManager locationServicesEnabled]) {
        
        
        UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"Location not available" message:@"Please enable Location Services"delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        
        [alert show];
        
    }
}
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation

{
    if (!self.lastLocation) {
        self.lastLocation = newLocation;
    }
    
    if (newLocation.coordinate.latitude != self.lastLocation.coordinate.latitude &&
        newLocation.coordinate.longitude != self.lastLocation.coordinate.longitude) {
        self.lastLocation = newLocation;
         NSLog(@"New location: %f, %f",self.lastLocation.coordinate.latitude,self.lastLocation.coordinate.longitude);
        [self.locationMgr stopUpdatingLocation];
    }
    
    
}
- (void) handleEnterForeground
{
    [self CheckLocationServices];
    self.locationMgr.delegate = self;
    NSString *ver1 = [[UIDevice currentDevice] systemVersion];
    float ver_float1 = [ver1 floatValue];
    
    if (ver_float1 >= 8.0)
    {
        [self.locationMgr requestWhenInUseAuthorization];
    }
    [self.locationMgr startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SelectRadius:(id)sender {
    
   // settingButton.userInteractionEnabled=NO;
    RWTestViewController *vc = [[RWTestViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [RWBlurPopover showContentViewController:nav insideViewController:self];

}

-(void)fetchPlacesFromAPI:(NSString *)type;
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        
        NSLog(@"%f , %f",self.lastLocation.coordinate.latitude,self.lastLocation.coordinate.longitude);
        
        float Radius= [[[NSUserDefaults standardUserDefaults]objectForKey:@"UserDefinedRadiusValue"]floatValue];  //retrive cached radius
        
        NSString *JSONURL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=%.f&types=%@&sensor=false&key=%@",self.lastLocation.coordinate.latitude,self.lastLocation.coordinate.longitude,Radius,type,APIKEY];
        
        
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:JSONURL] ];
        
        
        if (data) {
            [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
        }
        else
        {
            // NSLog(@" error data is nil");
            [self performSelectorInBackground:@selector(Alert) withObject:nil];
        }
       
    });

}
-(void)Alert
{
    
    UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"No Internet" message:@"Internet connection problem" delegate:self cancelButtonTitle:@"Okay"otherButtonTitles:nil];
        [alert show];
    
}

- (void)fetchedData:(NSData *)responseData
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData
                                                         options:kNilOptions
                                                           error:&error];
    
    NSString *status=[json valueForKey:@"status"];
    // NSLog(@"%@",[json valueForKey:@"status"]);
    if ([status isEqual: @"NOT_FOUND" ])
    {
        
        UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"Location not available" message:status delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        
        [alert show];    }
    
    else if ([status isEqual: @"ZERO_RESULTS"])
    {
        UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"Location not available" message:status delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        
        [alert show];
        
    }
    else
    {
        PlacesArray = [json valueForKey:@"results"];
        [self performSelectorOnMainThread:@selector(PushPlacesViewController) withObject:nil waitUntilDone:YES];

        
    }
    
}

-(IBAction)switchToCategoryFromButton:(id)sender{
    
    switch ([sender tag]) {
        case 1:
            
            [self fetchPlacesFromAPI:@"gym"];
            
            //[self performSelectorOnMainThread:@selector(PushPlacesViewController) withObject:nil waitUntilDone:YES];
            break;
        case 2:
            
            [self fetchPlacesFromAPI:@"hospital"];
            
            break;
        case 3:
            
            [self fetchPlacesFromAPI:@"food"];
            
            break;
        case 4:
            
            [self fetchPlacesFromAPI:@"spa"];
            
            break;
        case 5:
            
            [self fetchPlacesFromAPI:@"school"];
            
            break;
            
        case 6:
            
            [self fetchPlacesFromAPI:@"restaurant"];

            break;
            
            
        default: ;
    }
    
    
}
-(void)PushPlacesViewController
{
    [self performSegueWithIdentifier:@"Places_segue" sender:self];
    
}
-(void)PushFavouriteViewController
{
    [self performSegueWithIdentifier:@"favourite_segue" sender:self];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"Places_segue"]) {
        PlacesTableViewController *oobj = segue.destinationViewController;
        
//        oobj.locationArray=locationArray;
//        oobj.lastLocation=lastLocation;
            oobj.PlacesArray=PlacesArray;
    }
    else if ([segue.identifier isEqualToString:@"favourite_segue"])
    {
        favouriteViewController *oobj = segue.destinationViewController;
        
        //        oobj.locationArray=locationArray;
        //        oobj.lastLocation=lastLocation;
        oobj.pname=pname;
        oobj.paddress=paddress;
        oobj.prating=prating;
        oobj.imageId=imageId;
        oobj.latArr=latArr;
        oobj.lngArr=lngArr;

        
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    //[location_name removeAllObjects];
    
    
}

- (IBAction)showFavourites:(id)sender {
    
    pname = [[NSMutableArray alloc]init];
    paddress = [[NSMutableArray alloc]init];
    prating = [[NSMutableArray alloc]init];
    imageId = [[NSMutableArray alloc]init];
    latArr=[[NSMutableArray alloc]init];
    lngArr=[[NSMutableArray alloc]init];


    AppDelegate *app = [[AppDelegate alloc]init];
    
    NSManagedObjectContext *context = [app managedObjectContext];
    
    
    // Test listing all FailedBankInfos from the store
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Places"
                                              inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (Places *info in fetchedObjects)
    {
        
        NSNumber*latitude=[NSNumber numberWithFloat: info.lat];
        NSNumber*longitude=[NSNumber numberWithFloat: info.lng];

        [pname addObject:info.pname];
        [paddress addObject:info.paddress];
        [prating addObject:info.prating];
        [imageId addObject:info.imageid];
        [latArr addObject:latitude];
        [lngArr addObject:longitude];


       // NSLog(@"%@  %@  %@  %@ %@  %@",info.pname,info.paddress,info.prating,info.imageid, latitude,longitude);
        
    }
    [self performSelectorOnMainThread:@selector(PushFavouriteViewController) withObject:nil waitUntilDone:YES];

    

}
@end
