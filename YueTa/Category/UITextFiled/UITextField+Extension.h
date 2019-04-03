//
//  UITextField+Extension.h
//  HXBaseProjectDemo
//
//  Created by lying on 17/8/25.
//  Copyright © 2017年 段冲冲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)
/**
 限制textfiled的字符长度
 @param LimitCharacter 长度最大值
 */
- (void)LimitCharacterWithInteger:(NSInteger )LimitCharacter;
- (BOOL)isphone:(NSString *)phoneNumber;

@end
