//
//  YTRegisterController.m
//  YueTa
//
//  Created by 姚兜兜 on 2018/12/24.
//  Copyright © 2018 姚兜兜. All rights reserved.
//

#import "YTRegisterController.h"
#import "MZYTextField+LoginUtils.h"
#import "YTAgePicker.h"
#import "JKCountDownButton.h"
#import "UserInterface.h"

#import "YTCompleteInfoController.h"

@interface YTRegisterController ()

@property (nonatomic, strong) MZYTextField *mobileField;
@property (nonatomic, strong) MZYTextField *codeField;
@property (nonatomic, strong) MZYTextField *passwordField;
@property (nonatomic, strong) JKCountDownButton *countDownButton;


@end

@implementation YTRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationBarTitle:@"注册"];
    
    [self createContentView];
}

#pragma mark - events
- (void)getCode:(JKCountDownButton *)button {
    
    [self.view endEditing:YES];
    
    if (!self.mobileField.text.length) {
        [self.view showAutoHideHudWithText:@"手机号不能为空"];
        return;
    }
    if (![self.mobileField.text checkTelNumber]) {
        [self.view showAutoHideHudWithText:@"手机号格式不正确"];
        return;
    }
    button.enabled = NO;
    [self.view showIndeterminateHudWithText:@"正在发送"];
    [UserInterface sendVerificationCodeWithMobile:self.mobileField.text andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage) {
        [self.view showAutoHideHudWithText:@"发送成功"];
        if ([rspStatusAndMessage.message isEqualToString:@"发送成功"]) {
            [button startWithSecond:60];
            [button didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
                NSString *title = [NSString stringWithFormat:@"%ds",second];
                return title;
            }];
            [button didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                countDownButton.enabled = YES;
                return @"重新获取";
            }];
        } else {
            button.enabled = YES;
        }
    }];
}


- (void)continueButtonClick {
    
    [self.view endEditing:YES];
    
    if (!self.mobileField.text.length) {
        [self.view showAutoHideHudWithText:@"手机号不能为空"];
        return;
    }
    if (![self.mobileField.text checkTelNumber]) {
        [self.view showAutoHideHudWithText:@"手机号格式不正确"];
        return;
    }
    if (!self.codeField.text.length) {
        [self.view showAutoHideHudWithText:@"验证码不能为空"];
        return;
    }
    if (!self.passwordField.text.length) {
        [self.view showAutoHideHudWithText:@"密码不能为空"];
        return;
    }
    if (self.passwordField.text.length < 6 || self.passwordField.text.length > 16) {
        [self.view showAutoHideHudWithText:@"密码长度为6至16位"];
        return;
    }
    
    [self.view showIndeterminateHudWithText:nil];
    [UserInterface registerWithMobile:self.mobileField.text sms_code:self.codeField.text password:self.passwordField.text andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage) {
        [self.view hideHud];
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            YTCompleteInfoController *vc = [[YTCompleteInfoController alloc] init];
            vc.mobile = self.mobileField.text;
            vc.password = self.passwordField.text;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
}

#pragma mark - UI
- (void)createContentView {
    
    // 注册手机号
    UILabel *mobileLab = [UILabel labelWithName:@"注册账号" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    mobileLab.frame = CGRectMake(kRealValue(20), kRealValue(20), kRealValue(80), kRealValue(30));
    [self.view addSubview:mobileLab];
    
    _mobileField = [MZYTextField MZYTextFieldInitWithFrame:CGRectMake(mobileLab.right, 0, kScreenWidth-kRealValue(40)-mobileLab.width, kRealValue(30)) imageString:@"" placeholder:@"请输入手机号码"];
    _mobileField.backgroundColor = kGrayBackgroundColor;
    _mobileField.centerY = mobileLab.centerY;
    _mobileField.layer.cornerRadius = _mobileField.height/2;
    _mobileField.layer.masksToBounds = YES;
    [self.view addSubview:_mobileField];
    
    // 验证码
    UILabel *codeLab = [UILabel labelWithName:@"验证码" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    codeLab.frame = CGRectMake(kRealValue(20), mobileLab.bottom+kRealValue(20), kRealValue(80), kRealValue(30));
    [self.view addSubview:codeLab];
    
    _codeField = [MZYTextField MZYTextFieldInitWithFrame:CGRectMake(mobileLab.right, 0, kScreenWidth-kRealValue(40)-mobileLab.width-kRealValue(100), kRealValue(30)) imageString:@"" placeholder:@"请输入验证码"];
    _codeField.backgroundColor = kGrayBackgroundColor;
    _codeField.centerY = codeLab.centerY;
    _codeField.layer.cornerRadius = _mobileField.height/2;
    _codeField.layer.masksToBounds = YES;
    [self.view addSubview:_codeField];
    
    // 获取验证码按钮
    _countDownButton = [[JKCountDownButton alloc] init];
    [_countDownButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_countDownButton setTitleColor:kWhiteTextColor forState:UIControlStateNormal];
    [_countDownButton setTitleColor:kWhiteTextColor forState:UIControlStateDisabled];
    _countDownButton.titleLabel.font = kSystemFont13;
    [_countDownButton addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
    self.countDownButton.frame = CGRectMake(kScreenWidth-kRealValue(110), _codeField.y, kRealValue(100), _codeField.height);
    
    
    CAGradientLayer *downLayer = [CAGradientLayer layer];
    downLayer.locations = @[@0.5];
    downLayer.startPoint = CGPointMake(0, 0);
    downLayer.endPoint = CGPointMake(1.0, 0.0);
    downLayer.frame = _countDownButton.frame;
    downLayer.cornerRadius = _countDownButton.height/2;
    downLayer.masksToBounds = YES;
    downLayer.colors = @[(__bridge id)RGB(134, 177, 230).CGColor,(__bridge id)RGB(192, 164, 234).CGColor,];
    downLayer.cornerRadius = _countDownButton.height/2;
    downLayer.masksToBounds = YES;
    [self.view.layer addSublayer:downLayer];
    [self.view addSubview:self.countDownButton];
    
    // 密码
    UILabel *passwordLab = [UILabel labelWithName:@"密码" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    passwordLab.frame = CGRectMake(kRealValue(20), codeLab.bottom+kRealValue(20), kRealValue(80), kRealValue(30));
    [self.view addSubview:passwordLab];
    
    _passwordField = [MZYTextField MZYTextFieldInitWithFrame:CGRectMake(mobileLab.right, 0, kScreenWidth-kRealValue(40)-mobileLab.width, kRealValue(30)) imageString:@"" placeholder:@"请输入密码"];
    _passwordField.backgroundColor = kGrayBackgroundColor;
    _passwordField.centerY = passwordLab.centerY;
    _passwordField.layer.cornerRadius = _passwordField.height/2;
    _passwordField.layer.masksToBounds = YES;
    [self.view addSubview:_passwordField];

    //继续按钮
    UIButton *continueBtn = [UIButton buttonWithTitle:@"继续" taget:self action:@selector(continueButtonClick) font:kSystemFont15 titleColor:kWhiteTextColor];
    continueBtn.frame = CGRectMake(kRealValue(20), kScreenHeight-kNavBarHeight-kRealValue(150), kScreenWidth-kRealValue(40), kRealValue(45));
    continueBtn.layer.cornerRadius = continueBtn.height/2;
    continueBtn.layer.masksToBounds = YES;
    
    // 登录按钮渐变色
    CAGradientLayer *btnLayer = [CAGradientLayer layer];
    btnLayer.locations = @[@0.5];
    btnLayer.startPoint = CGPointMake(0, 0);
    btnLayer.endPoint = CGPointMake(1.0, 0.0);
    btnLayer.frame = continueBtn.frame;
    btnLayer.cornerRadius = continueBtn.height/2;
    btnLayer.masksToBounds = YES;
    btnLayer.colors = @[(__bridge id)RGB(134, 177, 230).CGColor,(__bridge id)RGB(192, 164, 234).CGColor,];
    btnLayer.cornerRadius = continueBtn.height/2;
    btnLayer.masksToBounds = YES;
    [self.view.layer addSublayer:btnLayer];
    [self.view addSubview:continueBtn];
    
}




@end
