//
//  RWTestViewController.h
//  RWBlurPopoverDemo
//
//  Created by Zhang Bin on 2014-07-07.
//  Copyright (c) 2014年 Zhang Bin. All rights reserved.
//

@import UIKit;

@interface RWTestViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISlider *setRadius;
@property (strong, nonatomic) IBOutlet UILabel *showValue;
- (IBAction)setRadiusAct:(id)sender;

@end
