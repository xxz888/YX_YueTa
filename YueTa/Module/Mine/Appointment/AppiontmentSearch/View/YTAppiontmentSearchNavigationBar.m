//
//  YTAppiontmentSearchNavigationBar.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/7.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTAppiontmentSearchNavigationBar.h"

@interface YTAppiontmentSearchNavigationBar () <UITextFieldDelegate>

@end

@implementation YTAppiontmentSearchNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIButton *backButton = [UIButton buttonWithImage:@"ic_arrow_left_black" taget:self action:@selector(back)];
        backButton.frame = CGRectMake(0, kStatusBarHeight, 44, 44);
        [self addSubview:backButton];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(backButton.maxX, kStatusBarHeight, kScreenWidth - 60, 35)];
        textField.placeholder = @"输入位置或名称";
        [textField setValue:kGrayTextColor forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        textField.textColor = kGrayTextColor;
        textField.font = [UIFont systemFontOfSize:14];
        textField.layer.cornerRadius = 5;
        textField.backgroundColor = kMineGrayBackgroundColor;
        UIButton *view = [UIButton buttonWithImage:@"ic_search" taget:self action:@selector(search)];
        view.frame = CGRectMake(0, 0, 30, 30);
        textField.leftView = view;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.returnKeyType = UIReturnKeySearch;
        textField.delegate = self;
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:textField];
        
        UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(0, kNavBarHeight - 1, kScreenWidth, 1)];
        sepLine.backgroundColor = kSepLineGrayBackgroundColor;
        [self addSubview:sepLine];
    }
    return self;
}

- (void)search{};

- (void)back {
    if (self.delegate
        && [self.delegate respondsToSelector:@selector(cancelButtonDidTapped)] ) {
        [self.delegate cancelButtonDidTapped];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.delegate
        && [self.delegate respondsToSelector:@selector(searchButtonDidTapped:)]) {
        [self.delegate searchButtonDidTapped:textField.text];
    }
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (self.delegate
        && [self.delegate respondsToSelector:@selector(searchTextDidChange:)]) {
        [self.delegate searchTextDidChange:textField.text];
    }
}

@end
