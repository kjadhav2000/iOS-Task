//
//  PlaceDetailsViewController.m
//  iOS task
//
//  Created by Kundan Jadhav on 05/04/15.
//  Copyright (c) 2015 Kundan Jadhav. All rights reserved.
//

#define APIKEY @"AIzaSyA5XeY-uF_VDJHB02SfRYds38mKAg-FKuo"


#import "PlaceDetailsViewController.h"
#import "MapViewController.h"
#import "AppDelegate.h"
#import "Places.h"
#import "MBProgressHUD.h"
@interface PlaceDetailsViewController ()

@end

@implementation PlaceDetailsViewController
@synthesize placeDetails,PlaceImg,Place_address,Place_name,Place_ratings,Open_status,location;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",placeDetails);
    [self ParseDetails];
}
-(void)ParseDetails
{
    if ([placeDetails objectForKey:@"name"])
        
        Place_name.text= [NSString stringWithFormat:@"%@",[placeDetails objectForKey:@"name"]];
    else
        Place_name.text= @"Not available";

    
    
    if ([placeDetails objectForKey:@"vicinity"])
        
        Place_address.text= [NSString stringWithFormat:@" Address: %@",[placeDetails objectForKey:@"vicinity"]];
    else
        Place_address.text= @"Not available";
    
    
    if ([placeDetails objectForKey:@"rating"])
        
        Place_ratings.text=[NSString stringWithFormat:@"%@",[placeDetails objectForKey:@"rating"]] ;
    else
        Place_ratings.text= @"NA";
    Open_status.textColor= [UIColor yellowColor];

    
    if ([placeDetails objectForKey:@"opening_hours"])
    {
        
        NSDictionary* opening_hours= [placeDetails objectForKey:@"opening_hours"];
        NSInteger status = [[opening_hours objectForKey:@"open_now"]integerValue];
        if (status==1) {
            Open_status.text =[NSString stringWithFormat:@"Currently: Open"];
            Open_status.textColor= [UIColor purpleColor];
        }
        else{
            Open_status.text =[NSString stringWithFormat:@"Currently: Closed"];
            Open_status.textColor= [UIColor redColor];
        }
     
    }// Place_ratings.text=[NSString stringWithFormat:@"Ratings: %@",[placeDetails objectForKey:@"opening_hours"]] ;
    else
    {
        Open_status.text= @"Open status not available";
        Open_status.textColor= [UIColor orangeColor];

    }
    
    if ([placeDetails objectForKey:@"geometry"])
    {
        
        NSDictionary* geometry= [placeDetails objectForKey:@"geometry"];
         location = [geometry objectForKey:@"location"];
    }
    
   
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:[placeDetails objectForKey:@"id"]]) {   //check if image is already cached or not
        
        // when user taps the same place again then use the image show saved image
        //show cached image
         NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:[placeDetails objectForKey:@"id"]];
        NSLog(@"found");// image already cached
        UIImage* image = [[UIImage alloc] initWithData:imageData];
        PlaceImg.image=image;
    }
    
    else
    {
        
        //download image from photo reference from first API call
        if ([placeDetails objectForKey:@"photos"]) {
            
            NSDictionary * photos =[[placeDetails objectForKey:@"photos"]objectAtIndex:0];
            NSString *photo_reference= [photos objectForKey:@"photo_reference"];
            
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                // Do something...
                
                
                NSString *JSONURL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=%@&key=%@",photo_reference,APIKEY];
                
                NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:JSONURL] ];
                if (data) {
                    [self performSelectorOnMainThread:@selector(fetchedImg:) withObject:data waitUntilDone:YES];
                    // [self performSelectorOnMainThread:@selector(onemethod) withObject:nil waitUntilDone:YES];
                }
                else
                {
                    // NSLog(@" error data is nil");
                    [self performSelectorInBackground:@selector(Alert) withObject:nil];
                }
                
            });
            
        }
        else
        {
            
            // if photo reference does not exists in first API then use default icon image
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                // Do something...
                
                
                if ([placeDetails objectForKey:@"icon"])
                {
                    
                    NSString* icon= [placeDetails objectForKey:@"icon"];
                    
                    
                    
                    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:icon] ];
                    if (data) {
                        [self performSelectorOnMainThread:@selector(fetchedImg:) withObject:data waitUntilDone:YES];
                        // [self performSelectorOnMainThread:@selector(onemethod) withObject:nil waitUntilDone:YES];
                    }
                    else
                    {
                        // NSLog(@" error data is nil");
                        [self performSelectorInBackground:@selector(Alert) withObject:nil];
                    }
                }
            });
        }
 
    }
    
        }
    
- (void)fetchedImg:(NSData *)responseData
{
    //cache image and use id as key
    
        [[NSUserDefaults standardUserDefaults] setObject:responseData forKey:[placeDetails objectForKey:@"id"]];
        
        NSLog(@"not found"); // image cached here
        UIImage* image = [[UIImage alloc] initWithData:responseData];
        PlaceImg.image=image;
}

-(void)Alert
{
    
    UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"oops" message:@"unable to download image" delegate:self cancelButtonTitle:@"Okay"otherButtonTitles:nil];
    [alert show];
    
}
//    if ([placeDetails objectForKey:@"types"])
//    {
//        
//        NSArray* types=[placeDetails objectForKey:@"types"];
//        
//        
//        NSString * result =[NSString stringWithFormat:@"[%@]",[[types valueForKey:@"description"] componentsJoinedByString:@"] ["]] ;
//        
//
//    }
//    else
//    
//    {
//        Place_ratings.text= @"Not available";
//    }
    

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

- (IBAction)SetFavourite:(id)sender {
    
    NSError *error;

    
    AppDelegate *app = [[AppDelegate alloc]init];
    
    NSManagedObjectContext *context = [app managedObjectContext];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Places"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"imageid == %@",[placeDetails objectForKey:@"id"]]];
    [request setFetchLimit:1];
    NSUInteger count = [context countForFetchRequest:request error:&error];
    if (count == NSNotFound)
    {
        
    }
    // some error occurred
    else if (count == 0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Loading";
        
        NSLog(@"No match found");
        Places *place = [NSEntityDescription insertNewObjectForEntityForName:@"Places" inManagedObjectContext:context];
        
        place.pname  = Place_name.text;
        place.paddress = Place_address.text;
        place.prating = Place_ratings.text;;
        place.imageid=[placeDetails objectForKey:@"id"];
        place.lat=[[location objectForKey:@"lat"]floatValue];
        place.lng=[[location objectForKey:@"lng"]floatValue];

        
        if (![context save:&error])
        {
            UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"CoreData" message:@"Error" delegate:nil cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
            [al show];
            
        }
        else
        {
            UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"Successful" message:@"Place added to favourites" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [al show];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            NSLog(@"Data is saved");
        }

    }// no matching object
    else
    {
        NSLog(@"match found");
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"already exists" message:@"Place already exists in favourite" delegate:nil cancelButtonTitle:@"Cancle" otherButtonTitles:nil];
        [al show];

    }
    
}
- (IBAction)Dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"map_segue"]) {
        // [self performSelectorInBackground:@selector(activitystart) withObject:nil];
        MapViewController *oobj = segue.destinationViewController;
        oobj.Place_name= [placeDetails objectForKey:@"name"];
        oobj.location=location;
    }
}
@end
