//
//  YCTimePickerView.h
//  ychat
//
//  Created by mc on 2018/1/15.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "YCPickerView.h"

typedef NS_ENUM(NSUInteger, YCTimePickerViewType) {
    YCTimePickerViewYearMothDay,     // 年月日类型
    YCTimePickerViewYearMoth,        // 年月类型
    YCTimePickerViewQuarter,         //季度
};

@interface YCTimePickerView : YCPickerView

/**
 时间选择器 (结束时间)
 
 @param type YCTimePickerViewType
 @param minDate 最小的时间
 @param selectedYear 选择的年
 @param selectedMonth 选择的月
 @param seclectedDay 选择的日
 @param timeBlock 回调
 @return YCPickerView
 */
+ (instancetype)timePickerWithType:(YCTimePickerViewType)type minDate:(NSString *)minDate selectedYear:(NSInteger)selectedYear selectedMonth:(NSInteger)selectedMonth selectedDay:(NSInteger)seclectedDay timeBlock:(void(^)(NSInteger year, NSInteger month, NSInteger day))timeBlock;

/**
 时间选择器 (开始时间)
 
 @param type YCTimePickerViewType
 @param maxDate 最大的时间
 @param selectedYear 选择的年
 @param selectedMonth 选择的月
 @param seclectedDay 选择的日
 @param timeBlock 回调
 @return YCPickerView
 */
+ (instancetype)timePickerWithType:(YCTimePickerViewType)type maxDate:(NSString *)maxDate selectedYear:(NSInteger)selectedYear selectedMonth:(NSInteger)selectedMonth selectedDay:(NSInteger)seclectedDay timeBlock:(void(^)(NSInteger year, NSInteger month, NSInteger day))timeBlock;

/**
 时间选择器

 @param type 返回类型
 @param selectedYear 选择的年
 @param selectedMonth 选择的月
 @param quarterBlock 选择回调参数
 @return YCPickerView
 */
+ (instancetype)timePickerWithType:(YCTimePickerViewType)type selectedYear:(NSInteger)selectedYear selectedMonth:(NSInteger)selectedMonth quarterBlock:(void(^)(NSInteger year, NSInteger quarter))quarterBlock;

@end
