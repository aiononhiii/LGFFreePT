//
//  UIView+LGFAddGestureRecognizer.m
//  LGFOCTool
//
//  Created by apple on 2019/4/22.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import "UIView+LGFAddGestureRecognizer.h"

@implementation UIView (LGFAddGestureRecognizer)

- (void)lgf_AddTapAction:(SEL)tapAction target:(id)target {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:tapAction];
    [self addGestureRecognizer:gesture];
}

- (void)lgf_AddLongAction:(SEL)longAction target:(id)target duration:(CGFloat)duration {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:longAction];
    gesture.minimumPressDuration = duration;
    [self addGestureRecognizer:gesture];
}

- (void)lgf_AddSwipeAction:(SEL)swipeAction target:(id)target direction:(UISwipeGestureRecognizerDirection)direction {
    self.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:swipeAction];
    gesture.direction = direction;
    [self addGestureRecognizer:gesture];
}

- (void)lgf_AddPanAction:(SEL)panAction target:(id)target {
    self.userInteractionEnabled = YES;
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:panAction];
    [self addGestureRecognizer:gesture];
}

@end
