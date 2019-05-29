//
//  NSTimer+LGFBlockTimer.m
//  LGFOCTool
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "NSTimer+LGFBlockTimer.h"

@implementation NSTimer (LGFBlockTimer)

+ (void)lgf_ExecBlock:(NSTimer *)timer {
    if ([timer userInfo]) {
        void (^block)(NSTimer *timer) = (void (^)(NSTimer *timer))[timer userInfo];
        block(timer);
    }
}

+ (NSTimer *)lgf_ScheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats {
    return [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(lgf_ExecBlock:) userInfo:[block copy] repeats:repeats];
}

+ (NSTimer *)lgf_TimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats {
    return [NSTimer timerWithTimeInterval:seconds target:self selector:@selector(lgf_ExecBlock:) userInfo:[block copy] repeats:repeats];
}

@end

