//
//  TableViewCell.h
//  iOS task
//
//  Created by Kundan Jadhav on 04/04/15.
//  Copyright (c) 2015 Kundan Jadhav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *PlaceImg;
@property (strong, nonatomic) IBOutlet UILabel *PlaceName;

@end
