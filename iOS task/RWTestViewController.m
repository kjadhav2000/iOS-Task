//
//  RWTestViewController.m
//  RWBlurPopoverDemo
//
//  Created by Zhang Bin on 2014-07-07.
//  Copyright (c) 2014年 Zhang Bin. All rights reserved.
//

#import "RWTestViewController.h"
#import "ViewController.h"

@interface RWTestViewController ()

@end

@implementation RWTestViewController
@synthesize setRadius,showValue;

- (CGSize)preferredContentSize {
    return CGSizeMake(280, 160);
}

- (void)dismiss {
    NSLog(@"content issued dismissal started");
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"content issued dismissal ended");
        
        NSLog(@"%.f",setRadius.value);
        [[NSUserDefaults standardUserDefaults]setInteger:setRadius.value forKey:@"UserDefinedRadiusValue"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
   // [self.view addGestureRecognizer:tap];
    setRadius.minimumValue=100;
    setRadius.maximumValue=50000;
    setRadius.continuous = YES;
    setRadius.value =[[[NSUserDefaults standardUserDefaults]objectForKey:@"UserDefinedRadiusValue"]floatValue];
;
    showValue.text=[NSString stringWithFormat:@"Radius: %.f meters",setRadius.value];
    
    [ [UIBarButtonItem appearance] setTintColor:[UIColor blackColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss)];
}



- (IBAction)setRadiusAct:(id)sender {
    UISlider *slider = (UISlider*)sender;
    int value = slider.value;
    NSLog(@"%d",value);
    showValue.text=[NSString stringWithFormat:@"Radius: %d meters",value];
    
    
}
@end
