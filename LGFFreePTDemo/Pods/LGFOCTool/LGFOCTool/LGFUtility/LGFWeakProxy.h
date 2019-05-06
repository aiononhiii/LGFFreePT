//
//  LGFWeakProxy.h
//  LGFOCTool
//
//  Created by apple on 2018/6/26.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 用于保存弱对象的代理，它可以用来避免保留周期，例如NSTimer或CADisplayLink中的目标
/**
 示例代码:
 
 @implementation MyView {
 NSTimer *_timer;
 }
 
 - (void)initTimer {
 YYWeakProxy *proxy = [YYWeakProxy proxyWithTarget:self];
 _timer = [NSTimer timerWithTimeInterval:0.1 target:proxy selector:@selector(tick:) userInfo:nil repeats:YES];
 }
 
 - (void)tick:(NSTimer *)timer {...}
 @end
 */
@interface LGFWeakProxy : NSProxy
#pragma mark - 代理目标
@property (nullable, nonatomic, weak, readonly) id lgf_Target;

#pragma mark - 为目标创建一个新的弱代理
/**
 @param target 目标对象
 @return 一个新的代理对象
 */
- (instancetype)lgf_InitWithTarget:(id)target;

#pragma mark - 为目标创建一个新的弱代理
/**
 @param target 目标对象
 @return 一个新的代理对象
 */
+ (instancetype)lgf_ProxyWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
