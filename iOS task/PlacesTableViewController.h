//
//  PlacesTableViewController.h
//  iOS task
//
//  Created by Kundan Jadhav on 04/04/15.
//  Copyright (c) 2015 Kundan Jadhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"

@interface PlacesTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* location_name;
}
@property(nonatomic,strong) NSArray* PlacesArray;
@property(nonatomic,strong) NSMutableArray* location_name;
@property (strong, nonatomic) IBOutlet UITableView *placesTable;
@property(nonatomic,strong) NSMutableArray* testing;
@property(nonatomic,strong)NSMutableArray *ImgArr;


@end
