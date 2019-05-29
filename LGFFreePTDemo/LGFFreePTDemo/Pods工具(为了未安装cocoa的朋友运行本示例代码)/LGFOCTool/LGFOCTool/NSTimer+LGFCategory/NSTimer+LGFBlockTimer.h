//
//  NSTimer+LGFBlockTimer.h
//  LGFOCTool
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (LGFBlockTimer)

#pragma mark - 创建并返回一个新的NSTimer对象并在当前运行中对其进行调度, 在默认模式下循环
/**
   @discussion 秒钟过去后，定时器启动，
                   将消息aSelector发送到目标。
  
   @param seconds 计时器启动之间的秒数。 如果秒
                   小于或等于0.0，该方法选择
                   代替0.1毫秒的非负值。
  
   @param block 当定时器激发时要调用的块。 定时器保持
                   直到它（定时器）失效为止，对该块的强引用。
 
   @param repeats 如果是，则定时器将重复重新安排自己，直到
                  无效。 如果否，计时器在火灾后将失效。
  
   @return 一个新的NSTimer对象，根据指定的参数进行配置。
 */
+ (NSTimer *)lgf_ScheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats;

#pragma mark - 创建并返回一个用指定块初始化的新NSTimer对象
/**
  @discussion您必须使用addTimer：forMode：将新计时器添加到运行循环中。
                   然后，秒数过后，计时器触发调用
                   块。 （如果定时器配置为重复，则不需要
                   随后将计时器重新添加到运行循环中。）
  
  @param seconds 秒计时器启动之间的秒数。如果秒
                  小于或等于0.0，该方法选择
                  代替0.1毫秒的非负值。
  
  @param block 当定时器激发时要调用的块。计时器指示
                  该块要坚决参照其论点。
  
  @param repeats 重复如果是，则定时器将重复重新安排自己，直到
                  无效。如果否，计时器在火灾后将失效。
  
  @return 一个新的NSTimer对象，根据指定的参数进行配置。
 */
+ (NSTimer *)lgf_TimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats;

@end

NS_ASSUME_NONNULL_END
