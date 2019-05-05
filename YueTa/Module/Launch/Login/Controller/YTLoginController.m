//
//  YTLoginController.m
//  YueTa
//
//  Created by 姚兜兜 on 2018/12/24.
//  Copyright © 2018 姚兜兜. All rights reserved.
//

#import "YTLoginController.h"
#import "MZYTextField+LoginUtils.h"
#import "UserInterface.h"

#import "YTRegisterController.h"
#import "YTSetPasswordController.h"

@interface YTLoginController ()<UITextFieldDelegate>

@property (nonatomic, strong) MZYTextField *phoneField;
@property (nonatomic, strong) MZYTextField *codeField;

@end

@implementation YTLoginController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createContentView];
    
}

#pragma mark - UI
- (void)createContentView {
    
    // 背景上半部分 渐变色
    CAGradientLayer *topLayer = [CAGradientLayer layer];
    topLayer.locations = @[@0.0, @1.0];
    topLayer.startPoint = CGPointMake(0, 0);
    topLayer.endPoint = CGPointMake(0, 1.0);
    topLayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight/2);
    topLayer.colors = @[(__bridge id)RGB(27, 11, 118).CGColor,(__bridge id)RGB(170, 97, 211).CGColor,];
    [self.view.layer addSublayer:topLayer];
    
    // 背景下半部分 渐变色
    CAGradientLayer *bottomLayer = [CAGradientLayer layer];
    bottomLayer.locations = @[@0.0, @1.0];
    bottomLayer.startPoint = CGPointMake(0, 0);
    bottomLayer.endPoint = CGPointMake(0, 1.0);
    bottomLayer.frame = CGRectMake(0, kScreenHeight/2, kScreenWidth, kScreenHeight/2);
    bottomLayer.colors = @[(__bridge id)RGB(170, 97, 211).CGColor, (__bridge id)RGB(246, 204, 167).CGColor];
    [self.view.layer addSublayer:bottomLayer];
    
    
    CGFloat width = kScreenWidth-kRealValue(100);
    
    // 手机号码输入框
    self.phoneField = [MZYTextField MZYTextFieldInitWithFrame:CGRectMake(kRealValue(50), kNavBarHeight+kRealValue(100), width, kRealValue(45)) imageString:@"" placeholder:@"手机号码"];
    self.phoneField.layer.masksToBounds = YES;
    self.phoneField.layer.cornerRadius = self.phoneField.height/2;
    self.phoneField.delegate = self;
    [self.view addSubview:self.phoneField];
    
    // 验证码输入框
    self.codeField = [MZYTextField MZYTextFieldInitWithFrame:CGRectMake(kRealValue(50), self.phoneField.bottom+kRealValue(30), width, kRealValue(45)) imageString:@"" placeholder:@"密码"];
    self.codeField.layer.masksToBounds = YES;
    self.codeField.layer.cornerRadius = self.codeField.height/2;
    self.codeField.delegate = self;
    [self.view addSubview:self.codeField];
    
    // 去注册
    UIButton *registerBtn = [UIButton buttonWithTitle:@"还没账号？去注册" taget:self action:@selector(registerButtonClick:) font:kSystemFont13 titleColor:kWhiteTextColor];
    registerBtn.frame = CGRectMake(self.phoneField.x, self.codeField.bottom+kRealValue(20), width/2, kRealValue(20));
    registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:registerBtn];
    
    // 忘记密码
    UIButton *forgetBtn = [UIButton buttonWithTitle:@"忘记密码" taget:self action:@selector(forgetButtonClick:) font:kSystemFont13 titleColor:kWhiteTextColor];
    forgetBtn.frame = CGRectMake(registerBtn.right, self.codeField.bottom+kRealValue(20), width/2, kRealValue(20));
    forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.view addSubview:forgetBtn];
    
    // 登录按钮
    UIButton *loginBtn = [UIButton buttonWithTitle:@"登录" taget:self action:@selector(loginButtonClick:) font:kSystemFont15 titleColor:kWhiteTextColor];
    loginBtn.frame = CGRectMake(self.codeField.x, forgetBtn.bottom+kRealValue(40), width, kRealValue(45));
    loginBtn.layer.cornerRadius = loginBtn.height/2;
    loginBtn.layer.masksToBounds = YES;
    
    // 登录按钮渐变色
    CAGradientLayer *btnLayer = [CAGradientLayer layer];
    btnLayer.locations = @[@0.5];
    btnLayer.startPoint = CGPointMake(0, 0);
    btnLayer.endPoint = CGPointMake(1.0, 0.0);
    btnLayer.frame = loginBtn.frame;
    btnLayer.cornerRadius = loginBtn.height/2;
    btnLayer.masksToBounds = YES;
    btnLayer.colors = @[(__bridge id)RGB(244, 175, 160).CGColor, (__bridge id)RGB(238, 113, 150).CGColor];
    [self.view.layer addSublayer:btnLayer];
    [self.view addSubview:loginBtn];
    
    UILabel *thirdLab = [UILabel labelWithName:@"第三方登录" Font:kSystemFont15 textColor:kWhiteTextColor textAlignment:NSTextAlignmentCenter];
    thirdLab.frame = CGRectMake(0, loginBtn.bottom+kRealValue(100), kScreenWidth, kRealValue(20));
    [self.view addSubview:thirdLab];
    
    // 微信登录
    UIButton *wechatBtn = [UIButton buttonWithTitle:@"微信登录" taget:self action:@selector(wechatLogin) font:kSystemFont13 titleColor:kWhiteTextColor];
    wechatBtn.frame = CGRectMake(0, thirdLab.bottom+kRealValue(20), kRealValue(50), kRealValue(80));
    wechatBtn.centerX = kScreenWidth/2-kRealValue(50);
    [wechatBtn setImage:KimageName(@"ic_wx") forState:UIControlStateNormal];
    [wechatBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, kRealValue(30), 0)];
    [wechatBtn setTitleEdgeInsets:UIEdgeInsetsMake(kRealValue(50), -kRealValue(90), 0, 0)];
   // [self.view addSubview:wechatBtn];
     
    // QQ登录
    UIButton *QQBtn = [UIButton buttonWithTitle:@"QQ登录" taget:self action:@selector(QQLogin) font:kSystemFont13 titleColor:kWhiteTextColor];
    QQBtn.frame = CGRectMake(0, thirdLab.bottom+kRealValue(20), kRealValue(50), kRealValue(80));
    QQBtn.centerX = kScreenWidth/2+kRealValue(50);
    [QQBtn setImage:KimageName(@"ic_qq") forState:UIControlStateNormal];
    [QQBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, kRealValue(30), 0)];
    [QQBtn setTitleEdgeInsets:UIEdgeInsetsMake(kRealValue(50), -kRealValue(90), 0, 0)];
   // [self.view addSubview:QQBtn];
    
}

#pragma mark - events
- (void)registerButtonClick:(UIButton *)sender {// 注册
    YTRegisterController *vc = [[YTRegisterController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)forgetButtonClick:(UIButton *)sender {// 忘记密码
    YTSetPasswordController *vc = [[YTSetPasswordController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loginButtonClick:(UIButton *)sender {// 登录
    if (![self.phoneField.text checkTelNumber]) {
        [self.view showAutoHideHudWithText:@"请输入正确的手机号"];
        return;
    }
    if (!self.codeField.text.length) {
        [self.view showAutoHideHudWithText:@"请输入密码"];
        return;
    }
    
    [self.view showIndeterminateHudWithText:nil];
    [UserInterface loginWithMobileMobile:self.phoneField.text password:self.codeField.text andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage, NSDictionary * _Nonnull responseDataDic) {
        [self.view hideHud];
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            // 成功登录
            [[UserInfoManager sharedInstance] saveUserInfo:responseDataDic];
            [self turnToMainTabBarViewController];
        }
    }];
}

- (void)wechatLogin {// 微信登录 暂不用实现
    NSLog(@"微信登录");
}

- (void)QQLogin {// QQ登录 暂不用实现
    NSLog(@"QQ登录");
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    /* 手机号码不能超过8位，验证码不能超过8位字符长度 */
    if (textField == self.phoneField) {
        if (string.length == 0) return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    
    if (textField == self.codeField) {
        if (string.length == 0) return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 16) {
            return NO;
        }
    }
    
    return YES;
}

@end
