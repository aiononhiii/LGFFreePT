//
//  UIControl+LGFControl.h
//  LGFOCTool
//
//  Created by apple on 2018/6/13.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (LGFControl)

#pragma mark - 删除特定事件（或事件）的所有目标和操作 来自内部调度表。
- (void)lgf_RemoveAllTargets;

#pragma mark - 添加或替换特定事件（或多个事件）的目标和操作 到一个内部调度表。
/**
   @param target         目标对象 - 也就是对象
                         动作消息被发送。 如果这是零，响应者
                         链是搜索一个愿意回应的对象
                         行动讯息。
  
   @param action         操作消息的选择器。 它不能为NULL。
  
   @param controlEvents  指定控制事件的位掩码
                         动作消息被发送。
 */
- (void)lgf_SetTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

#pragma mark - 将特定事件（或事件）的块添加到内部分派表中 它会引起对@区块的强烈引用。
/**
   @param block          被调用的块是动作消息
                         发送（不能为零）。 该块被保留。
  
   @param controlEvents  指定控制事件的位掩码
                         动作消息被发送。
 */
- (void)lgf_AddBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;

#pragma mark - 将特定事件（或事件）的块添加或替换为内部 调度表 它会引起对@区块的强烈引用。
/**
   @param block          被调用的块是动作消息
                         发送（不能为零）。 该块被保留。
  
   @param controlEvents  指定控制事件的位掩码
                         动作消息被发送。
 */
- (void)lgf_SetBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;

#pragma mark - 从内部删除特定事件（或多个事件）的所有块 调度表。
/**
   @param controlEvents  指定控制事件的位掩码
                         动作消息被发送。
 */
- (void)lgf_RemoveAllBlocksForControlEvents:(UIControlEvents)controlEvents;

@end

NS_ASSUME_NONNULL_END
