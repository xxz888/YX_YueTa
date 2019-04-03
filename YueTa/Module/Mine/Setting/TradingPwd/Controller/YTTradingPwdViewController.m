//
//  YTTradingPwdViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/20.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTTradingPwdViewController.h"

@interface YTTradingPwdViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *oldPwdTextField;
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) UITextField *confirmPwdTextField;

@end

@implementation YTTradingPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"交易密码"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"忘记密码" titleColor:kWhiteTextColor target:self action:@selector(forgetPwdClick)];
    
    //旧密码
    self.oldPwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(kRealValue(15), 0, kScreenWidth - kRealValue(30), kRealValue(50))];
    self.oldPwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.oldPwdTextField.textAlignment = NSTextAlignmentLeft;
    self.oldPwdTextField.textColor = kBlackTextColor;
    self.oldPwdTextField.font = kSystemFont15;
    self.oldPwdTextField.delegate = self;
    self.oldPwdTextField.placeholder = @"旧密码";
    [self.oldPwdTextField setValue:kPlaceholderGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.oldPwdTextField setValue:kSystemFont15 forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:self.oldPwdTextField];
    
    //分割线1
    UIView *sepLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.oldPwdTextField.maxY, kScreenWidth, 1)];
    sepLine1.backgroundColor = kSepLineGrayBackgroundColor;
    [self.view addSubview:sepLine1];
    
    //新密码
    self.pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(kRealValue(15), sepLine1.maxY, kScreenWidth - kRealValue(30), kRealValue(50))];
    self.pwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pwdTextField.textAlignment = NSTextAlignmentLeft;
    self.pwdTextField.textColor = kBlackTextColor;
    self.pwdTextField.font = kSystemFont15;
    self.pwdTextField.delegate = self;
    self.pwdTextField.placeholder = @"新密码";
    [self.pwdTextField setValue:kPlaceholderGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.pwdTextField setValue:kSystemFont15 forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:self.pwdTextField];
    
    //分割线2
    UIView *sepLine2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.pwdTextField.maxY, kScreenWidth, 1)];
    sepLine2.backgroundColor = kSepLineGrayBackgroundColor;
    [self.view addSubview:sepLine2];
    
    //确认新密码
    self.confirmPwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(kRealValue(15), sepLine2.maxY, kScreenWidth - kRealValue(30), kRealValue(50))];
    self.confirmPwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.confirmPwdTextField.textAlignment = NSTextAlignmentLeft;
    self.confirmPwdTextField.textColor = kBlackTextColor;
    self.confirmPwdTextField.font = kSystemFont15;
    self.confirmPwdTextField.delegate = self;
    self.confirmPwdTextField.placeholder = @"再次输入";
    [self.confirmPwdTextField setValue:kPlaceholderGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.confirmPwdTextField setValue:kSystemFont15 forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:self.confirmPwdTextField];
    
    //分割线3
    UIView *sepLine3 = [[UIView alloc] initWithFrame:CGRectMake(0, self.confirmPwdTextField.maxY, kScreenWidth, 1)];
    sepLine3.backgroundColor = kSepLineGrayBackgroundColor;
    [self.view addSubview:sepLine3];
    
    //确认按钮
    UIButton *sureBtn = [UIButton buttonWithTitle:@"确认" taget:self action:@selector(sureButtonClick) font:kSystemFont15 titleColor:kWhiteTextColor];
    sureBtn.frame = CGRectMake(kRealValue(20), sepLine3.bottom+kRealValue(100), kScreenWidth-kRealValue(40), kRealValue(45));
    sureBtn.layer.cornerRadius = sureBtn.height/2;
    sureBtn.layer.masksToBounds = YES;
    [self.view addSubview:sureBtn];

    // 登录按钮渐变色
    CAGradientLayer *btnLayer = [CAGradientLayer layer];
    btnLayer.locations = @[@0.5];
    btnLayer.startPoint = CGPointMake(0, 0);
    btnLayer.endPoint = CGPointMake(1.0, 0.0);
    btnLayer.frame = sureBtn.bounds;
    btnLayer.cornerRadius = 18;
    btnLayer.masksToBounds = YES;
    btnLayer.colors = @[(__bridge id)RGB(134, 172, 231).CGColor, (__bridge id)RGB(183, 163, 237).CGColor];
    [sureBtn.layer insertSublayer:btnLayer atIndex:0];
}

- (void)sureButtonClick {
    
}

- (void)forgetPwdClick {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
