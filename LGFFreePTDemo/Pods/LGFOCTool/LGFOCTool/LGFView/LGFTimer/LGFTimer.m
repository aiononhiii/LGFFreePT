//
//  LGFTimer.m
//  LGFOCTool
//
//  Created by apple on 2017/5/14.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "LGFTimer.h"

@interface LGFTimer()
@property  NSTimeInterval ti;
@property (nullable, weak) id atarget;
@property (nullable, nonatomic, assign) SEL aSelector;
@property (nullable, retain) id userInfo;
@property (assign, nonatomic) BOOL isValid;
@property (assign, nonatomic) BOOL yesOrNo;
@end

@implementation LGFTimer

- (id)init{
    self = [super init];
    self.isValid = YES;
    self.yesOrNo = YES;
    return self;
}

#pragma mark - 初始化一个定时器
/**
 @param ti 时间间隔
 @param aTarget 触发方法所属对象
 @param aSelector 触发方法
 @param userInfo 附带参数
 @param yesOrNo 是否重复
 @return LGFTimer对象
 */
+ (nullable LGFTimer *)lgf_ScheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(nullable id)aTarget selector:(nullable SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo {
    LGFTimer *timer = [[LGFTimer alloc]init];
    timer.ti = ti;
    timer.atarget = aTarget;
    timer.aSelector = aSelector;
    timer.userInfo = userInfo;
    
    if (yesOrNo) {
        [timer lgf_RepeatSelector];
    }else{
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ti * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [aTarget performSelectorOnMainThread:aSelector withObject:userInfo waitUntilDone:NO];
        });
    }
    return timer;
}

-(void)lgf_RepeatSelector{
#pragma clang diagnostic push
#pragma clang diagnostic warning "-Wimplicit-retain-self"
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.ti * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if (self.yesOrNo) {
            [self.atarget performSelectorOnMainThread:self.aSelector withObject:self.userInfo waitUntilDone:NO];
        }
        if (self.isValid) {
            [self lgf_RepeatSelector];
        }
    });
#pragma clang diagnostic pop
}

#pragma mark - 开始定时器


- (void)lgf_TimerReStart {
    self.yesOrNo = YES;
}

#pragma mark - 暂停定时器

- (void)lgf_TimerStop {
    self.yesOrNo = NO;
}

#pragma mark - 销毁定时器

- (void)lgf_TimerInvalidate {
    self.isValid = NO;
}

@end
