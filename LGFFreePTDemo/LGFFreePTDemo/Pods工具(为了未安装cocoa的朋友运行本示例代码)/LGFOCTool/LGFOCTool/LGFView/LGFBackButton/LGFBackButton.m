//
//  LGFBackButton.m
//  LGFOCTool
//
//  Created by apple on 2018/6/19.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "LGFBackButton.h"

@implementation LGFBackButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addTarget:self action:@selector(lgf_Back) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(lgf_Back) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)lgf_Back {
    UIViewController *superVC = [self lgf_GetSuperVC:self];
    if (superVC.navigationController) {
        [superVC.navigationController popViewControllerAnimated:YES];
    } else {
        [superVC dismissViewControllerAnimated:YES completion:nil];
    }
}

- (UIViewController*)lgf_GetSuperVC:(UIView *)view {
    id target = view;
    while (target) {
        target = ((UIResponder*)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

@end
