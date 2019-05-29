//
//  UITableView+LGFTableView.h
//  LGFOCTool
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Provides extensions for `UITableView`.
 */
@interface UITableView (LGFTableView)

#pragma mark - 执行一系列插入, 删除或选择行和的方法调用, 接收器的部分
/**
   @discussion 执行一系列插入，删除或选择的方法调用
               表格的行和部分。 如果需要，请调用此方法
               后续插入，删除和选择操作（for
               例如，cellForRowAtIndexPath：和indexPathsForVisibleRows）
               同时进行动画。
  
   @discussion 如果您不进行插入，删除和选择呼叫
               在该块内部，可能会变成行计数等表格属性
               无效。 您不应该在块内调用reloadData; 如果你
               在组内调用此方法，您将需要执行任何操作
               动画自己。
  
   @block 一个块组合了一系列方法调用。
 */
- (void)lgf_UpdateWithBlock:(void (^)(UITableView *tableView))block;

#pragma mark - 滚动接收器直到屏幕上的某一行或某一部分位置
/**
   @discussion            调用此方法不会导致委托
                          收到一个scrollViewDidScroll：消息, 正常情况下
                          通过程序调用的用户界面操作
  
   @param row             表中的行索引
  
   @param section         表中的节索引
  
   @param scrollPosition  一个常量, 用于标识中的相对位置
                          接收表格视图（顶部, 中部, 底部）为行时
                          滚动结束
  
   @param animated        是否带动画
 */
- (void)lgf_ScrollToRow:(NSUInteger)row inSection:(NSUInteger)section atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;

#pragma mark - 在接收器中插入一行，并为插入设置动画
/**
   @param row             表中的行索引
  
   @param section         表中的节索引
  
   @param animation       是否带动画
 */
- (void)lgf_InsertRow:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

#pragma mark - 使用特定的动画效果重新加载指定的行
/**
 @param row             表中的行索引
  
   @param section         表中的节索引
  
   @param animation       动画类型
 */
- (void)lgf_ReloadRow:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

#pragma mark - 删除该行并添加一个选项来删除动画
/**
   @param row             表中的行索引
  
   @param section         表中的节索引
  
   @param animation       动画类型
 */
- (void)lgf_DeleteRow:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

#pragma mark - 插入指定indexPath的行, 可以选择插入动画
/**
   @param indexPath       表示行索引和节的NSIndexPath对象
                          索引共同识别表格视图中的一行
  
   @param animation       动画类型
 */
- (void)lgf_InsertRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

#pragma mark - 使用特定的动画效果重新加载指定indexPath的行
/**
   @param indexPath       表示行索引和节的NSIndexPath对象
                          索引共同识别表格视图中的一行
  
   @param animation       动画类型
 */
- (void)lgf_ReloadRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

#pragma mark - 删除指定indexPath的行, 可以选择删除动画
/**
   @param indexPath       表示行索引和节的NSIndexPath对象
                          索引共同识别表格视图中的一行
  
   @param animation       动画类型
 */
- (void)lgf_DeleteRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

#pragma mark - 插入指定section的节, 可以选择插入动画
/**
   @param section       表示节索引对象
  
   @param animation       动画类型
 */
- (void)lgf_InsertSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

#pragma mark - 删除指定section的节, 可以选择删除动画
/**
   @param section       表示节索引对象
  
   @param animation       动画类型
 */
- (void)lgf_DeleteSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

#pragma mark - 重新加载指定section的节, 可以选择重新加载动画
/**
   @param section       表示节索引对象
  
   @param animation       动画类型
 */
- (void)lgf_ReloadSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

#pragma mark - 取消选择tableView中的所有行
/**
   @param animated        是否带动画
 */
- (void)lgf_ClearSelectedRowsAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
