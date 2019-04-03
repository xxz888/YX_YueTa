//
//  AllInfoModel.h
//  YueTa
//
//  Created by 姚兜兜 on 2019/1/15.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AllInfoModel : BaseModel

@property (nonatomic, strong) NSArray *famaleJobsArr;//女性职业
@property (nonatomic, strong) NSArray *maleJobsArr;//男性职业
@property (nonatomic, strong) NSArray *moneyArr;//金额
@property (nonatomic, strong) NSArray *engagementArr;//约会节目
@property (nonatomic, strong) NSArray *personalaArr;//个人标签

/* 本地扩展字段，用来记录当前选择的数据 */
@property (nonatomic, strong) NSString *job;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *education;
@property (nonatomic, assign) NSInteger educationInt;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *weight;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *cith;

@end

NS_ASSUME_NONNULL_END
