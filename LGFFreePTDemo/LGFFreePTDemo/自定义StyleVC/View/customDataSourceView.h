//
//  customDataSourceView.h
//  LGFFreePTDemo
//
//  Created by apple on 2019/5/24.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFOCTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface customDataSourceView : UIView
@property (weak, nonatomic) IBOutlet UITextView *dataTextView;
@property (copy, nonatomic) void(^lgf_DataSourceBlock)(void);
- (void)lgf_ShowCustomDataSourceView:(UIViewController *)VC oldData:(NSArray *)oldData;
lgf_XibViewForH;
@end

NS_ASSUME_NONNULL_END
