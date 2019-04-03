//
//  YTSetPasswordController.m
//  YueTa
//
//  Created by 姚兜兜 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTSetPasswordController.h"
#import "MZYTextField.h"
#import "JKCountDownButton.h"
#import "UserInterface.h"

@interface YTSetPasswordController ()

@property (nonatomic, strong) MZYTextField *phoneField;
@property (nonatomic, strong) MZYTextField *codeField;
@property (nonatomic, strong) JKCountDownButton *countDownButton;
@property (nonatomic, strong) MZYTextField *passwordField;


@end

@implementation YTSetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationBarTitle:@"设置密码"];
    
    [self createContentView];
}

#pragma mark - request
- (void)getCode:(JKCountDownButton *)button {
    [self.view endEditing:YES];
    NSString *mobile;
    if (self.phoneStr.length) {
        mobile = self.phoneStr;
    } else {
        mobile = self.phoneField.text;
    }
    if (!mobile.length) {
        [self.view showAutoHideHudWithText:@"手机号不能为空"];
        return;
    }
    if (![mobile checkTelNumber]) {
        [self.view showAutoHideHudWithText:@"手机号格式不正确"];
        return;
    }
    button.enabled = NO;
    [self.view showIndeterminateHudWithText:@"正在发送"];
    [UserInterface sendVerificationCodeWithMobile:mobile andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage) {
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

- (void)sureButtonClick {

}

#pragma mark - UI
- (void)createContentView {
    
    _phoneField = [[MZYTextField alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(50))];
    _phoneField.placeholder = @"手机号";
    [self.view addSubview:_phoneField];
    if (self.phoneStr.length) {
        _phoneField.text = [self.phoneStr centerSecretStringValue];
        _phoneField.enabled = NO;
    }
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, _phoneField.bottom, kScreenWidth, 0.5)];
    line1.backgroundColor = kSepLineGrayBackgroundColor;
    [self.view addSubview:line1];
    
    _codeField = [[MZYTextField alloc] initWithFrame:CGRectMake(0, line1.bottom, kScreenWidth-kRealValue(120), kRealValue(50))];
    _codeField.placeholder = @"验证码";
    [self.view addSubview:_codeField];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, _codeField.bottom, kScreenWidth, 0.5)];
    line2.backgroundColor = kSepLineGrayBackgroundColor;
    [self.view addSubview:line2];
    
    _countDownButton = [[JKCountDownButton alloc] init];
    [_countDownButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_countDownButton setTitleColor:RGB(184, 152, 119) forState:UIControlStateNormal];
    [_countDownButton setTitleColor:kGrayTextColor forState:UIControlStateDisabled];
    _countDownButton.titleLabel.font = kSystemFont13;
    [_countDownButton addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
    self.countDownButton.frame = CGRectMake(kScreenWidth-kRealValue(110), _codeField.y, kRealValue(100), _codeField.height);
    [self.view addSubview:self.countDownButton];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, _codeField.bottom, kScreenWidth, 0.5)];
    line3.backgroundColor = kSepLineGrayBackgroundColor;
    [self.view addSubview:line3];
    
    _passwordField = [[MZYTextField alloc] initWithFrame:CGRectMake(0, line3.bottom, kScreenWidth, kRealValue(50))];
    _passwordField.placeholder = @"请输入新密码";
    [self.view addSubview:_passwordField];
    
    //继续按钮
    UIButton *sureBtn = [UIButton buttonWithTitle:@"确认" taget:self action:@selector(sureButtonClick) font:kSystemFont15 titleColor:kWhiteTextColor];
    sureBtn.frame = CGRectMake(kRealValue(20), _passwordField.bottom+kRealValue(100), kScreenWidth-kRealValue(40), kRealValue(45));
    sureBtn.layer.cornerRadius = sureBtn.height/2;
    sureBtn.layer.masksToBounds = YES;
    
    // 登录按钮渐变色
    CAGradientLayer *btnLayer = [CAGradientLayer layer];
    btnLayer.locations = @[@0.5];
    btnLayer.startPoint = CGPointMake(0, 0);
    btnLayer.endPoint = CGPointMake(1.0, 0.0);
    btnLayer.frame = sureBtn.frame;
    btnLayer.cornerRadius = sureBtn.height/2;
    btnLayer.masksToBounds = YES;
    btnLayer.colors = @[(__bridge id)RGB(134, 177, 230).CGColor,(__bridge id)RGB(192, 164, 234).CGColor,];
    btnLayer.cornerRadius = sureBtn.height/2;
    btnLayer.masksToBounds = YES;
    [self.view.layer addSublayer:btnLayer];
    [self.view addSubview:sureBtn];
}


@end
