//
//  UIView+LGFAddGestureRecognizer.h
//  LGFOCTool
//
//  Created by apple on 2019/4/22.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LGFAddGestureRecognizer)
- (void)lgf_AddTapAction:(SEL)tapAction target:(id)target;

- (void)lgf_AddLongAction:(SEL)longAction target:(id)target duration:(CGFloat)duration;

- (void)lgf_AddSwipeAction:(SEL)swipeAction target:(id)target direction:(UISwipeGestureRecognizerDirection)direction;

- (void)lgf_AddPanAction:(SEL)panAction target:(id)target;
@end

NS_ASSUME_NONNULL_END
