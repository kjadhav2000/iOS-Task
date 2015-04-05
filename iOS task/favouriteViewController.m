//
//  favouriteViewController.m
//  iOS task
//
//  Created by Kundan Jadhav on 05/04/15.
//  Copyright (c) 2015 Kundan Jadhav. All rights reserved.
//

#import "favouriteViewController.h"
#import "FavouriteTableViewCell.h"
#import "FavDetailViewController.h"

@interface favouriteViewController ()

@end

@implementation favouriteViewController
@synthesize  pname,paddress,prating,opennow,imageId,favouriteTable,latArr,lngArr;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",pname);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [pname count];
    //count number of row from counting array hear cataGorry is An Array
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"favouriteCell";
    
    FavouriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[FavouriteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:MyIdentifier];
    }
    
//    cell.tag = indexPath.row;
//    // NSDictionary *parsedData = self.loader.parsedData[indexPath.row];
//    //if (parsedData)
//    // {
//    cell.imageView.image = nil;
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
//    dispatch_async(queue, ^(void) {
//        
//        
//        
        NSData* imageData1;
//        
//        if ([[NSUserDefaults standardUserDefaults] objectForKey:[ImgArr objectAtIndex:indexPath.row]]) {
//            
            imageData1 = [[NSUserDefaults standardUserDefaults] objectForKey:[imageId objectAtIndex:indexPath.row]];
//            NSLog(@"found");// image already cached
//        }
//        else{
//            imageData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[ImgArr objectAtIndex:indexPath.row]]];
//            [[NSUserDefaults standardUserDefaults] setObject:imageData1 forKey:[ImgArr objectAtIndex:indexPath.row]];
//            
//            NSLog(@"not found"); // image cached here
//            
//        }
//        
        UIImage* image = [[UIImage alloc] initWithData:imageData1];
        cell.favImg.image = image;
        
//        if (image) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (cell.tag == indexPath.row) {
//                    cell.favImg.image = image;
//                    [cell setNeedsLayout];
//                }
//            });
//        }
  //  });

    
    cell.favName.text=[pname objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%ld",(long)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"fav_detail_segue"]) {
        NSIndexPath *myIndexPath = [favouriteTable
                                    indexPathForSelectedRow];
        NSInteger row = myIndexPath.row;

        FavDetailViewController *oobj = segue.destinationViewController;
        oobj.name= [pname objectAtIndex:row];
        oobj.add=[paddress objectAtIndex:row];
        oobj.ratings=[prating objectAtIndex:row];
        oobj.imgid=[imageId objectAtIndex:row];
        oobj.lat=[latArr objectAtIndex:row];
        oobj.lng=[lngArr objectAtIndex:row];

    }
}
@end
