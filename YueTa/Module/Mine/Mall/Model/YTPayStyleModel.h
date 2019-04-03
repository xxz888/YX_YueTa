//
//  YTPayStyleModel.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/21.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTPayStyleModel : BaseModel

@property (nonatomic, copy) NSString *leftImageName;
@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, assign) BOOL isSelected;

- (instancetype)initWithLeftImageName:(NSString *)leftImageName
                            titleName:(NSString *)titleName
                           isSelected:(BOOL)isSelected;

@end

NS_ASSUME_NONNULL_END
