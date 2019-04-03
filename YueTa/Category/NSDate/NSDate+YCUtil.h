//
//  NSDate+YCUtil.h
//  ychat
//
//  Created by 孙俊 on 2018/1/11.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YCUtil)

/**
 * @brief 时间戳转为字符串
 * @param timestamp 时间戳
 * @param format 转换后格式
 *
 * return 转换后的字符串
 */
+ (NSString *)dateWithTimestamp:(NSString *)timestamp format:(NSString *)format;

- (NSString *)getYear;
- (NSString *)getMonth;
- (NSString *)getDay;
- (NSString *)getHour;
- (NSString *)getMinute;
- (NSString *)getSecond;

// 审核测试专用方法，传入一个指定时间戳，然后比较系统（当前时间）和（传入时间戳 +指定天数）大小
+ (BOOL)dateCompareFixedTime:(NSInteger)time;

@end
