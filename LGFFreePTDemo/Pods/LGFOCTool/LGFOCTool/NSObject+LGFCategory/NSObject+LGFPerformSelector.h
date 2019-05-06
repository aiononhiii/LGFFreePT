//
//  NSObject+LGFPerformSelector.h
//  LGFOCTool
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LGFPerformSelector)

#pragma mark - 将指定的消息发送给接收方并返回消息的结果
/**
 
 @param sel    标识要发送的消息的选择器 如果选择器是
                NULL或无法识别，引发NSInvalidArgumentException
 
 @param ...    可变参数列表。参数类型必须对应于
                选择器的方法声明或可能发生的意外结果
                它不支持大于256字节的联合或结构
 
 @return       作为消息结果的对象
 
 @discussion   选择器的返回值将被包装为NSNumber或NSValue
                如果选择器的“返回类型”不是对象 它总是返回零
                如果选择器的“返回类型”是无效的
 
 示例代码:
 
 // 没有可变参数
 [view performSelectorWithArgs:@selector(removeFromSuperView)];
 
 // 可变参数不是对象
 [view performSelectorWithArgs:@selector(setCenter:), CGPointMake(0, 0)];
 
 // 执行并返回对象
 UIImage *image = [UIImage.class performSelectorWithArgs:@selector(imageWithData:scale:), data, 2.0];
 
 // 执行并返回包裹号码
 NSNumber *lengthValue = [@"hello" performSelectorWithArgs:@selector(length)];
 NSUInteger length = lengthValue.unsignedIntegerValue;
 
 // 执行并返回包装的结构
 NSValue *frameValue = [view performSelectorWithArgs:@selector(frame)];
 CGRect frame = frameValue.CGRectValue;
 */
- (nullable id)lgf_PerformSelectorWithArgs:(SEL)sel, ...;

#pragma mark - 在延迟后使用默认模式在当前线程上调用接收器的方法
/**
 
 @warning      它不能被以前的请求取消
 
 @param sel    标识要发送的消息的选择器 如果选择器是
                 NULL或无法识别，立即引发NSInvalidArgumentException
 
 @param delay  消息发送的最短时间 指定
                 延迟0不一定会导致选择器成为
                 立即执行 选择器仍在排队
                 线程的运行循环并尽快执行
 
 @param ...    可变参数列表 参数类型必须对应于
                 选择器的方法声明或可能发生的意外结果
                 它不支持大于256字节的联合或结构
 
 示例代码:
 
 // 没有可变参数
 [view performSelectorWithArgs:@selector(removeFromSuperView) afterDelay:2.0];
 
 // 可变参数不是对象
 [view performSelectorWithArgs:@selector(setCenter:), afterDelay:0, CGPointMake(0, 0)];
 */
- (void)lgf_PerformSelectorWithArgs:(SEL)sel afterDelay:(NSTimeInterval)delay, ...;

#pragma mark - 使用默认模式在主线程上调用接收器的方法
/**
 
 @param sel    标识要发送的消息的选择器 如果选择器是
                 NULL或无法识别，引发NSInvalidArgumentException
 
 @param wait   一个布尔值，指定当前线程是否阻塞直到
                 在指定的选择器在接收器上执行之后
                 指定的线程 指定YES阻止此线程; 除此以外，
                 指定NO以便立即返回此方法
 
 @param ...    可变参数列表 参数类型必须对应于
                 选择器的方法声明或可能发生的意外结果
                 它不支持大于256字节的联合或结构.
 
 @return       如果wait是YES，它返回的结果是对象
                 消息。 否则返回零;
 
 @discussion   选择器的返回值将被包装为NSNumber或NSValue
                 如果选择器的“返回类型”不是对象 它总是返回零
                 如果选择器的“返回类型”为空，或者wait为YES.
 
 示例代码:
 
 // 没有可变参数
 [view performSelectorWithArgsOnMainThread:@selector(removeFromSuperView), waitUntilDone:NO];
 
 // 可变参数不是对象
 [view performSelectorWithArgsOnMainThread:@selector(setCenter:), waitUntilDone:NO, CGPointMake(0, 0)];
 */
- (nullable id)lgf_PerformSelectorWithArgsOnMainThread:(SEL)sel waitUntilDone:(BOOL)wait, ...;

#pragma mark - 使用默认模式在指定的线程上调用接收器的方法
/**
 
 @param sel    标识要发送的消息的选择器 如果选择器是
                 NULL或无法识别，引发NSInvalidArgumentException
 
 @param thread 在其上执行选择器的线程
 
 @param wait   一个布尔值，指定当前线程是否阻塞直到
                 在指定的选择器在接收器上执行之后
                 指定的线程 指定YES阻止此线程; 除此以外，
                 指定NO以便立即返回此方法
 
 @param ...    可变参数列表 参数类型必须对应于
                 选择器的方法声明或可能发生的意外结果
                 它不支持大于256字节的联合或结构
 
 @return       如果wait是YES，它返回的结果是对象
                 消息。 否则返回零;
 
 @discussion   选择器的返回值将被包装为NSNumber或NSValue
                 如果选择器的“返回类型”不是对象 它总是返回零
                 如果选择器的“返回类型”为空，或者wait为YES
 
 示例代码:
 
 [view performSelectorWithArgs:@selector(removeFromSuperView) onThread:mainThread waitUntilDone:NO];
 
 [array  performSelectorWithArgs:@selector(sortUsingComparator:)
 onThread:backgroundThread
 waitUntilDone:NO, ^NSComparisonResult(NSNumber *num1, NSNumber *num2) {
 return [num2 compare:num2];
 }];
 */
- (nullable id)lgf_PerformSelectorWithArgs:(SEL)sel onThread:(NSThread *)thread waitUntilDone:(BOOL)wait, ...;

#pragma mark - 在新的后台线程上调用接收器的方法
/**
 
 @param sel    标识要发送的消息的选择器 如果选择器是
                 NULL或无法识别，引发NSInvalidArgumentException
 
 @param ...    可变参数列表 参数类型必须对应于
                 选择器的方法声明或可能发生的意外结果
                 它不支持大于256字节的联合或结构
 
 @discussion   这个方法在你的应用程序中创建一个新的线程
                 您的应用程序进入多线程模式，如果它尚未
                 由sel表示的方法必须设置线程环境
                 就像你在程序中的其他新线程一样
 
 示例代码:
 
 [array  performSelectorWithArgsInBackground:@selector(sortUsingComparator:),
 ^NSComparisonResult(NSNumber *num1, NSNumber *num2) {
 return [num2 compare:num2];
 }];
 */
- (void)lgf_PerformSelectorWithArgsInBackground:(SEL)sel, ...;

#pragma mark - 延迟后，在当前线程上调用接收方的方法
/**
 
 @warning     arc-performSelector-泄漏
 
 @param sel   标识要调用的方法的选择器 该方法应该
                没有显着的回报价值，应该没有争论
                如果选择器为NULL或无法识别，
                延迟后引发NSInvalidArgumentException
 
 @param delay 消息发送的最短时间 指定一个
                延迟0不一定会导致选择器被执行
                立即 选择器仍然在线程的运行循环中排队
                并尽快执行
 
 @discussion  此方法设置一个计时器以开启aSelector消息
                当前线程的运行循环 定时器配置为运行
                默认模式（NSDefaultRunLoopMode） 当定时器启动时，
                线程尝试从运行循环中退出消息
                执行选择器 如果运行循环正在运行，它会成功
                在默认模式下; 否则，定时器会一直等到运行循环
                处于默认模式
 */
- (void)lgf_PerformSelector:(SEL)sel afterDelay:(NSTimeInterval)delay;

@end

NS_ASSUME_NONNULL_END
