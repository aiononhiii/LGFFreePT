//
//  UIGestureRecognizer+LGFBlockGestureRecognizer.h
//  LGFOCTool
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Provides extensions for `UIGestureRecognizer`.
 */
@interface UIGestureRecognizer (LGFBlockGestureRecognizer)

#pragma mark - 用 block 初始化已分配的手势识别器对象
/**
 @param block 一个处理由该动作识别的手势的block接收器, 用作手势触发回调, 传nil则无效
 @return 一个具体的UIGestureRecognizer子类的初始化实例 如果尝试初始化对象时发生错误则为nil
 */
- (instancetype)initWithActionLGFBlock:(void (^)(id sender))block;

#pragma mark - 将一个 block 添加到手势识别器对象, 用作手势触发回调
/**
 @param block 由操作消息调用的块, 传nil则无效
 */
- (void)lgf_AddActionBlock:(void (^)(id sender))block;

#pragma mark - 删除所有操作块
- (void)lgf_RemoveAllActionBlocks;

@end

NS_ASSUME_NONNULL_END

