//
//  ChildViewController.m
//  LGFFreePTDemo
//
//  Created by apple on 2019/4/29.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import "ChildViewController.h"

@interface ChildViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation ChildViewController

lgf_SBViewControllerForM(ChildViewController, @"Main", @"ChildViewController");

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    NSLog(@"子控制器 %ld 走 viewWillAppear", (long)self.index);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"子控制器 %ld 走 viewWillDisappear", (long)self.index);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"子控制器 %ld 走 viewDidDisappear", (long)self.index);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"子控制器 %ld 走 viewDidAppear", (long)self.index);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = [NSString stringWithFormat:@"我是子控制器 %ld 号", (long)self.index];
}

@end
