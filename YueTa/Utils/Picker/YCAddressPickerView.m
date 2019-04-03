//
//  YCAddressPickerView.m
//  ychat
//
//  Created by mc on 2018/1/15.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "YCAddressPickerView.h"

@interface YCAddressPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>
///省
@property(nonatomic, strong) NSArray * provinceArray;
///市
@property(nonatomic, strong) NSArray * cityArray;

///记录省选中的位置
@property(nonatomic, assign) NSInteger selectProvinceIndex;
///被选中的省
@property(nonatomic, copy) NSString * selectProvince;
///被选中的市
@property(nonatomic, copy) NSString * selectCity;
///被选中的区
@property(nonatomic, copy) NSString * selectArea;
///省市区的回调
@property (nonatomic, copy) void (^areaBlock)(NSString *province, NSString *city);

@end


@implementation YCAddressPickerView

+ (instancetype)areaPickerViewWithAreaBlock:(void(^)(NSString *province, NSString *city))areaBlock {
    return [YCAddressPickerView addressPickerViewWithBlock:areaBlock];
}

+ (instancetype)addressPickerViewWithBlock:(void(^)(NSString *province, NSString *city))areaBlock {
    
    YCAddressPickerView *_view = [[YCAddressPickerView alloc] init];
    
    _view.areaBlock = areaBlock;
    
    [_view getData];

    [_view showView];
    
    return _view;
}

#pragma mark - data
//获取数据
- (void)getData {
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    
    self.provinceArray = [NSArray arrayWithContentsOfFile:path];
    self.cityArray = [NSArray arrayWithArray:self.provinceArray[0][@"children"]];
    
    self.selectProvince = self.provinceArray[0][@"Name"];
    self.selectCity = self.cityArray[0][@"Name"];
}

#pragma mark - events
- (void)buttonClick:(UIButton *)sender {
    
    [self hideView];
    
    if (sender.tag == YCTypePickerViewButtonTypeSure) {
        
        if (_areaBlock) {
            _areaBlock(self.selectProvince, self.selectCity);
        }
    }
}

#pragma mark -- UIPickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1){
        return self.cityArray.count;
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 3, 30)];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    if (component == 0) {
        label.text = [NSString stringWithFormat:@"%@",self.provinceArray[row][@"Name"]];
    } else if (component == 1) {
        label.text = [NSString stringWithFormat:@"%@",self.cityArray[row][@"Name"]];
    }
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {//选择省
        self.selectProvinceIndex = row;

        self.cityArray = [NSArray arrayWithArray:self.provinceArray[row][@"children"]];
        
        [self.pickerView reloadComponent:1];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];

        self.selectProvince = self.provinceArray[row][@"Name"];
        self.selectCity = self.cityArray[0][@"Name"];

    } else if (component == 1) {//选择市
        
        self.selectCity = self.cityArray[row][@"Name"];
        
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return kRealValue(40);
}


@end
