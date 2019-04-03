//
//  YCAreaDataHelper.h
//  ychat
//
//  Created by 孙俊 on 2018/1/5.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YCProvince;
@class YCCity;
/**
 *  格式化地区列表
 */

@interface YCAreaDataHelper : NSObject

/**
 * 格式化地区row数据源
 *
 * @param array    数据源
 * @param complete 返回分组后的每一位联系人（二维数组）标题数组 (string)
 */
+ (void)getAreaListDataBy:(NSArray *)array andComplete:(void(^)(NSArray *rowArray, NSArray *sectionArray))complete;

/**
 * @brief 获取省份数组
 *
 * return 省份模型数组
 */
+ (NSArray<YCProvince *> *)provinceList;

/**
 * @brief 获取城市数组
 *
 * return 城市模型数组
 */
+ (NSArray<YCCity *> *)cityList;


@end
