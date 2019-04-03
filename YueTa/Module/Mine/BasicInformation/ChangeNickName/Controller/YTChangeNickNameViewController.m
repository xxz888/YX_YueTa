//
//  YTChangeNickNameViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/10.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTChangeBasicInfoInputViewController.h"

@interface YTChangeBasicInfoInputViewController ()<UITextFieldDelegate>

@end

@implementation YTChangeBasicInfoInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kMineBackgroundColor;
    [self setupRightBarButtonItem];
    [self setupSubViews];
}

- (void)setupRightBarButtonItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" titleColor:[UIColor whiteColor] target:self action:@selector(rightBarButtonItemClicked)];
}

- (void)setupSubViews {
    UIView *nickNameView = [[UIView alloc] init];
    nickNameView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nickNameView];
    [nickNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.view);
        make.height.equalTo(@kRealValue(50));
    }];
    
    UITextField *textField = [[UITextField alloc] init];
    textField = [[UITextField alloc] init];
    textField.placeholder = self.placeholder;
    [textField setValue:kGrayTextColor forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:kSystemFont15 forKeyPath:@"_placeholderLabel.font"];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.textColor = kBlackTextColor;
    textField.font = kSystemFont15;
    textField.delegate = self;
    [nickNameView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nickNameView).offset(kRealValue(15));
        make.right.equalTo(nickNameView).offset(kRealValue(15));
        make.top.and.bottom.equalTo(nickNameView);
    }];
}

- (void)rightBarButtonItemClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
