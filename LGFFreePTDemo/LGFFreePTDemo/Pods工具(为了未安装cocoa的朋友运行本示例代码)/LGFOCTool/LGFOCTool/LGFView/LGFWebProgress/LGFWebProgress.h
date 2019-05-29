//
//  LGFWebProgress.h
//  OptimalLive
//
//  Created by apple on 2018/12/10.
//  Copyright © 2018年 QT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFOCTool.h"

@interface LGFWebProgress : UIView
lgf_XibViewForH;
- (void)lgf_ShowLGFWebProgress:(UIView *)SV top:(CGFloat)top height:(CGFloat)height color:(UIColor *)color;
- (void)finishLoad;
@end
