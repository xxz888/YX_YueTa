//
//  YTMyProblemModel.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/22.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTMyProblemModel : BaseModel

@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *problem;
@property (nonatomic, copy) NSString *pic1;
@property (nonatomic, copy) NSString *pic2;
@property (nonatomic, copy) NSString *pic3;
@property (nonatomic, copy) NSString *answer;
@property (nonatomic, assign) NSInteger status;//状态（0未解答，1已解答）
@property (nonatomic, copy) NSString *submit_time;
@property (nonatomic, assign) NSInteger type;//类型(1,"用户提交"),(2,"常见问题")

@end

NS_ASSUME_NONNULL_END
