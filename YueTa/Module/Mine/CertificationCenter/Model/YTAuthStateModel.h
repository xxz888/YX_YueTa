//
//  YTAuthStateModel.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/29.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTAuthStateModel : BaseModel

@property (nonatomic, assign) NSInteger status;//(1,'成功'),(2,'审核中'),(3,'失败')
@property (nonatomic, copy) NSString *photo_1;
@property (nonatomic, copy) NSString *photo_2;
@property (nonatomic, copy) NSString *photo_3;
@property (nonatomic, copy) NSString *reason;

@end

NS_ASSUME_NONNULL_END
