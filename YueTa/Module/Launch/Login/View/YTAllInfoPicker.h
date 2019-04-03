//
//  YTAllInfoPicker.h
//  YueTa
//
//  Created by 姚兜兜 on 2019/1/16.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YCPickerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTAllInfoPicker : YCPickerView

+ (instancetype)allInfoPickerrViewWithArray:(NSArray *)array AndBlock:(void(^)(NSInteger selectRow, NSString *text))block;

@end

NS_ASSUME_NONNULL_END
