//
//  YCAddressPickerView.h
//  ychat
//
//  Created by mc on 2018/1/15.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "YCPickerView.h"

@interface YCAddressPickerView : YCPickerView

/**
 * 显示省份和市级
 * areaBlock : 回调省份城市
 */
+ (instancetype)areaPickerViewWithAreaBlock:(void(^)(NSString *province, NSString *city))areaBlock;



@end
