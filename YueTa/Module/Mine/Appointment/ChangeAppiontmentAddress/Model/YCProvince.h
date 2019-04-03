//
//  YCProvince.h
//  ychat
//
//  Created by 孙俊 on 2018/1/5.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "BaseModel.h"
#import "YCCity.h"

@interface YCProvince : BaseModel

@property (nonatomic, strong) NSArray *citys;

@property (nonatomic, copy) NSString *provinceName;

@end
