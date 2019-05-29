//
//  CLLocation+LGFCLLocation.m
//  LGFOCTool
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "CLLocation+LGFCLLocation.h"

void lgf_transform_earth_2_mars(double lat, double lng, double* tarLat, double* tarLng);
void lgf_transform_mars_2_bear_paw(double lat, double lng, double* tarLat, double* tarLng);
void lgf_transform_bear_paw_2_mars(double lat, double lng, double* tarLat, double* tarLng);

@implementation CLLocation (LGFCLLocation)

- (CLLocation*)lgf_LocationMarsFromEarth {
    double lat = 0.0;
    double lng = 0.0;
    lgf_transform_earth_2_mars(self.coordinate.latitude, self.coordinate.longitude, &lat, &lng);
    return [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(lat, lng)
                                         altitude:self.altitude
                               horizontalAccuracy:self.horizontalAccuracy
                                 verticalAccuracy:self.verticalAccuracy
                                           course:self.course
                                            speed:self.speed
                                        timestamp:self.timestamp];
}

- (CLLocation*)lgf_LocationBearPawFromMars {
    double lat = 0.0;
    double lng = 0.0;
    lgf_transform_mars_2_bear_paw(self.coordinate.latitude, self.coordinate.longitude, &lat, &lng);
    return [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(lat, lng)
                                         altitude:self.altitude
                               horizontalAccuracy:self.horizontalAccuracy
                                 verticalAccuracy:self.verticalAccuracy
                                           course:self.course
                                            speed:self.speed
                                        timestamp:self.timestamp];
}

- (CLLocation*)lgf_LocationMarsFromBearPaw {
    double lat = 0.0;
    double lng = 0.0;
    lgf_transform_bear_paw_2_mars(self.coordinate.latitude, self.coordinate.longitude, &lat, &lng);
    return [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(lat, lng)
                                         altitude:self.altitude
                               horizontalAccuracy:self.horizontalAccuracy
                                 verticalAccuracy:self.verticalAccuracy
                                           course:self.course
                                            speed:self.speed
                                        timestamp:self.timestamp];
}

@end


const double lgf_a = 6378245.0;
const double lgf_ee = 0.00669342162296594323;

bool lgf_transform_sino_out_china(double lat, double lon) {
    if (lon < 72.004 || lon > 137.8347)
        return true;
    if (lat < 0.8293 || lat > 55.8271)
        return true;
    return false;
}

double lgf_transform_earth_2_mars_lat(double x, double y) {
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * M_PI) + 40.0 * sin(y / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * M_PI) + 320 * sin(y * M_PI / 30.0)) * 2.0 / 3.0;
    return ret;
}

double lgf_transform_earth_2_mars_lng(double x, double y) {
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * M_PI) + 40.0 * sin(x / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * M_PI) + 300.0 * sin(x / 30.0 * M_PI)) * 2.0 / 3.0;
    return ret;
}

void lgf_transform_earth_2_mars(double lat, double lng, double* tarLat, double* tarLng) {
    if (lgf_transform_sino_out_china(lat, lng)) {
        *tarLat = lat;
        *tarLng = lng;
        return;
    }
    double dLat = lgf_transform_earth_2_mars_lat(lng - 105.0, lat - 35.0);
    double dLon = lgf_transform_earth_2_mars_lng(lng - 105.0, lat - 35.0);
    double radLat = lat / 180.0 * M_PI;
    double magic = sin(radLat);
    magic = 1 - lgf_ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((lgf_a * (1 - lgf_ee)) / (magic * sqrtMagic) * M_PI);
    dLon = (dLon * 180.0) / (lgf_a / sqrtMagic * cos(radLat) * M_PI);
    *tarLat = lat + dLat;
    *tarLng = lng + dLon;
}

const double lgf_pi = M_PI * 3000.0 / 180.0;

void lgf_transform_mars_2_bear_paw(double gg_lat, double gg_lon, double *bd_lat, double *bd_lon) {
    double x = gg_lon, y = gg_lat;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * lgf_pi);
    double theta = atan2(y, x) + 0.000003 * cos(x * lgf_pi);
    *bd_lon = z * cos(theta) + 0.0065;
    *bd_lat = z * sin(theta) + 0.006;
}

void lgf_transform_bear_paw_2_mars(double bd_lat, double bd_lon, double *gg_lat, double *gg_lon) {
    double x = bd_lon - 0.0065, y = bd_lat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * lgf_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * lgf_pi);
    *gg_lon = z * cos(theta);
    *gg_lat = z * sin(theta);
}
