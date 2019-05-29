//
//  LGFGetPhoto.m
//  LGFOCTool
//
//  Created by apple on 2018/6/13.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "LGFGetPhoto.h"

@interface LGFGetPhoto () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>
@property (copy, nonatomic) lgf_ReturnImage lgf_ReturnImage;
@property (weak, nonatomic) UIViewController *lgf_SVC;
@end

@implementation LGFGetPhoto

lgf_AllocOnceForM(LGFGetPhoto);

- (void)lgf_GetPhoto:(UIViewController *)SVC type:(LGFGetPhotoType)type returnImage:(lgf_ReturnImage)returnImage {
    self.lgf_ReturnImage = returnImage;
    if (type == LGFPhoto) {
        [self GoToPhotos:SVC];
    } else if (type == LGFCamera) {
        [self GoToCamera:SVC];
    }
}

/**
 去相册取图片
 */
- (void)GoToPhotos:(UIViewController *)SVC {
    [LGFAllPermissions lgf_GetPhotoAutoPermission:^(BOOL isHave) {
        if (isHave) {
            UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
            imagePC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePC.delegate = self;
            imagePC.allowsEditing = YES;
            [SVC presentViewController:imagePC animated:YES completion:nil];
        } else {
            [LGFAllPermissions lgf_GoSystemSettingPermission];
        }
    }];
    
}

/**
 去相机拍摄图片
 */
- (void)GoToCamera:(UIViewController *)SVC {
    [LGFAllPermissions lgf_GetCameraPermission:^(BOOL isHave) {
        if (isHave) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
                imagePC.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePC.delegate = self;
                imagePC.allowsEditing = YES;
                [SVC presentViewController:imagePC animated:YES completion:nil];
            } else {
                [SVC.view lgf_ShowMessage:@"摄像头故障！" animated:YES completion:nil];
            }
        } else {
            [LGFAllPermissions lgf_GoSystemSettingPermission];
        }
    }];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    lgf_HaveBlock(self.lgf_ReturnImage, image);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
