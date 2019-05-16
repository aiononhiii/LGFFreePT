//
//  LGFColorSelectImageView.h
//  LGFFreePTDemo
//
//  Created by apple on 2019/5/14.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGFColorSelectImageView : UIImageView

@property (copy, nonatomic) void(^lgf_CurrentColorBlock)(UIColor *color, NSString *colorHexString);
@end

NS_ASSUME_NONNULL_END
