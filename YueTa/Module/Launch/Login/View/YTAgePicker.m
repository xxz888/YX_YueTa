//
//  YTAgePicker.m
//  YueTa
//
//  Created by 姚兜兜 on 2018/12/25.
//  Copyright © 2018 姚兜兜. All rights reserved.
//

#import "YTAgePicker.h"

@interface YTAgePicker ()

@property (nonatomic, assign) NSInteger selectRow;
@property (nonatomic, strong) NSString *selectText;

@property (nonatomic, strong) NSArray *dataArray;

///回调
@property (nonatomic, copy) void (^timeBlock)(NSInteger selectRow, NSString *text);

@end

@implementation YTAgePicker

+ (instancetype)agePickerViewAndBlock:(void (^)(NSInteger, NSString * _Nonnull))block {
    
    YTAgePicker *_view = [[YTAgePicker alloc] init];
    _view.timeBlock = block;
    
    [_view getData];
    
    [_view showView];
    
    return _view;
}

//获取数据
- (void)getData {
    
    // 年龄设置区间，暂时18-80岁之间
    NSMutableArray *stringArr = [NSMutableArray array];
    for (NSInteger i = 18; i < 81; i++) {
        [stringArr addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    
    self.dataArray = [stringArr copy];
    
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
