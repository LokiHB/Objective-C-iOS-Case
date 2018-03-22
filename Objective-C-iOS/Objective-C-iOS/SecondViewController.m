//
//  SecondViewController.m
//  Objective-C-iOS
//
//  Created by bys on 20/03/2018.
//  Copyright © 2018 bys. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end
@import AppCenter;
@import AppCenterAnalytics;
@import AppCenterCrashes;
@import AppCenterPush;
@implementation SecondViewController

- (void)viewDidLoad {
    [MSCrashes generateTestCrash];
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
