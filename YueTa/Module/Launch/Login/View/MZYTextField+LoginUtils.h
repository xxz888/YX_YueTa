//
//  MZYTextField+LoginUtils.h
//  ManZhiYan
//
//  Created by 姚兜兜 on 2018/3/5.
//  Copyright © 2018年 姚兜兜. All rights reserved.
//

#import "MZYTextField.h"

@interface MZYTextField (LoginUtils)

/**
 返回带左视图（图片）的UITextField
 
 @param frame 大小和位置
 @param imageString 左视图图片名
 @param placeholder 占位符文字
 @return 返回带左视图（图片）的UITextField
 */
+ (MZYTextField *)MZYTextFieldInitWithFrame:(CGRect)frame imageString:(NSString *)imageString placeholder:(NSString *)placeholder;

@end
