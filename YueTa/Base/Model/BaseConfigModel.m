//
//  BaseConfigModel.m
//  CJYP
//
//  Created by 姚兜兜 on 2018/5/11.
//  Copyright © 2018年 林森. All rights reserved.
//

#import "BaseConfigModel.h"

@implementation BaseConfigModel

+ (BaseConfigModel *)modelWithTitle:(NSString *)title subTitle:(NSString *)subTitle icon:(NSString *)icon {
    return [[BaseConfigModel alloc] initWithTitle:title subTitle:subTitle icon:icon];
}

- (id)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle icon:(NSString *)icon {
    
    if (self = [super init]) {
        
        self.title = title;
        self.subTitle = subTitle;
        self.icon = icon;
    }
    return self;
}

@end
