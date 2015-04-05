//
//  favouriteViewController.h
//  iOS task
//
//  Created by Kundan Jadhav on 05/04/15.
//  Copyright (c) 2015 Kundan Jadhav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface favouriteViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *pname,*paddress,*prating,*opennow,*imageId,*latArr,*lngArr;
 
}
@property (strong, nonatomic) IBOutlet UITableView *favouriteTable;
@property(nonatomic,strong)NSMutableArray *pname,*paddress,*prating,*opennow,*imageId,*latArr,*lngArr;
@end
