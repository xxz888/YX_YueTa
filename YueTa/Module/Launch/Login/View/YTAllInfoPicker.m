//
//  YTAllInfoPicker.m
//  YueTa
//
//  Created by 姚兜兜 on 2019/1/16.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTAllInfoPicker.h"

@interface YTAllInfoPicker ()

@property (nonatomic, assign) NSInteger selectRow;
@property (nonatomic, strong) NSString *selectText;

@property (nonatomic, strong) NSArray *dataArray;

///回调
@property (nonatomic, copy) void (^timeBlock)(NSInteger selectRow, NSString *text);

@end


@implementation YTAllInfoPicker

+ (instancetype)allInfoPickerrViewWithArray:(NSArray *)array AndBlock:(void (^)(NSInteger, NSString * _Nonnull))block {
    YTAllInfoPicker *_view = [[YTAllInfoPicker alloc] init];
    _view.timeBlock = block;
    
    [_view getDataWithArray:array];
    
    [_view showView];
    
    return _view;
}

//获取数据
- (void)getDataWithArray:(NSArray *)array {
    
    self.dataArray = [array copy];
    
    self.selectRow = 0;
    self.selectText = self.dataArray[0];
}

- (void)buttonClick:(UIButton *)sender {
    
    [self hideView];
    
    if (sender.tag == YCTypePickerViewButtonTypeSure) {
        
        if (_timeBlock) {
            _timeBlock(self.selectRow, self.selectText);
        }
    }
}

#pragma mark -- UIPickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArray.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(component*kScreenWidth, 0, kScreenWidth, kRealValue(30))];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.dataArray[row];
    
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectRow = row;
    self.selectText = self.dataArray[row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return kRealValue(35.0);
}



@end
