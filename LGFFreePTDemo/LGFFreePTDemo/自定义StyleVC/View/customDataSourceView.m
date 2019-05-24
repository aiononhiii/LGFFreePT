//
//  customDataSourceView.m
//  LGFFreePTDemo
//
//  Created by apple on 2019/5/24.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import "customDataSourceView.h"

@implementation customDataSourceView

lgf_XibViewForM(customDataSourceView, @"customDataSourceView");

- (void)lgf_ShowCustomDataSourceView:(UIViewController *)VC oldData:(NSArray *)oldData {
    self.frame = VC.view.bounds;
    [VC.view addSubview:self];
    self.dataTextView.text = [oldData componentsJoinedByString:@"\n"];
}

- (IBAction)saveData:(UIButton *)sender {
    [lgf_Defaults setObject:self.dataTextView.text forKey:@"LGFCustomDataSource"];
    lgf_HaveBlock(self.lgf_DataSourceBlock);
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([touches anyObject].view == self) {
        [self removeFromSuperview];
    }
}

@end
