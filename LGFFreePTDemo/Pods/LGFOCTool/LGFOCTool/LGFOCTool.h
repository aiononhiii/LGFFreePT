//
//  LGFOCTool.h
//  LGFOCTool
//
//  Created by apple on 2017/4/28.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#ifndef LGFOCTool_h
#define LGFOCTool_h

// 宏集合
#import "LGFPch.h"

// 所有特殊方法
#import "LGFAllMethod.h"

// 所有权限配置
#import "LGFAllPermissions.h"

// 基于AFN的网络请求封装
#import "LGFReqest.h"

// SDWebImage
#import "UIImageView+WebCache.h"

//****************************** 自定义控件 *******************************
// 倒计时按钮 用于发送验证码
#import "LGFCountDownButton.h"
// 优化后的定时器
#import "LGFTimer.h"
// 瀑布流Layout
#import "LGFWaterLayout.h"
// 从相册选取图片
#import "LGFGetPhoto.h"
// 显示当前 FPS 的Label
#import "LGFFPSLabel.h"
// 自定义提示框
#import "LGFAlertView.h"
#import "LGFImageAlertView.h"
// 自定义菜单
#import "LGFPopMenu.h"
// 自定义 cell
#import "LGFImageTitleCell.h"
#import "LGFImageCell.h"
// 点击果冻按钮
#import "LGFClickJumpButton.h"
// 网页顶部加载条
#import "LGFWebProgress.h"
// LGFRefresh 封装
#import "UIScrollView+LGFRefresh.h"
// 返回按钮
#import "LGFBackButton.h"
// 表情键盘
#import "LGFEmoji.h"
//******************************** 分类 **********************************
//------------------ NSString 分类集合 -----------------
#import "NSString+LGFString.h"
// NSString 加密
#import "NSString+LGFHash.h"
// 字符串拼音处理
#import "NSString+LGFPinyin.h"
// 正则判断 手机号邮箱等等
#import "NSString+LGFRegex.h"
// 删除字符串中的 Emoji
#import "NSString+LGFRemoveEmoji.h"
// 取得字符串宽高
#import "NSString+LGFTextSize.h"
// js html 字符串处理
#import "NSString+LGFTrims.h"
// NSString 编码解码
#import "NSString+LGFEncodeDecode.h"
// NSString NSNumber兼容
#import "NSString+LGFNSNumberCompatible.h"
//------------------ NSDate 分类集合 --------------------
#import "NSDate+LGFDate.h"
//------------------ NSData 分类集合 --------------------
#import "NSData+LGFData.h"
// NSData 压缩解压
#import "NSData+LGFInflateDeflate.h"
// NSData 编码解码
#import "NSData+LGFEncodeDecode.h"
// NSData AES加密解密
#import "NSData+LGFEncryptDecrypt.h"
// NSData 加密
#import "NSData+LGFHash.h"
//------------------ UIColor 分类集合 -------------------
#import "UIColor+LGFColor.h"
// 获取渐变色
#import "UIColor+LGFGradient.h"
//------------------ UILabel 分类集合 ----------------
#import "UILabel+LGFLable.h"
//------------------ UITextView 分类集合 ----------------
#import "UITextView+LGFTextView.h"
//------------------ UITextField 分类集合 ---------------
#import "UITextField+LGFTextField.h"
//------------------ UIImage 分类集合 -------------------
#import "UIImage+LGFImage.h"
// 颜色转图片
#import "UIImage+LGFColorImage.h"
// 加载PDF图片
#import "UIImage+LGFPDFImage.h"
//------------------ UIImageView 分类集合 ---------------
#import "UIImageView+LGFImageView.h"
//------------------ UIViewController 分类集合 ----------
#import "UIViewController+LGFViewController.h"
// UIViewController 生命周期Log输出
#import "UIViewController+LGFVCLog.h"
// UIViewController 顶部提示条
#import "UIView+LGFTopBarMessage.h"
//------------------ UIView 分类集合 --------------------
#import "UIView+LGFExtension.h"
// 获取当前view的ViewController
// 为故事版添加可勾选属性
#import "UIView+LGFGSView.h"
// 添加旋转动画 可断点暂停
#import "UIView+LGFRotateAnimation.h"
// Toast提示
#import "UIView+LGFToast.h"
// 设置任意圆角
#import "UIView+LGFCornerRadius.h"
// 简易添加手势
#import "UIView+LGFAddGestureRecognizer.h"
//------------------ UIButton 分类集合 ------------------
// 设置按钮图片的位置
#import "UIButton+LGFImagePosition.h"
// 按钮加载中句话显示
#import "UIButton+LGFIndicator.h"
//------------------ UIWindow 分类集合 ------------------
// 取得当前显示的 视图控制器
#import "UIWindow+LGFTopVC.h"
//------------------ UIDevice 分类集合 ------------------
// 获取各种设备信息
#import "UIDevice+LGFDevice.h"
//------------------ NSObject 分类集合 ------------------
// KVO Block回调
#import "NSObject+LGFKVOBlocks.h"
// 动态获取 类属性列表 方法列表 等等等
#import "NSObject+LGFReflection.h"
// 动态方法添加／替换／判断等等
#import "NSObject+LGFRuntime.h"
// 动态属性对象添加
#import "NSObject+LGFAssociateValue.h"
#import "NSObject+LGFPerformSelector.h"
//------------------ NSDictionary 分类集合 ---------------
// 字典转josn字符串
#import "NSDictionary+LGFToJSONString.h"
#import "NSDictionary+LGFDictionary.h"
#import "NSMutableDictionary+LGFMutableDictionary.h"
//------------------ NSArray 分类集合 --------------------
// 数组转josn字符串
#import "NSArray+LGFToJSONString.h"
#import "NSMutableArray+LGFMutableArray.h"
#import "NSArray+LGFArray.h"
//------------------ UIWebView 分类集合 ------------------
// UIWebView 清空 Cookies
#import "UIWebView+LGFClearCookies.h"
//------------------ CLLocation 分类集合 -----------------
// 火星坐标转换
#import "CLLocation+LGFCLLocation.h"
//------------------ UITabBarController 分类集合 ---------
// 动画显示隐藏 TabBar
#import "UITabBarController+LGFTabBarAnimatedHidden.h"
//------------------ NSKeyedUnarchiver 分类集合 ---------
// NSKeyedUnarchiver 解档引用回调异常
#import "NSKeyedUnarchiver+LGFKeyedUnarchiver.h"
//------------------ NSNotificationCenter 分类集合 ---------
// 在主线程上发送通知 如果当前线程是主线程，则通知被同步发布 否则 发布为异步
#import "NSNotificationCenter+OnMainThread.h"
//------------------ NSTimer 分类集合 ---------
// NSTimer Block 触发
#import "NSTimer+LGFBlockTimer.h"
//------------------ UIApplication 分类集合 ---------
#import "UIApplication+LGFApplication.h"
//------------------ UIFont 分类集合 ---------
#import "UIFont+LGFFont.h"
//------------------ UIBezierPath 分类集合 ---------
// 文字转 UIBezierPath
#import "UIBezierPath+LGFBezierPath.h"
//------------------ UIGestureRecognizer 分类集合 ---------
// UIGestureRecognizer Block 触发
#import "UIGestureRecognizer+LGFBlockGestureRecognizer.h"
//------------------ UITableView 分类集合 ---------
#import "UITableView+LGFTableView.h"
//------------------ UIScrollView 分类集合 ---------
#import "UIScrollView+LGFScrollView.h"
//------------------ UIScreen 分类集合 ---------
#import "UIScreen+LGFScreen.h"
//------------------ UIControl 分类集合 ---------
#import "UIControl+LGFControl.h"

#endif /* LGFOCTool_h */
