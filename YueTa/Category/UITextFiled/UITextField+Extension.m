//
//  UITextField+Extension.m
//  HXBaseProjectDemo
//
//  Created by lying on 17/8/25.
//  Copyright © 2017年 段冲冲. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

- (void)LimitCharacterWithInteger:(NSInteger )LimitCharacter{
    NSString *toBeString = self.text;
    NSString *lang = [self.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"])// 简体中文输入
    {
        //获取高亮部分
        UITextRange *selectedRange = [self markedTextRange];
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            //没有高亮部分
            if (toBeString.length >= LimitCharacter) {
                self.text = [toBeString substringToIndex:LimitCharacter];
            }
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else {
        if (toBeString.length > LimitCharacter) {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:LimitCharacter];
            if (rangeIndex.length == 1) {
                self.text = [toBeString substringToIndex:LimitCharacter];
            } else {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, LimitCharacter)];
                self.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

#pragma mark --- 判断手机号是否有效
- (BOOL)isphone:(NSString *)phoneNumber
{
    NSInteger lenth = phoneNumber.length;
    if (lenth == 0 || lenth != 11) {
        return NO;
    }
    NSString *regex = @"^[1]+[3,4,5,7,8]+\\d{9}";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![identityCardPredicate evaluateWithObject:phoneNumber]) {
        return NO;
    }
    return YES;
}

@end
