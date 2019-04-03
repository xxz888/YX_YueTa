//
//  YCTimePickerView.m
//  ychat
//
//  Created by mc on 2018/1/15.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "YCTimePickerView.h"

#define kStartYear 2019
#define kStartMonth 1
#define kStartDay 1

@interface YCTimePickerView ()

///传进来的最小的中年月
@property (nonatomic, assign) NSInteger minYear;
@property (nonatomic, assign) NSInteger minMonth;
@property (nonatomic, assign) NSInteger minDay;

///传进来的最大的中年月
@property (nonatomic, assign) NSInteger maxYear;
@property (nonatomic, assign) NSInteger maxMonth;
@property (nonatomic, assign) NSInteger maxDay;

@property (nonatomic,strong) NSMutableArray *years;
@property (nonatomic,strong) NSMutableArray *months;
@property (nonatomic,strong) NSMutableArray *days;
@property (nonatomic,strong) NSMutableArray *quarter;//季度

///选中的值 年月
@property (nonatomic, assign) NSInteger selectYear;
@property (nonatomic, assign) NSInteger selectMonth;
@property (nonatomic, assign) NSInteger selectDay;
@property (nonatomic, assign) NSInteger selectQuarter;

@property (nonatomic, assign) YCTimePickerViewType type;

@property (nonatomic,strong) NSDateComponents *nowComponents;

///回调
@property (nonatomic, copy) void (^timeBlock)(NSInteger year, NSInteger month, NSInteger day);

///回调
@property (nonatomic, copy) void (^quarterBlock)(NSInteger year, NSInteger quarter);

@end


@implementation YCTimePickerView


#pragma mark --- 开始
+ (instancetype)timePickerWithType:(YCTimePickerViewType)type maxDate:(NSString *)maxDate selectedYear:(NSInteger)selectedYear selectedMonth:(NSInteger)selectedMonth selectedDay:(NSInteger)seclectedDay timeBlock:(void(^)(NSInteger year, NSInteger month, NSInteger day))timeBlock{
    YCTimePickerView *_view = [[YCTimePickerView alloc] init];
    _view.nowComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    if (maxDate.length > 0) {
        NSArray *array = [maxDate componentsSeparatedByString:@"-"];
        _view.maxYear = [array[0] integerValue];
        _view.maxMonth = [array[1] integerValue];
        _view.maxDay = [array[2] integerValue];
    }
    
    _view.minYear = kStartYear;
    _view.minMonth = kStartMonth;
    _view.minDay = kStartDay;
    
    _view.selectYear = selectedYear;
    _view.selectMonth = selectedMonth;
    _view.selectDay = seclectedDay;
    _view.type = type;
    _view.timeBlock = timeBlock;
    
    NSLog(@"view frame %@ %@",NSStringFromCGRect(_view.frame),NSStringFromCGRect(_view.pickerView.frame));
    [_view getData];
    
    [_view showView];
    return _view;
}
#pragma mark --- 结束
+ (instancetype)timePickerWithType:(YCTimePickerViewType)type minDate:(NSString *)minDate selectedYear:(NSInteger)selectedYear selectedMonth:(NSInteger)selectedMonth selectedDay:(NSInteger)seclectedDay timeBlock:(void(^)(NSInteger year, NSInteger month, NSInteger day))timeBlock{
    
    YCTimePickerView *_view = [[YCTimePickerView alloc] init];
    _view.nowComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    if (minDate.length > 0) {
        NSArray *array = [minDate componentsSeparatedByString:@"-"];
        _view.minYear = [array[0] integerValue];
        _view.minMonth = [array[1] integerValue];
        _view.minDay = [array[2] integerValue];
    }
    
    _view.maxYear = _view.nowComponents.year;
    _view.maxMonth = _view.nowComponents.month;
    _view.maxDay = _view.nowComponents.day;
    
    _view.selectYear = selectedYear;
    _view.selectMonth = selectedMonth;
    _view.selectDay = seclectedDay;
    _view.type = type;
    _view.timeBlock = timeBlock;

    NSLog(@"view frame %@ %@",NSStringFromCGRect(_view.frame),NSStringFromCGRect(_view.pickerView.frame));
    [_view getData];
    
    [_view showView];
    return _view;
}
#pragma mark --- 季度
+ (instancetype)timePickerWithType:(YCTimePickerViewType)type selectedYear:(NSInteger)selectedYear selectedMonth:(NSInteger)selectedMonth quarterBlock:(void(^)(NSInteger year, NSInteger quarter))quarterBlock{
    
    YCTimePickerView *_view = [[YCTimePickerView alloc] init];
    
    _view.nowComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    
    _view.minYear = kStartYear;
    _view.minMonth = kStartMonth;
    _view.minDay = kStartDay;
    
    _view.maxYear = _view.nowComponents.year;
    _view.maxMonth = _view.nowComponents.month;
    _view.maxDay = _view.nowComponents.day;
    
    _view.selectYear = selectedYear;
    _view.selectMonth = selectedMonth;
    _view.type = type;
    _view.quarterBlock = quarterBlock;
    [_view getData];
    
    [_view showView];
    
    return _view;
}


//获取数据
- (void)getData {
    
    NSMutableArray *year  = [NSMutableArray array];
    NSMutableArray *month = [NSMutableArray array];
    NSMutableArray *day   = [NSMutableArray array];
    
    for (NSInteger i = self.minYear; i < _maxYear + 1; i++) {
        [year addObject:[NSString stringWithFormat:@"%ld",(long)i]];
    }
    _years = year;
    for (NSInteger i = self.minMonth; i < _maxMonth + 1; i++) {
        [month addObject:[NSString stringWithFormat:@"%ld",(long)i]];
    }
    _months = month;
    for (NSInteger i = self.minDay; i < _maxDay + 1; i++) {
        [day addObject:[NSString stringWithFormat:@"%ld",(long)i]];
    }
    _days = day;
    
    [self.pickerView reloadComponent:0];
    [self.pickerView reloadComponent:1];
    /** 如果有默认选中的需要遍历 */
    if (_selectYear) {
        for (NSInteger i = 0; i < _years.count; i++) {
            if (_selectYear == [_years[i] integerValue]) {
                NSString *curYear = _years[i];
                self.selectYear = curYear.integerValue;
                [self.pickerView selectRow:i inComponent:0 animated:YES];
            }
        }
    }
    
    if (_selectMonth) {
        for (NSInteger i = 0; i < _months.count; i++) {
            if (_selectMonth == [_months[i] integerValue]) {
                NSString *curMonth = _months[i];
                self.selectMonth = curMonth.integerValue;
                [self.pickerView selectRow:i inComponent:1 animated:YES];
            }
        }
    }
    
    if (self.type == YCTimePickerViewYearMothDay) {
        [self.pickerView reloadComponent:2];
        if (_selectDay) {
            for (NSInteger i = 0; i < _days.count; i++) {
                if (_selectDay == [_days[i] integerValue]) {
                    NSString *curDay = _days[i];
                    self.selectDay = curDay.integerValue;
                    [self.pickerView selectRow:i inComponent:2 animated:YES];
                }
            }
        }
    }
    NSInteger yearIndex = 0;
    if (self.type ==  YCTimePickerViewQuarter) {
        for (NSInteger i = 0; i < self.years.count; i++) {
            if (self.selectYear == [self.years[i] integerValue]) {
                yearIndex = i;
                break;
            }
        }
        [self.pickerView selectRow:yearIndex inComponent:0 animated:YES];
        
        [self.quarter removeAllObjects];
        self.quarter = [NSMutableArray arrayWithArray:[self quarterBuyYear:self.selectYear]];
        
        NSInteger quarterIndex = 0;
        switch (self.selectMonth) {
            case 1: case 2: case 3:
                quarterIndex = 0;
                break;
            case 4: case 5: case 6:
                quarterIndex = 1;
                break;
            case 7: case 8: case 9:
                quarterIndex = 2;
                break;
            case 10: case 11: case 12:
                quarterIndex = 3;
                break;
                
            default:
                break;
        }
        [self.pickerView selectRow:quarterIndex inComponent:1 animated:YES];
    }
    
}



- (void)buttonClick:(UIButton *)sender {
    
    [self hideView];
    
    if (sender.tag == YCTypePickerViewButtonTypeSure) {
        if (self.type == YCTimePickerViewQuarter) {
            if (_quarterBlock) {
                _quarterBlock(self.selectYear,self.selectQuarter);
            }
        }else{
            if (_timeBlock) {
                _timeBlock(self.selectYear,self.selectMonth,self.selectDay);
            }
        }
        
    }
}

#pragma mark -- UIPickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.type == YCTimePickerViewYearMothDay) {
        return 3;
    }
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    if (component == 0) {
        return _years.count;
    } else if (component == 1) {
        if (self.type == YCTimePickerViewQuarter) {
            [self.quarter removeAllObjects];
            self.quarter = [NSMutableArray arrayWithArray:[self quarterBuyYear:self.selectYear]];
            return self.quarter.count;
        }else{
            // 当前年 只能显示已有的月份，未来的月份不显示
            _months = [self monthbeginWithYear:self.selectYear];
            return _months.count;
        }
    } else {
        _days = [self daybeginWithYear:self.selectYear month:self.selectMonth];
        return _days.count;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(component*kScreenWidth, 0, kScreenWidth / 3, kRealValue(30))];
    if (self.type == YCTimePickerViewYearMoth || self.type == YCTimePickerViewQuarter) {
        label.frame = CGRectMake(component*kScreenWidth, 0, kScreenWidth / 2, kRealValue(30));
    }else{
        label.frame = CGRectMake(component*kScreenWidth, 0, kScreenWidth / 3, kRealValue(30));
    }
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    switch (component) {
        case 0:
            label.text = [NSString stringWithFormat:@"%@年",_years[row]];
            break;
        case 1:{
            if (self.type == YCTimePickerViewQuarter) {
                label.text = self.quarter[row];
                _selectQuarter = row + 1;
            }else{
                label.text = [NSString stringWithFormat:@"%@月",_months[row]];
            }
        }
            break;
        case 2:
            label.text = [NSString stringWithFormat:@"%@日",_days[row]];
            break;
            
        default:
            break;
    }
    
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        _selectYear = [_years[row] integerValue];
        // 每当年份选择的时候，都必须刷新月份的row数量 如果是年月日 天数也需要刷新
        [pickerView reloadComponent:1];
        if (self.type == YCTimePickerViewYearMothDay) {
            [pickerView layoutIfNeeded];
            [pickerView reloadComponent:2];
        }
    } else if (component == 1) {
        if (self.type == YCTimePickerViewQuarter) {
            _selectQuarter = row + 1;
        }else{
            _selectMonth = [_months[row] integerValue];
            // 如果是年月日 每当月份选择的时候，都必须刷新天数的row数量
            if (self.type == YCTimePickerViewYearMothDay) {
                [pickerView reloadComponent:2];
            }
        }
    } else {
        _selectDay = [_days[row] integerValue];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return kRealValue(35.0);
}

#pragma mark - determine day
- (NSInteger)determineDayWithMonth:(NSInteger)month year:(NSInteger)year
{
    NSInteger dayCount;
    switch (month) {
        case 1:
            dayCount = 31;
            break;
        case 2:
            if (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)) {
                dayCount = 29;
            }else{
                dayCount = 28;
            }
            break;
        case 3:
            dayCount = 31;
            break;
        case 4:
            dayCount = 30;
            break;
        case 5:
            dayCount = 31;
            break;
        case 6:
            dayCount = 30;
            break;
        case 7:
            dayCount = 31;
            break;
        case 8:
            dayCount = 31;
            break;
        case 9:
            dayCount = 30;
            break;
        case 10:
            dayCount = 31;
            break;
        case 11:
            dayCount = 30;
            break;
        default:
            dayCount = 31;
            break;
    }
    return dayCount;
}

- (NSMutableArray *)monthbeginWithYear:(NSInteger)year{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    if (year == self.maxYear) {
        //如果当前选择年份是可选择的最大年份
        for (NSInteger i = self.minMonth; i < self.maxMonth + 1; i++) {
            [array addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        }
    }else if (year == self.minYear) {
        //如果当前选择年份是可选择的最小年份
        for (NSInteger i = self.minMonth; i < 13; i++) {
            [array addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        }
    }else {
        for (NSInteger i = 1; i < 13; i++) {
            [array addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        }
    }
    return array;
}

- (NSMutableArray *)daybeginWithYear:(NSInteger)year month:(NSInteger)month{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    if (year == self.maxYear && month == self.maxMonth) {
        for (NSInteger i = self.minDay; i < self.maxDay + 1; i++) {
            [array addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        }
    }else if (year == self.minYear && month == self.minMonth) {
        NSInteger end = [self determineDayWithMonth:month year:year];
        for (NSInteger i = self.minDay; i < end + 1; i++) {
            [array addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        }
    }else {
        NSInteger end = [self determineDayWithMonth:month year:year];
        for (NSInteger i = 1; i < end + 1; i++) {
            [array addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        }
    }
    return array;
}

- (NSArray *)quarterBuyYear:(NSInteger)year
{
    NSDateComponents *nowComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    
    if (nowComponents.year == year) {
        if (nowComponents.month > 9) {
            return @[@"1季度",@"2季度",@"3季度",@"4季度"];
        } else if (nowComponents.month > 6) {
            return @[@"1季度",@"2季度",@"3季度"];
        } else if (nowComponents.month > 3) {
            return @[@"1季度",@"2季度"];
        } else {
            return @[@"1季度"];
        }
    }else{
        return @[@"1季度",@"2季度",@"3季度",@"4季度"];
    }
}


@end
