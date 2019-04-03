//
//  YCLocationManager.m
//  ychat
//
//  Created by 孙俊 on 2018/1/2.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "YCLocationManager.h"
@import AddressBook;

#define SNAPSHOT_SPAN_WIDTH 263
#define SNAPSHOT_SPAN_HEIGHT 150
#define LOCATION_EMPTY_ADDRESS             @"[位置]"
#define LOCATION_EMPTY_NAME                @"[位置]"
#define LOCATION_UNKNOWE_ADDRESS           @"[未知位置]"
#define LOCATION_UNKNOWE_NAME              @"[未知位置]"
#define LOCATION_AUTHORIZATION_DENIED_TEXT @"无法获取你的位置信息。\n请到手机系统的[设置]->[隐私]->[定位服务]中打开定位服务,并允许微信使用定位服务。"

typedef void (^ReGeocodeSearchCompleteBlock)(AMapReGeocode *address, CLLocationCoordinate2D coordinate2D);
typedef void (^GeocodeSearchCompleteBlock)(AMapGeocode *address, CLLocationCoordinate2D coordinate2D);


@interface _LLInternal_Data_LLLocationManager : NSObject

//@property (nonatomic) NSInteger index;
@property (nonatomic) AMapReGeocodeSearchRequest *request;
@property (nonatomic) ReGeocodeSearchCompleteBlock completeCallback;

@property (nonatomic) AMapGeocodeSearchRequest *geoRequest;
@property (nonatomic) GeocodeSearchCompleteBlock geoCompleteCallback;

@end

@implementation _LLInternal_Data_LLLocationManager


@end

@interface YCLocationManager ()<AMapSearchDelegate,AMapLocationManagerDelegate>

@property (nonatomic) MAMapView *mapView;

@property (nonatomic) AMapSearchAPI *reGeocodeSearch;

@property (nonatomic, strong) AMapLocationManager *locationManager;

@property (nonatomic) NSMutableArray<_LLInternal_Data_LLLocationManager *> *allRequests;

@end

@implementation YCLocationManager
+ (instancetype)sharedManager {
    static YCLocationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YCLocationManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)dealloc {
    _reGeocodeSearch.delegate = nil;
}

- (MAMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:kMainScreen_Bounds];
        //    _mapView.delegate = self;
        _mapView.mapType = MAMapTypeStandard;
        _mapView.userTrackingMode = MAUserTrackingModeNone;
        
        _mapView.zoomEnabled = YES;
        _mapView.minZoomLevel = 4;
        _mapView.maxZoomLevel = 19;
        
        _mapView.logoCenter = CGPointMake(-MAXFLOAT, -MAXFLOAT);
        _mapView.scrollEnabled = NO;
        _mapView.showsCompass = NO;
        _mapView.showsScale = NO;
    }
    
    return _mapView;
}

- (AMapSearchAPI *)reGeocodeSearch {
    if (!_reGeocodeSearch) {
        _allRequests = [NSMutableArray array];
        _reGeocodeSearch = [[AMapSearchAPI alloc] init];
        _reGeocodeSearch.delegate = self;
    }
    return _reGeocodeSearch;
}

- (AMapLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
        [_locationManager setDelegate:self];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [_locationManager setPausesLocationUpdatesAutomatically:NO];
        _locationManager.locationTimeout = 10;
        //   逆地理请求超时时间，最低2s，此处设置为10s
        _locationManager.reGeocodeTimeout = 10;
    }
    return _locationManager;
}

#pragma mark - 地图截图
- (void)takeSnapshotAtCoordinate:(CLLocationCoordinate2D)coordinate2D spanSize:(CGSize)size withCompletionBlock:(void (^)(UIImage *resultImage, NSInteger state))block
{
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    [self.mapView setCenterCoordinate:coordinate2D animated:NO];
    
    [_mapView takeSnapshotInRect:frame withCompletionBlock:^(UIImage *resultImage, NSInteger state) {
        if (block) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(resultImage, state);
            });
        }
    }];
}

- (UIImage *)takeCenterSnapshotFromMapView:(MAMapView *)mapView {
    CGSize size = mapView.bounds.size;
    CGPoint centerPoint = CGPointMake(size.width/2, size.height/2);
    UIImage *image = [mapView takeSnapshotInRect:CGRectMake(centerPoint.x - SNAPSHOT_SPAN_WIDTH/2, centerPoint.y - SNAPSHOT_SPAN_HEIGHT/2, SNAPSHOT_SPAN_WIDTH, SNAPSHOT_SPAN_HEIGHT)];
    return image;
}

- (void)takeCenterSnapshotFromMapView:(MAMapView *)mapView withCompletionBlock:(void (^)(UIImage *resultImage, NSInteger state))block {
    CGSize size = mapView.bounds.size;
    CGPoint centerPoint = CGPointMake(size.width/2, size.height/2);
    CGRect rect = CGRectMake(centerPoint.x - SNAPSHOT_SPAN_WIDTH/2, centerPoint.y - SNAPSHOT_SPAN_HEIGHT/2, SNAPSHOT_SPAN_WIDTH, SNAPSHOT_SPAN_HEIGHT);
    [mapView takeSnapshotInRect:rect withCompletionBlock:block];
}

#pragma mark - 地理逆解析

//搜索发生错误时调用
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
//    CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(request.location.latitude, request.location.longitude);
    //    NSInteger index = [objc_getAssociatedObject(request, &key) intValue];
    CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(0, 0);
    NSLog(@"搜索错误%@",error);

    @synchronized (self) {
        for (NSInteger i = 0, r = _allRequests.count; i < r; i++) {
            _LLInternal_Data_LLLocationManager *data = _allRequests[i];
            if (data.request == request) {
                data.completeCallback(nil, coordinate2D);
                [_allRequests removeObjectAtIndex:i];
                break;
            }
            
            if (data.geoRequest == request) {
                data.geoCompleteCallback(nil, coordinate2D);
                [_allRequests removeObjectAtIndex:i];
                break;
            }
        }
    }
}

//实现逆地理编码的回调函数
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
    CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(request.location.latitude, request.location.longitude);
    
    //    NSInteger index = [objc_getAssociatedObject(request, &key) intValue];
    
    @synchronized (self) {
        for (NSInteger i = 0, r = _allRequests.count; i < r; i++) {
            _LLInternal_Data_LLLocationManager *data = _allRequests[i];
            if (data.request == request) {
                data.completeCallback(response.regeocode, coordinate2D);
                [_allRequests removeObjectAtIndex:i];
                break;
            }
        }
    }
}

//实现地理编码的回调函数
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response {
    
    //    NSInteger index = [objc_getAssociatedObject(request, &key) intValue];
    
    @synchronized (self) {
        for (NSInteger i = 0, r = _allRequests.count; i < r; i++) {
            _LLInternal_Data_LLLocationManager *data = _allRequests[i];
            if (data.geoRequest == request) {
                AMapGeocode *geoCode = response.geocodes.firstObject;
                data.geoCompleteCallback(geoCode, CLLocationCoordinate2DMake(geoCode.location.latitude, geoCode.location.longitude));
                [_allRequests removeObjectAtIndex:i];
                break;
            }
        }
    }
}

- (void)geocodeFromCityName:(NSString *)cityName completeCallback:(void (^)(AMapGeocode *address, CLLocationCoordinate2D coordinate2D))completeCallback {
    if (!completeCallback)
        return;
    
    AMapGeocodeSearchRequest *geoUser = [[AMapGeocodeSearchRequest alloc] init];
    geoUser.address = cityName;
    [self.reGeocodeSearch AMapGeocodeSearch:geoUser];
    
    _LLInternal_Data_LLLocationManager *data = [_LLInternal_Data_LLLocationManager new];
    data.geoRequest = geoUser;
    data.geoCompleteCallback = completeCallback;
    //    data.index = key;
    [_allRequests addObject:data];
    //    key++;

}


- (void)reGeocodeFromCoordinate:(CLLocationCoordinate2D)coordinate2D completeCallback:(void (^)(AMapReGeocode *address, CLLocationCoordinate2D coordinate2D))completeCallback {
    if (!completeCallback)
        return;
    
    AMapReGeocodeSearchRequest *regeoUser = [[AMapReGeocodeSearchRequest alloc] init];
    regeoUser.radius = 3000;
    regeoUser.requireExtension = NO;
    //    objc_setAssociatedObject(regeoUser, &key, @(key),  OBJC_ASSOCIATION_ASSIGN);
    
    AMapGeoPoint *point = [AMapGeoPoint locationWithLatitude:coordinate2D.latitude longitude:coordinate2D.longitude];
    regeoUser.location = point;
    
    [self.reGeocodeSearch AMapReGoecodeSearch:regeoUser];
    
    _LLInternal_Data_LLLocationManager *data = [_LLInternal_Data_LLLocationManager new];
    data.request = regeoUser;
    data.completeCallback = completeCallback;
    //    data.index = key;
    [_allRequests addObject:data];
    //    key++;
}


- (void)getLocationNameAndAddressFromReGeocode:(AMapReGeocode *)reGeoCode name:(NSString **)name address:(NSString **)address {
    NSString *_address = reGeoCode.formattedAddress;
    NSString *_name;
    if (reGeoCode.addressComponent.neighborhood.length > 0)
        _name = reGeoCode.addressComponent.neighborhood;
    else if (reGeoCode.addressComponent.building.length > 0) {
        _name = reGeoCode.addressComponent.building;
    }else if (_address.length > 0) {
        _name = [_address substringFromIndex:reGeoCode.addressComponent.province.length];
    }
    
    if (_name.length == 0)
        _name = LOCATION_EMPTY_NAME;
    if (_address.length == 0)
        _address = LOCATION_EMPTY_ADDRESS;
    
    *name = _name;
    *address = _address;
}

#pragma mark - **************** 获取当前位置
- (void)getCurrentLocationAndCompleteBlock:(void (^)(NSString *, NSString *, NSError *))compleleBlock {
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            if (compleleBlock) {
                compleleBlock(nil,nil,error);
            }
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        NSLog(@"location:%@", location);
        if (regeocode)
        {
            if (compleleBlock) {
                compleleBlock(regeocode.province,regeocode.city, nil);
            }
            NSLog(@"reGeocode:%@", regeocode);
        }
    }];
}

@end
