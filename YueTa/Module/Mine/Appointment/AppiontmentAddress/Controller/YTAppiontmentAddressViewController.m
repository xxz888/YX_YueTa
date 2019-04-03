//
//  YTAppiontmentAddressViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/3.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTAppiontmentAddressViewController.h"
#import "YTChangeAppionmentAddressViewController.h"
#import "YTAppiontmentSearchViewController.h"

#import <MAMapKit/MAMapKit.h>
#import "YCLocationManager.h"

static NSString * const RoutePlanningViewControllerDestinationTitle = @"终点";

@interface YTAppiontmentAddressViewController ()<MAMapViewDelegate>

@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UIButton *changeCityButton;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) id<MAAnnotation> clickedAnnotation;

@property (nonatomic, strong) AMapReGeocode *selectedAddress;
@property (nonatomic, assign) NSInteger isFirstLoad;

@end

@implementation YTAppiontmentAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isFirstLoad = YES;
    
    [self.view addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.view);
        make.height.equalTo(@kRealValue(55));
    }];
    
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchView.mas_bottom);
        make.left.and.right.and.bottom.equalTo(self.view);
    }];
}

- (void)addAnnotationInCoordinate:(CLLocationCoordinate2D)coordinate {
    if (self.clickedAnnotation) {
        [self.mapView removeAnnotation:self.clickedAnnotation];
    }
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = coordinate;
    pointAnnotation.title = RoutePlanningViewControllerDestinationTitle;
    [self.mapView addAnnotation:pointAnnotation];
    self.clickedAnnotation = pointAnnotation;
    
    [self.mapView setCenterCoordinate:coordinate];
}

- (void)refreshSearchButtonByCoordinate:(CLLocationCoordinate2D)coordinate {
    @weakify(self);
    [[YCLocationManager sharedManager] reGeocodeFromCoordinate:coordinate completeCallback:^(AMapReGeocode *address, CLLocationCoordinate2D coordinate2D) {
        NSLog(@"address:%@",address.formattedAddress);
        @strongify(self);
        [self.searchButton setTitle:address.formattedAddress forState:UIControlStateNormal];
        self.selectedAddress = address;
    }];
}

- (void)refreshChangeCityButtonByCoordinate:(CLLocationCoordinate2D)coordinate {
    @weakify(self);
    [[YCLocationManager sharedManager] reGeocodeFromCoordinate:coordinate completeCallback:^(AMapReGeocode *address, CLLocationCoordinate2D coordinate2D) {
        NSLog(@"address:%@",address.formattedAddress);
        @strongify(self);
        [self.changeCityButton setTitle:address.addressComponent.city forState:UIControlStateNormal];
    }];
}

#pragma mark - **************** Event Response
- (void)changeCityButtonClicked {
    YTChangeAppionmentAddressViewController *change = [[YTChangeAppionmentAddressViewController alloc] init];
    change.selectAddressBlock = ^(NSString * _Nonnull proviceName, NSString * _Nonnull cityName) {
        NSLog(@"选中的城市名称%@%@",proviceName,cityName);
        NSString *detailName = [NSString stringWithFormat:@"%@%@",proviceName,cityName];
        [[YCLocationManager sharedManager] geocodeFromCityName:detailName completeCallback:^(AMapGeocode *address, CLLocationCoordinate2D coordinate2D) {
            if (address) {
                [self addAnnotationInCoordinate:coordinate2D];
                [self.changeCityButton setTitle:cityName forState:UIControlStateNormal];
            }
        }];
    };
    [self.navigationController pushViewController:change animated:YES];
}

- (void)searchButtonClicked {
    YTAppiontmentSearchViewController *searchVC = [[YTAppiontmentSearchViewController alloc] init];
    searchVC.currentCity = self.selectedAddress.addressComponent.citycode;
    searchVC.locationClickedBlock = ^(AMapPOI * _Nonnull poi) {
        CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
        [self addAnnotationInCoordinate:coordinate2D];
        [self refreshSearchButtonByCoordinate:coordinate2D];
    };
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)confirmButtonClicked {
    if (!self.selectedAddress.formattedAddress.length) {
        [kAppWindow showAutoHideHudWithText:@"请选择约会位置"];
        return;
    }
    
    if (self.addressComfirmBlock) {
        self.addressComfirmBlock(self.selectedAddress.addressComponent.district,self.selectedAddress.formattedAddress,self.clickedAnnotation.coordinate);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - **************** MAMapViewDelegate
/**
 * @brief 单击地图回调，返回经纬度
 * @param mapView 地图View
 * @param coordinate 经纬度
 */
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    [self addAnnotationInCoordinate:coordinate];
    [self refreshSearchButtonByCoordinate:coordinate];
}

/**
 * @brief 根据anntation生成对应的View。
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        if([[annotation title] isEqualToString:(NSString *)RoutePlanningViewControllerDestinationTitle])
        {
            static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
            MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
            if (annotationView == nil)
            {
                annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
            }
            annotationView.image = [UIImage imageNamed:@"ic_location_point"];
            annotationView.layer.anchorPoint = CGPointMake(0.5, 0.96);
            
            return annotationView;
        }
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    if (_isFirstLoad) {
        _isFirstLoad = NO;
        [self refreshChangeCityButtonByCoordinate:userLocation.coordinate];
    }
}

#pragma mark - **************** Setter Getter
- (UIView *)searchView {
    if (!_searchView) {
        _searchView = [[UIView alloc] init];
        _searchView.backgroundColor = kWhiteBackgroundColor;
        
        _changeCityButton = [UIButton buttonWithImage:@"ic_location_city" taget:self action:@selector(changeCityButtonClicked)];
        _changeCityButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 0);
        _changeCityButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 2);
        _changeCityButton.titleLabel.font = kSystemFont13;
        [_changeCityButton setTitleColor:kGrayTextColor forState:UIControlStateNormal];
        [_searchView addSubview:_changeCityButton];
        [_changeCityButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.bottom.equalTo(self.searchView);
            make.width.equalTo(@kRealValue(70));
        }];
        
        _searchButton = [UIButton buttonWithTitle:@"输入位置或名称" taget:self action:@selector(searchButtonClicked) font:kSystemFont15 titleColor:kGrayTextColor];
        _searchButton.backgroundColor = kMineGrayBackgroundColor;
        _searchButton.layer.cornerRadius = 5;
        [_searchView addSubview:_searchButton];
        [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.changeCityButton.mas_right);
            make.bottom.equalTo(self.searchView).offset(-kRealValue(10));
            make.top.equalTo(self.searchView).offset(kRealValue(10));
            make.width.equalTo(@kRealValue(240));
        }];
        
        UIButton *confirmButton = [UIButton buttonWithTitle:@"确定" taget:self action:@selector(confirmButtonClicked) font:kSystemFont15 titleColor:kBlackTextColor];
        [_searchView addSubview:confirmButton];
        [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.searchButton.mas_right);
            make.right.equalTo(self.searchView);
            make.top.and.bottom.equalTo(self.searchView);
        }];
    }
    return _searchView;
}

- (MAMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MAMapView alloc] init];
        _mapView.delegate = self;
        _mapView.mapType = MAMapTypeStandard;
        
        _mapView.zoomEnabled = YES;
        _mapView.minZoomLevel = 4;
        _mapView.maxZoomLevel = 18;
        _mapView.zoomLevel = 15;
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        
        _mapView.scrollEnabled = YES;
        _mapView.showsCompass = NO;
        _mapView.showsScale = NO;
        _mapView.logoCenter = CGPointMake(kScreenWidth - 3 - _mapView.logoSize.width/2, CGRectGetHeight(self.mapView.frame) - 3 - _mapView.logoSize.height/2);
    }
    return _mapView;
}

@end
