//
//  FavDetailViewController.m
//  iOS task
//
//  Created by Kundan Jadhav on 05/04/15.
//  Copyright (c) 2015 Kundan Jadhav. All rights reserved.
//

#import "FavDetailViewController.h"
#import "MapViewController.h"

@interface FavDetailViewController ()

@end

@implementation FavDetailViewController
@synthesize name,add,ratings;
@synthesize pname,paddress,favImg,favrating,imgid,lat,lng;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    pname.text=name;
    paddress.text=add;
    favrating.text=ratings;
    
    
   NSData* imageData1 = [[NSUserDefaults standardUserDefaults] objectForKey:imgid];
    
    UIImage* image = [[UIImage alloc] initWithData:imageData1];
    favImg.image = image;
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

- (IBAction)seeonmap:(id)sender {
    
    
    
    
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"favToMapSegue"]) {
//        NSIndexPath *myIndexPath = [favouriteTable
//                                    indexPathForSelectedRow];
//        NSInteger row = myIndexPath.row;
        
        MapViewController *oobj = segue.destinationViewController;
        oobj.location = [[NSDictionary alloc]initWithObjectsAndKeys:lat,@"lat",lng,@"lng", nil];
        oobj.Place_name=name;
    }
}


@end
