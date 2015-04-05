//
//  PlacesTableViewController.m
//  iOS task
//
//  Created by Kundan Jadhav on 04/04/15.
//  Copyright (c) 2015 Kundan Jadhav. All rights reserved.
//

#import "PlacesTableViewController.h"
#import "PlaceDetailsViewController.h"

@interface PlacesTableViewController ()

@end

@implementation PlacesTableViewController
@synthesize PlacesArray,placesTable,location_name,testing,ImgArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    location_name=[[NSMutableArray alloc]init];
    testing=[[NSMutableArray alloc]init];
    
    ImgArr=[[NSMutableArray alloc]init];

    [self ParsePlaceData];
}
-(void)ParsePlaceData
{
    //NSString *lat,*lng;
    for(int i=0;i<PlacesArray.count;++i)
    {
        NSDictionary *PlaceDetails=[PlacesArray objectAtIndex:i];
        NSString * name= [PlaceDetails objectForKey:@"name"];
        NSString * icon = [PlaceDetails objectForKey:@"icon"];
        [ImgArr addObject:icon];
        [location_name addObject:name];
    }

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
      return [location_name count];    //count number of row from counting array hear cataGorry is An Array
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:MyIdentifier];
    }
    
    cell.tag = indexPath.row;
   // NSDictionary *parsedData = self.loader.parsedData[indexPath.row];
   //if (parsedData)
   // {
        cell.imageView.image = nil;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^(void) {

            

            NSData* imageData1;
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:[ImgArr objectAtIndex:indexPath.row]]) {
                
            imageData1 = [[NSUserDefaults standardUserDefaults] objectForKey:[ImgArr objectAtIndex:indexPath.row]];
                NSLog(@"found");// image already cached
            }
            else{
                imageData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[ImgArr objectAtIndex:indexPath.row]]];
                [[NSUserDefaults standardUserDefaults] setObject:imageData1 forKey:[ImgArr objectAtIndex:indexPath.row]];
                
                NSLog(@"not found"); // image cached here

            }

            UIImage* image = [[UIImage alloc] initWithData:imageData1];

                                 if (image) {
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         if (cell.tag == indexPath.row) {
                                             cell.PlaceImg.image = image;
                                             [cell setNeedsLayout];
                                         }
                                     });
                                 }
                                 });
                                 

    cell.PlaceName.text=[location_name objectAtIndex:indexPath.row];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%ld",(long)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    //[location_name removeAllObjects];
    
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"place_detail_segue"]) {
        // [self performSelectorInBackground:@selector(activitystart) withObject:nil];
        PlaceDetailsViewController *oobj = segue.destinationViewController;
        // oobj.bookQuote=[[BookingObjects alloc]init];
        NSIndexPath *myIndexPath = [placesTable
                                    indexPathForSelectedRow];
        NSInteger row = myIndexPath.row;
        NSLog(@"%ld",(long)row);
       oobj.placeDetails= [PlacesArray objectAtIndex:row];
        
    }
}

@end
