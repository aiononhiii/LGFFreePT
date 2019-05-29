//
//  LGFTimer.h
//  LGFOCTool
//
//  Created by apple on 2017/5/14.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGFTimer : NSObject

#pragma mark - 初始化一个定时器
/**
 @param ti 时间间隔
 @param aTarget 触发方法所属对象
 @param aSelector 触发方法
 @param userInfo 附带参数
 @param yesOrNo 是否重复
 @return LGFTimer对象
 */
+ (nullable LGFTimer *)lgf_ScheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(nullable id)aTarget selector:(nullable SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;

#pragma mark - 开始定时器

- (void)lgf_TimerReStart;

#pragma mark - 暂停定时器

- (void)lgf_TimerStop;

#pragma mark - 销毁定时器

- (void)lgf_TimerInvalidate;

@end
