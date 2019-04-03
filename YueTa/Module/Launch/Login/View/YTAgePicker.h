//
//  YTAgePicker.h
//  YueTa
//
//  Created by 姚兜兜 on 2018/12/25.
//  Copyright © 2018 姚兜兜. All rights reserved.
//

#import "YCPickerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTAgePicker : YCPickerView

+ (instancetype)agePickerViewAndBlock:(void(^)(NSInteger selectRow, NSString *text))block;

@end

NS_ASSUME_NONNULL_END
