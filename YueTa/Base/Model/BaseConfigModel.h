//
//  BaseConfigModel.h
//  CJYP
//
//  Created by 姚兜兜 on 2018/5/11.
//  Copyright © 2018年 林森. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 本地基础模型
 */
@interface BaseConfigModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, copy) NSString *icon;

+ (BaseConfigModel *)modelWithTitle:(NSString *)title subTitle:(NSString *)subTitle icon:(NSString *)icon;

@end
