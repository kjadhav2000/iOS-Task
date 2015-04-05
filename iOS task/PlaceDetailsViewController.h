//
//  PlaceDetailsViewController.h
//  iOS task
//
//  Created by Kundan Jadhav on 05/04/15.
//  Copyright (c) 2015 Kundan Jadhav. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PlaceDetailsViewController : UIViewController
{
    NSDictionary *placeDetails;
}
@property (strong, nonatomic) IBOutlet UILabel *Place_name;
@property (strong, nonatomic) IBOutlet UILabel *Place_address;
@property (strong, nonatomic) IBOutlet UILabel *Place_ratings;
@property (strong, nonatomic) IBOutlet UILabel *Open_status;
- (IBAction)SetFavourite:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *PlaceImg;
- (IBAction)Dismiss:(id)sender;
@property(nonatomic,strong)NSDictionary *placeDetails;
@property(nonatomic,strong)NSDictionary *location;

@end
