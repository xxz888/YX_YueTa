//
//  YTAuthenStatusModel.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/22.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTAuthenStatusModel : BaseModel

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *photo_1;
@property (nonatomic, copy) NSString *photo_2;
@property (nonatomic, copy) NSString *photo_3;
@property (nonatomic, copy) NSString *reason;

@end

NS_ASSUME_NONNULL_END
