## LGFFreePT
可自由添加到指定位置的分页标控件

## 提示
* 本示例代码仅支持 9.0+, 本控件可以支持到 8.0+
* 稳定期过后我会出一个 swift4 的版本，如果有问题请反馈给我哈

## 制作目的
* 想要把分页标放在视图任意位置
* 把分页用的子控制器 Page 留给大家自己定义（传给 LGFFreePT 一个自己初始化的 UICollectionView，在自己的控制器里实现其代理，并在 cell 上添加子控制器就行）

## 部分效果展示
* 毛毛虫底部线对准title

![](https://upload-images.jianshu.io/upload_images/2857609-1db8aa8c93410d10.gif?imageMogr2/auto-orient/strip)

* 向下隐藏-底部线对准 title(自定义)

![](https://upload-images.jianshu.io/upload_images/2857609-46c396c7d99abab0.gif?imageMogr2/auto-orient/strip)

* 向上隐藏

![](https://upload-images.jianshu.io/upload_images/2857609-65ebbe94bedea5be.gif?imageMogr2/auto-orient/strip)

* 普通底部线对准title

![](https://upload-images.jianshu.io/upload_images/2857609-adb88914f96167a5.gif?imageMogr2/auto-orient/strip)

* 渐隐效果

![](https://upload-images.jianshu.io/upload_images/2857609-04c51bb9779ea427.gif?imageMogr2/auto-orient/strip)

* 模仿系统UISegment

![](https://upload-images.jianshu.io/upload_images/2857609-60cc01dde1dfdf12.gif?imageMogr2/auto-orient/strip)

* 指定index添加特殊title

![](https://upload-images.jianshu.io/upload_images/2857609-399c4ece9794bc2e.gif?imageMogr2/auto-orient/strip)

* 主副title

![](https://upload-images.jianshu.io/upload_images/2857609-ede5b8402fa3aaca.gif?imageMogr2/auto-orient/strip)

* 主副title放大缩小

![](https://upload-images.jianshu.io/upload_images/2857609-a46a248a8044238b.gif?imageMogr2/auto-orient/strip)

* 支付宝滚动更新title

![](https://upload-images.jianshu.io/upload_images/2857609-aa7f7cc85184b13e.gif?imageMogr2/auto-orient/strip)

* 淘宝首页

![](https://upload-images.jianshu.io/upload_images/2857609-ceac897a859ed839.gif?imageMogr2/auto-orient/strip)


*这只是冰山一角，还有近千种效果等待你的组合发现，详件Demo ([LGFFreePT](https://github.com/aiononhiii/LGFFreePT))

## 功能
* 实现了市面上大部分的效果，如果有新的需求请留言我

## 用法
* 由于用法比较多，代码写的比较自由，有必要开到 h 文件的我全开到 h 文件了，有些效果也需要自己组合摸索，部分我未实现的效果我做了注释和报异常处理，如果组合中碰到崩溃有可能是我设置的异常，请查看异常Log.（具体还是下载我的示例代码，我的示例代码里列了一些我自己组合的效果，都是一些市面上主流的效果）

## 使用方式
* pod 'LGFFreePT' 或者  [LGFFreePT](https://github.com/aiononhiii/LGFFreePT)
如果提示错误，请更新你的 cocoaPods ~>1.7.0

## 我的邮箱 - 452354033@qq.com

## 用了感觉不错的可以赠我一颗 github 星星，我将努力持续添加新的组合参数
## 有建议的也请在下方回复我，如果可行我会尽快采纳
