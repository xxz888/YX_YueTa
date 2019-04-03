//
//  YCAreaDataHelper.m
//  ychat
//
//  Created by 孙俊 on 2018/1/5.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "YCAreaDataHelper.h"
#import "YCCity.h"
#import "YCProvince.h"

@implementation YCAreaDataHelper

+ (void)getAreaListDataBy:(NSArray *)array andComplete:(void(^)(NSArray *rowArray, NSArray *sectionArray))complete {
    NSMutableArray <NSMutableArray *> * contacts = [NSMutableArray arrayWithCapacity:0];
    
    UILocalizedIndexedCollation * localizedCollation = [UILocalizedIndexedCollation currentCollation];
    //标题数组
    NSMutableArray *sectionTitleArray = [localizedCollation.sectionTitles mutableCopy];
    //标题个数
    NSInteger sectionTitlesCount = [[localizedCollation sectionTitles] count];

    /**** 根据UILocalizedIndexedCollation的27个Title放入27个存储数据的数组 ****/
    for (NSInteger i = 0; i < localizedCollation.sectionTitles.count; i++)
    {
        [contacts addObject:[NSMutableArray arrayWithCapacity:0]];
    }
    
    //开始遍历联系人对象，进行分组
    for (YCCity * city in array)
    {
        //获取名字在UILocalizedIndexedCollation标头的索引数
        NSInteger section = [localizedCollation sectionForObject:city collationStringSelector:@selector(citysName)];
        
        //根据索引在相应的数组上添加数据
        [contacts[section] addObject:city];
    }
    
    //对每个同组的联系人进行排序
    for (NSInteger i = 0; i < localizedCollation.sectionTitles.count; i++)
    {
        //获取需要排序的数组
        NSMutableArray * tempMutableArray = contacts[i];
        
        //这里因为需要通过city的cityname进行排序，排序器排序
        NSArray *tempArray = [localizedCollation sortedArrayFromArray:tempMutableArray collationStringSelector:@selector(citysName)];
        contacts[i] = [tempArray mutableCopy];
    }
    
    //删除空的数组
    NSMutableArray *tempContacts = [NSMutableArray array];
    NSMutableArray *tempSectionTitles = [NSMutableArray array];

    //记录空的数组
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        if (contacts[index].count == 0) {
            [tempContacts addObject:contacts[index]];
            [tempSectionTitles addObject:sectionTitleArray[index]];
        }
    }
    
    //删除空的数组
    for (NSInteger index = 0; index < tempContacts.count; index++) {
        [contacts removeObject:tempContacts[index]];
        [sectionTitleArray removeObject:tempSectionTitles[index]];
    }

    if (complete) {
        complete([contacts copy],[sectionTitleArray copy]);
    }
}

+ (NSArray<YCProvince *> *)provinceList {
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"json"]];
    
    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *provinceList = [YCProvince mj_objectArrayWithKeyValuesArray: dataDict[@"provinces"]];
    return provinceList;
}

+ (NSArray<YCCity *> *)cityList {
    NSArray<YCProvince *> * provinceList = [self provinceList];
    NSMutableArray<YCCity *> *cityList = [NSMutableArray array];
    [provinceList enumerateObjectsUsingBlock:^(YCProvince * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *proviceName =  obj.provinceName;
        if (obj.citys.count) {
            [obj.citys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ((YCCity *)obj).proviceName = proviceName;
            }];
            [cityList addObjectsFromArray:obj.citys];
        }
    }];
    return [cityList copy];
}

@end
