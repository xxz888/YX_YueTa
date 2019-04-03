//
//  YCLocationManager.h
//  ychat
//
//  Created by 孙俊 on 2018/1/2.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface YCLocationManager : NSObject

+ (instancetype)sharedManager;

- (void)takeSnapshotAtCoordinate:(CLLocationCoordinate2D)coordinate2D spanSize:(CGSize)size withCompletionBlock:(void (^)(UIImage *resultImage, NSInteger state))block;

- (void)reGeocodeFromCoordinate:(CLLocationCoordinate2D)coordinate2D completeCallback:(void (^)(AMapReGeocode *address, CLLocationCoordinate2D coordinate2D))completeCallback;

- (void)geocodeFromCityName:(NSString *)cityName completeCallback:(void (^)(AMapGeocode *address, CLLocationCoordinate2D coordinate2D))completeCallback;


- (void)getLocationNameAndAddressFromReGeocode:(AMapReGeocode *)reGeoCode name:(NSString **)name address:(NSString **)address;

- (UIImage *)takeCenterSnapshotFromMapView:(MAMapView *)mapView;

- (void)takeCenterSnapshotFromMapView:(MAMapView *)mapView withCompletionBlock:(void (^)(UIImage *resultImage, NSInteger state))block;

- (void)getCurrentLocationAndCompleteBlock:(void(^)(NSString *province, NSString *city, NSError *error))compleleBlock;

@end
