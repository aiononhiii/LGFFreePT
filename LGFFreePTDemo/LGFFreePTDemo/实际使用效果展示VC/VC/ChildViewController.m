//
//  ChildViewController.m
//  LGFFreePTDemo
//
//  Created by apple on 2019/4/29.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import "ChildViewController.h"

@interface ChildViewController ()

@end

@implementation ChildViewController

lgf_SBViewControllerForM(ChildViewController, @"Main", @"ChildViewController");

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
