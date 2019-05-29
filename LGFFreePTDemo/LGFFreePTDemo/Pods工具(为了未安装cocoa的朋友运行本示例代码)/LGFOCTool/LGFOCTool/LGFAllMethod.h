//
//  LGFAllSpecialMethod.h
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGFPch.h"

@interface LGFAllMethod : NSObject

#pragma mark - 视频view 转为全频播放 （修改约束实现，需传入指定约束）
/**
 @param view 视频view
 @param left 左边约束（需相对于视图控制器左边）
 @param right 右边约束（需相对于视图控制器右边）
 @param top 顶部约束
 @param height 高度约束
 */
+ (void)lgf_ToLayoutScreenView:(UIView *)view left:(NSLayoutConstraint *)left right:(NSLayoutConstraint *)right top:(NSLayoutConstraint *)top height:(NSLayoutConstraint *)height;
+ (void)lgf_ToLayoutUnScreenView:(UIView *)view left:(NSLayoutConstraint *)left right:(NSLayoutConstraint *)right top:(NSLayoutConstraint *)top height:(NSLayoutConstraint *)height;
+ (void)lgf_ToTransformScreenView:(UIView *)view;
+ (void)lgf_ToTransformUnScreenView:(UIView *)view;

#pragma mark - 版本更新提示
+ (void)lgf_AppNewVersionUpdate:(NSString *)appID isMandatory:(BOOL)isMandatory success:(void(^)(NSDictionary *appData, BOOL isMandatory))success failure:(void(^)(NSString *error))failure;

#pragma mark - 电话拨打
+ (void)lgf_CallPhoneWithPhoneNumber:(NSString *)phonestring;

#pragma mark - 限制小数点后两位
/**
 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return [textField CashKeyboardWithTextField:textField String:string Range:range];
 }
*/
+ (BOOL)lgf_DecimalPointInputSpecificationWithTextField:(UITextField *)textField String:(NSString *)string Range:(NSRange)range;
+ (BOOL)lgf_IntegerInputSpecificationWithTextField:(UITextField *)textField String:(NSString *)string Range:(NSRange)range;

#pragma mark - 保存图片到系统相册
+ (void)lgf_SaveImageToPhoto:(UIImage *)image saveSuccess:(void(^)(void))saveSuccess saveFailure:(void(^)(NSString *error))saveFailure;

#pragma mark - 根据网址字符串获取二维码图片
+ (UIImage *)lgf_GetCodeImageWithUrl:(NSString *)urlString imgWidth:(float)imgWidth;

#pragma mark - 取得范围内随机数
+ (int)lgf_GetRandomNumber:(int)from to:(int)to;

#pragma mark - 取得网速
+ (long long)lgf_GetInterfaceBytes;

#pragma mark - 当前网速
+ (BOOL)lgf_IsGoodNetSpeed;

#pragma mark - 生成规格sku数组
/**
 @param skuArr 返回的数组
 @param result 单个规格数组
 @param data 选中规格字典
 @param getSKUArray 返回 skuArr
 */
+ (void)SKU:(NSMutableArray *)skuArr result:(NSMutableArray *)result data:(NSArray *)data curr:(int)currIndex getSKUArray:(void(^)(NSMutableArray *array))getSKUArray;

#pragma mark - 滚动 scrollView 顶部 topView 自动隐藏
+ (void)lgf_ScrollHideForTopView:(UIView *)topView newHeight:(CGFloat)newHeight hideHeight:(CGFloat)hideHeight scrollView:(UIScrollView *)scrollView animateDuration:(NSTimeInterval)animateDuration;

#pragma mark - collectionview 长按cell排序方法
+ (void)lgf_SortCellWithGesture:(UILongPressGestureRecognizer *)sender collectionView:(UICollectionView *)collectionView fixedHorizontal:(BOOL)fixedHorizontal fixedVertical:(BOOL)fixedVertical;

#pragma mark - 根据PNG图片url获取PNG图片尺寸
+ (CGSize)lgf_GetPNGImageSizeWithUrl:(NSURL *)url;

#pragma mark - 根据GIF图片url获取GIF图片尺寸
+ (CGSize)lgf_GetGIFImageSizeWithUrl:(NSURL *)url;

#pragma mark - 根据JPG图片url获取JPG图片尺寸
+ (CGSize)lgf_GetJPGImageSizeWithUrl:(NSURL *)url;

#pragma mark - 返回可用系统内存容量
+ (CGFloat)lgf_GetDiskFreeSize;

#pragma mark - 切换第一响应者
+ (id)lgf_CurrentFirstResponder;

@end
