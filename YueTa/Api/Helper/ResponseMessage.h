//
//  ResponseMessage.h
//  ManZhiYan
//
//  Created by 姚兜兜 on 2018/3/2.
//  Copyright © 2018年 姚兜兜. All rights reserved.
//

#import "BaseModel.h"

/**
 全局接口外层判断
 */
@interface ResponseMessage : BaseModel

// 状态码(错误码)
@property (assign, nonatomic) NSInteger code;

// 接口返回消息，只有错误时才返回
@property (copy, nonatomic) NSString *message;


- (instancetype)initWithErrorCode:(NSInteger)errorCode message:(NSString *)message;

@end
