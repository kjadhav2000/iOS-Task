//
//  FavDetailViewController.h
//  iOS task
//
//  Created by Kundan Jadhav on 05/04/15.
//  Copyright (c) 2015 Kundan Jadhav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavDetailViewController : UIViewController
{
    
    NSString* name,*add,*ratings,*openstatus;
}
@property (strong, nonatomic) IBOutlet UILabel *pname;
@property (strong, nonatomic) IBOutlet UILabel *favrating;
@property (strong, nonatomic) IBOutlet UIImageView *favImg;
- (IBAction)seeonmap:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *paddress;
- (IBAction)dismiss:(id)sender;
@property(nonatomic,strong)NSString *name,*add,*ratings,*imgid;
@property(nonatomic,strong)NSNumber *lat,*lng;

@end
