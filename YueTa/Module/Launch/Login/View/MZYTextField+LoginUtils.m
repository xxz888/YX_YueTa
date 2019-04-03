//
//  MZYTextField+LoginUtils.m
//  ManZhiYan
//
//  Created by 姚兜兜 on 2018/3/5.
//  Copyright © 2018年 姚兜兜. All rights reserved.
//

#import "MZYTextField+LoginUtils.h"

@implementation MZYTextField (LoginUtils)

+ (MZYTextField *)MZYTextFieldInitWithFrame:(CGRect)frame imageString:(NSString *)imageString placeholder:(NSString *)placeholder
{
    MZYTextField *textField = [[MZYTextField alloc] init];
    textField.textColor = kBlackTextColor;
    textField.font = kSystemFont15;
    textField.frame = frame;
    textField.backgroundColor = kWhiteBackgroundColor;
    textField.placeholder = placeholder;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [textField setValue:kPlaceholderGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:kSystemFont15 forKeyPath:@"_placeholderLabel.font"];
    
    UIImageView *leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(10), 0, kRealValue(20), kRealValue(20))];
    leftImg.contentMode = UIViewContentModeScaleAspectFit;
    leftImg.image = [UIImage imageNamed:imageString];
    textField.leftView = leftImg;
    textField.leftViewMode = UITextFieldViewModeAlways;
    if (!imageString.length) {
        leftImg.width = 0;
    }

    return textField;
}

@end
