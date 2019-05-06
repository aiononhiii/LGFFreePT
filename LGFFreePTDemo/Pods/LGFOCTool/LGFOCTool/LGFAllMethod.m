//
//  LGFAllSpecialMethod.m
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import "LGFAllMethod.h"
#import "LGFOCTool.h"
#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>

@implementation LGFAllMethod

static CGFloat leftConstant;
static CGFloat rightConstant;
static CGFloat topConstant;
static CGFloat heightConstant;
+ (void)lgf_ToLayoutScreenView:(UIView *)view left:(NSLayoutConstraint *)left right:(NSLayoutConstraint *)right top:(NSLayoutConstraint *)top height:(NSLayoutConstraint *)height {
    if (CGAffineTransformEqualToTransform(view.transform, CGAffineTransformIdentity)) {
        leftConstant = left.constant;
        rightConstant = right.constant;
        topConstant = top.constant;
        heightConstant = height.constant;
        height.constant = lgf_ScreenWidth;
        left.constant = (lgf_ScreenWidth - lgf_ScreenHeight) / 2;
        right.constant = -(lgf_ScreenHeight - lgf_ScreenWidth + (lgf_ScreenWidth - lgf_ScreenHeight) / 2);
        UIView *topView = (UIView *)top.secondItem;
        top.constant = (lgf_ScreenHeight - lgf_ScreenWidth) / 2 - topView.lgf_y - topView.lgf_height;
        [UIView animateWithDuration:0.4 animations:^{
            [view.superview layoutIfNeeded];
            view.transform = CGAffineTransformRotate(view.transform, M_PI_2);
        }];
    }
}

+ (void)lgf_ToLayoutUnScreenView:(UIView *)view left:(NSLayoutConstraint *)left right:(NSLayoutConstraint *)right top:(NSLayoutConstraint *)top height:(NSLayoutConstraint *)height {
    if (!CGAffineTransformEqualToTransform(view.transform, CGAffineTransformIdentity)) {
        left.constant = leftConstant;
        right.constant = rightConstant;
        top.constant = topConstant;
        height.constant = heightConstant;
        [UIView animateWithDuration:0.4 animations:^{
            view.transform = CGAffineTransformIdentity;
            [view.superview layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    }
}

+ (void)lgf_ToTransformScreenView:(UIView *)view {
    if (CGAffineTransformEqualToTransform(view.transform, CGAffineTransformIdentity)) {
        [UIView animateWithDuration:0.5 animations:^{
            view.transform = CGAffineTransformTranslate(view.transform, 0, (lgf_ScreenHeight - lgf_ScreenWidth) / 2 +(view.lgf_width - 200) / 2 - view.lgf_y);
            view.transform = CGAffineTransformScale(view.transform, view.lgf_width / 200, lgf_ScreenHeight / lgf_ScreenWidth);
            view.transform = CGAffineTransformRotate(view.transform, M_PI_2);
        }];
    }
}

+ (void)lgf_ToTransformUnScreenView:(UIView *)view {
    if (!CGAffineTransformEqualToTransform(view.transform, CGAffineTransformIdentity)) {
        [UIView animateWithDuration:0.5 animations:^{
            view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
        }];
    }
}

+ (void)lgf_CallPhoneWithPhoneNumber:(NSString *)phonestring {
    if (lgf_IOSSystemVersion(10.0)) {
        NSMutableString * str= [[NSMutableString alloc] initWithFormat:@"tel:%@", phonestring];
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *URL = [NSURL URLWithString:str];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"
        [application openURL:URL options:@{} completionHandler:^(BOOL success) {
            //OpenSuccess=选择 呼叫 为 1  选择 取消 为0
            NSLog(@"OpenSuccess=%d",success);
        }];
#pragma clang diagnostic pop
    } else {
        NSString *telephoneNumber = phonestring;
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@", telephoneNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

+ (BOOL)lgf_IntegerInputSpecificationWithTextField:(UITextField *)textField String:(NSString *)string Range:(NSRange)range {
    if (string.length > 0) {
        unichar single = [string characterAtIndex:0];
        if ([textField.text isEqualToString:@"0"]) {
            textField.text = string;
            return NO;
        }
        if (!((single >= '0' && single <= '9') || single == '.')){
            return NO;
        }
    }
    return YES;
}

+ (BOOL)lgf_DecimalPointInputSpecificationWithTextField:(UITextField *)textField String:(NSString *)string Range:(NSRange)range {
    BOOL isHaveDian;
    if ([textField.text containsString:@"."]) {
        isHaveDian = YES;
    }else{
        isHaveDian = NO;
    }
    if (string.length > 0) {
        unichar single = [string characterAtIndex:0];
        if (!((single >= '0' && single <= '9') || single == '.')){
            return NO;
        }
        // 只能有一个小数点
        if (isHaveDian && single == '.') {
            return NO;
        }
        // 如果第一位是.则前面加上0.
        if ((textField.text.length == 0) && (single == '.')) {
            textField.text = @"0";
        }
        // 如果第一位是0则后面必须输入点，否则不能输入。
        if ([textField.text hasPrefix:@"0"]) {
            if (textField.text.length > 1) {
                NSString *secondStr = [textField.text substringWithRange:NSMakeRange(1, 1)];
                if (![secondStr isEqualToString:@"."]) {
                    return NO;
                }
            }else{
                if (![string isEqualToString:@"."]) {
                    return NO;
                }
            }
        }
        // 小数点后最多能输入两位
        if (isHaveDian) {
            NSRange ran = [textField.text rangeOfString:@"."];
            if (range.location > ran.location) {
                if ([textField.text pathExtension].length > 1) {
                    return NO;
                }
            }
        }
    }
    return YES;
}

+ (void)lgf_SaveImageToPhoto:(UIImage *)image saveSuccess:(void(^)(void))saveSuccess saveFailure:(void(^)(NSString *error))saveFailure {
    [LGFAllPermissions lgf_GetPhotoAutoPermission:^(BOOL isHave) {
        if (isHave) {
            // PHAsset : 一个资源, 比如一张图片\一段视频
            // PHAssetCollection : 一个相簿
            // PHAsset的标识, 利用这个标识可以找到对应的PHAsset对象(图片对象)
            __block NSString *assetLocalIdentifier = nil;
            // 如果想对"相册"进行修改(增删改), 那么修改代码必须放在[PHPhotoLibrary sharedPhotoLibrary]的performChanges方法的block中
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                // 1.保存图片A到"相机胶卷"中
                // 创建图片的请求
                if (@available(iOS 9.0, *)) {
                    assetLocalIdentifier = [PHAssetCreationRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        lgf_HaveBlock(saveFailure, @"保存失败，系统版本过低");
                    });
                }
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (success == NO) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        lgf_HaveBlock(saveFailure, @"因为系统原因, 无法访问相册");
                    });
                    return;
                }
                // 2.获得相簿
                PHAssetCollection *createdAssetCollection = [self createdAssetCollection];
                if (createdAssetCollection == nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        lgf_HaveBlock(saveFailure, @"因为系统原因, 无法访问相册");
                    });
                    return;
                }
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                    // 3.添加"相机胶卷"中的图片A到"相簿"D中
                    // 获得图片
                    PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil].lastObject;
                    // 添加图片到相簿中的请求
                    PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];
                    // 添加图片到相簿
                    [request addAssets:@[asset]];
                } completionHandler:^(BOOL success, NSError * _Nullable error) {
                    if (success == NO) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            lgf_HaveBlock(saveFailure, @"保存失败");
                        });
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            lgf_HaveBlock(saveSuccess);
                        });
                    }
                }];
            }];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                lgf_HaveBlock(saveFailure, @"请进入手机设置，为我们打开保存相册的权限");
            });
        }
    }];
}

+ (PHAssetCollection *)createdAssetCollection{
    // 从已存在相簿中查找这个应用对应的相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:@"我的相册"]) {
            return assetCollection;
        }
    }
    // 没有找到对应的相簿, 得创建新的相簿
    // 错误信息
    NSError *error = nil;
    
    // PHAssetCollection的标识, 利用这个标识可以找到对应的PHAssetCollection对象(相簿对象)
    __block NSString *assetCollectionLocalIdentifier = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 创建相簿的请求
        assetCollectionLocalIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:@"我的相册"].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    // 如果有错误信息
    if (error) return nil;
    
    // 获得刚才创建的相簿
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionLocalIdentifier] options:nil].lastObject;
}


+ (UIImage *)lgf_GetCodeImageWithUrl:(NSString *)urlString imgWidth:(float)imgWidth {
    //创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //过滤器恢复默认
    [filter setDefaults];
    //给过滤器添加数据
    NSString *string = urlString;
    //将NSString格式转化成NSData格式
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [filter setValue:data forKeyPath:@"inputMessage"];
    //获取二维码过滤器生成的二维码
    CIImage *image = [filter outputImage];
    //此步骤将二维码生成的图片清晰化
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(imgWidth/CGRectGetWidth(extent), imgWidth/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    //将获取到的二维码添加到imageview上
    return [UIImage imageWithCGImage:scaledImage];
}

+ (int)lgf_GetRandomNumber:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from + 1)));
}

+ (BOOL)lgf_IsGoodNetSpeed {
    CGFloat bity = [LGFAllMethod lgf_GetInterfaceBytes];
    CGFloat speed = bity/1000;
    if (speed < 100) {
        NSString *string = @"您当前网速低于【100kb/s】,暂时不能开启直播；请先设置好您的网络要求";
        [lgf_Application.keyWindow lgf_ShowMessage:string animated:YES completion:nil];
        return NO;
    }
    return YES;
}

+ (long long)lgf_GetInterfaceBytes {
    struct ifaddrs *ifa_list = 0, *ifa;
    if (getifaddrs(&ifa_list) == -1) {
        return 0;
    }
    uint32_t iBytes = 0;
    uint32_t oBytes = 0;
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next) {
        if (AF_LINK != ifa->ifa_addr->sa_family)
            continue;
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            continue;
        if (ifa->ifa_data == 0)
            continue;
        /* Not a loopback device. */
        if (strncmp(ifa->ifa_name, "lo", 2)) {
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            iBytes += if_data->ifi_ibytes;
            oBytes += if_data->ifi_obytes;
        }
    }
    freeifaddrs(ifa_list);
    NSLog(@"\n[getInterfaceBytes-Total]%d,%d",iBytes,oBytes);
    return iBytes + oBytes;
}

+ (void)lgf_ScrollHideForTopView:(UIView *)topView newHeight:(CGFloat)newHeight hideHeight:(CGFloat)hideHeight scrollView:(UIScrollView *)scrollView animateDuration:(NSTimeInterval)animateDuration {
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    [UIView animateWithDuration:animateDuration animations:^{
        if (translation.y > 0) {
            if (topView.transform.ty == -hideHeight) {
                topView.transform = CGAffineTransformIdentity;
            }
        } else if (translation.y < 0) {
            if ((scrollView.contentOffset.y + newHeight) > hideHeight) {
                if (topView.transform.ty == 0) {
                    topView.transform = CGAffineTransformMakeTranslation(0, -hideHeight);
                }
            } else {
                if (topView.transform.ty == -hideHeight) {
                    topView.transform = CGAffineTransformIdentity;
                }
            }
        }
    }];
}

// data: @[@[@{@"key":@"尺码",@"name",@"L"},@{@"key":@"尺码",@"name",@"M"}], @[@{@"key":@"颜色",@"name",@"黑色"},@{@"key":@"颜色",@"name",@"红色"}]]
+ (void)SKU:(NSMutableArray *)skuArr result:(NSMutableArray *)result data:(NSArray *)data curr:(int)currIndex getSKUArray:(void(^)(NSMutableArray *array))getSKUArray {
    if (currIndex == data.count) {
        [skuArr addObject:[result mutableCopy]];
        __block NSInteger all = 1;
        [data enumerateObjectsUsingBlock:^(NSArray *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            all = all * (obj.count == 0 ? 1 : obj.count);
        }];
        if (skuArr.count == all) {
            getSKUArray(skuArr);
            return;
        }
        [result removeLastObject];
    } else {
        NSArray* array = [data objectAtIndex:currIndex];
        for (int i = 0; i < array.count; ++i) {
            [result addObject:[array objectAtIndex:i][@"name"]];
            [self SKU:skuArr result:result data:data curr:currIndex+1 getSKUArray:getSKUArray];
            if ((i+1 == array.count) && (currIndex-1>=0)) {
                [result removeObjectAtIndex:currIndex-1];
            }
        }
    }
}

static UICollectionViewCell *lgf_MoveCell;

+ (void)lgf_SortCellWithGesture:(UILongPressGestureRecognizer *)sender collectionView:(UICollectionView *)collectionView fixedHorizontal:(BOOL)fixedHorizontal fixedVertical:(BOOL)fixedVertical {
    CGPoint point = [sender locationInView:collectionView];
    NSIndexPath *indexPath;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            indexPath = [collectionView indexPathForItemAtPoint:point];
            lgf_MoveCell = [collectionView cellForItemAtIndexPath:indexPath];
            lgf_MoveCell.alpha = 0.7;
            for (UIView *view in lgf_MoveCell.subviews) {
                view.alpha = 0.7;
            }
            if (!indexPath) { break; }
            [collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            break;
        case UIGestureRecognizerStateChanged:
            [collectionView updateInteractiveMovementTargetPosition:CGPointMake(fixedHorizontal ? MIN(MAX((lgf_MoveCell.lgf_width / 2), point.x), collectionView.contentSize.width - (lgf_MoveCell.lgf_width / 2)) : point.x, fixedVertical ? MIN(MAX((lgf_MoveCell.lgf_height / 2), point.y), collectionView.contentSize.height - (lgf_MoveCell.lgf_height / 2)) : point.y)];
            break;
        case UIGestureRecognizerStateEnded:
            lgf_MoveCell.alpha = 1.0;
            for (UIView *view in lgf_MoveCell.subviews) {
                view.alpha = 1.0;
            }
            [collectionView endInteractiveMovement];
            break;
        default:
            lgf_MoveCell.alpha = 1.0;
            for (UIView *view in lgf_MoveCell.subviews) {
                view.alpha = 1.0;
            }
            [collectionView cancelInteractiveMovement];
            break;
    }
#pragma clang diagnostic pop
}

#pragma mark - 根据PNG图片url获取PNG图片尺寸
+ (CGSize)lgf_GetPNGImageSizeWithUrl:(NSURL *)url {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data.length == 8) {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

#pragma mark - 根据GIF图片url获取GIF图片尺寸
+ (CGSize)lgf_GetGIFImageSizeWithUrl:(NSURL *)url {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

#pragma mark - 根据JPG图片url获取JPG图片尺寸
+ (CGSize)lgf_GetJPGImageSizeWithUrl:(NSURL *)url {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}

#pragma mark - 返回可用系统内存容量
+ (CGFloat)lgf_GetDiskFreeSize {
    NSDictionary *systemAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    CGFloat diskFreeSize = [[systemAttributes objectForKey:@"NSFileSystemFreeSize"] floatValue];
    return diskFreeSize;
}

#pragma mark - 切换第一响应者
static __weak id lgf_CurrentFirstResponder;

+ (id)lgf_CurrentFirstResponder {
    lgf_CurrentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(lgf_FindFirstResponder:)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
    return lgf_CurrentFirstResponder;
}

- (void)lgf_FindFirstResponder:(id)sender {
    lgf_CurrentFirstResponder = self;
}

#pragma mark - 版本更新提示
+ (void)lgf_AppNewVersionUpdate:(NSString *)appID isMandatory:(BOOL)isMandatory success:(void(^)(NSDictionary *appData, BOOL isMandatory))success failure:(void(^)(NSString *error))failure {
    if (!isMandatory) {
        if(![LGFAllMethod lgf_JudgeNeedVersionUpdate]) {
            return;
        }
    }
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = infoDict[@"CFBundleShortVersionString"];
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/CN/lookup?id=%@", appID];
    [[LGFNetwork lgf_Once] lgf_POST:urlString parameters:@{} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *resultsDict = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *sourceArray = resultsDict[@"results"];
        if (sourceArray.count >= 1) {
            //AppStore内最新App的版本信息
            NSDictionary *sourceDict = sourceArray[0];
            NSString *storeVersion = sourceDict[@"version"];
            if ([LGFAllMethod lgf_JudgeStoreVersion:storeVersion withAppVersion:appVersion]) {
                // 提示更新版本
                lgf_HaveBlock(success, sourceDict, isMandatory);
            } else {
                lgf_HaveBlock(failure, @"当前为最新版本");
            }
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        lgf_HaveBlock(failure, error.domain);
    }];
}

//每天进行一次版本判断(非强制更新时)
+ (BOOL)lgf_JudgeNeedVersionUpdate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone systemTimeZone];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSString *currentDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"QTCurrentDate"];
    if ([currentDate isEqualToString:dateString]) {
        return NO;
    }
    [[NSUserDefaults standardUserDefaults] setObject:dateString forKey:@"QTCurrentDate"];
    return YES;
}

//判断当前app版本和AppStore最新app版本大小
+ (BOOL)lgf_JudgeStoreVersion:(NSString *)storeVersion withAppVersion:(NSString *)appVersion {
    NSString *storeArrayVersion = [[storeVersion componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]] componentsJoinedByString:@""];
    NSString *appArrayVersion = [[appVersion componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]] componentsJoinedByString:@""];
    if ([storeArrayVersion integerValue] > [appArrayVersion integerValue]) {
        return YES;
    } else {
        return NO;
    }
}

@end
