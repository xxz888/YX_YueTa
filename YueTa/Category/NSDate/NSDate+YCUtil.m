//
//  NSDate+YCUtil.m
//  ychat
//
//  Created by 孙俊 on 2018/1/11.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "NSDate+YCUtil.h"

@implementation NSDate (YCUtil)

+ (NSString *)dateWithTimestamp:(NSString *)timestamp format:(NSString *)format {
    long long millisecond = [timestamp longLongValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:millisecond];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    dateFormatter.timeZone = timeZone;
    dateFormatter.dateFormat = format;
    return [dateFormatter stringFromDate:date];
}

- (NSString *)getYear{
    
    NSCalendar * calender = [NSCalendar currentCalendar];
    
    NSDateComponents * components = [calender components:NSCalendarUnitYear  fromDate:self];
    return [NSString stringWithFormat:@"%ld",components.year];
    
}

- (NSString *)getMonth{
    
    NSCalendar * calender = [NSCalendar currentCalendar];
    
    NSDateComponents * components = [calender components:NSCalendarUnitMonth fromDate:self];
    
    return [NSString stringWithFormat:@"%ld",components.month];
}

- (NSString *)getDay{
    
    NSCalendar * calender = [NSCalendar currentCalendar];
    
    NSDateComponents * components = [calender components:NSCalendarUnitDay fromDate:self];
    
    return [NSString stringWithFormat:@"%ld",components.day];
}

- (NSString *)getHour{
    NSCalendar * calender = [NSCalendar currentCalendar];
    
    NSDateComponents * components = [calender components:NSCalendarUnitHour fromDate:self];
    
    return [NSString stringWithFormat:@"%.2ld",components.hour];
}

- (NSString *)getSecond{
    
    NSCalendar * calender = [NSCalendar currentCalendar];
    NSDateComponents * components = [calender components:NSCalendarUnitSecond fromDate:self];
    return [NSString stringWithFormat:@"%.2ld",components.second];
}

- (NSString *)getMinute{
    NSCalendar * calender = [NSCalendar currentCalendar];
    
    NSDateComponents * components = [calender components:NSCalendarUnitMinute fromDate:self];
    
    return [NSString stringWithFormat:@"%.2ld",components.minute];
}

+ (BOOL)dateCompareFixedTime:(NSInteger)time {
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
    NSInteger timeSecond = [NSString stringWithFormat:@"%0.f", a].integerValue;
    
    // 当系统当前时间，是比 传入指定时间 + 默认天数 小的，则返回 YES
    // 否则 返回 NO
    if (timeSecond < time + 3600*24*3) {
        return YES;
    } else {
        return NO;
    }
}

@end
