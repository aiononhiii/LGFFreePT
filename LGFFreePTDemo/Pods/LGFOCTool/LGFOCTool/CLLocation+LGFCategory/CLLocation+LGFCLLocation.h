//
//  CLLocation+LGFCLLocation.h
//  LGFOCTool
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (LGFCLLocation)

#pragma mark - 地球坐标转火星坐标

- (CLLocation*)lgf_LocationMarsFromEarth;

#pragma mark - 火星坐标转百度坐标

- (CLLocation*)lgf_LocationBearPawFromMars;

#pragma mark - 百度坐标转火星坐标

- (CLLocation*)lgf_LocationMarsFromBearPaw;

@end
