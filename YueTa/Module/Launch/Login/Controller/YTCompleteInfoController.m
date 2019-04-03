//
//  YTPerfectInfoController.m
//  YueTa
//
//  Created by 姚兜兜 on 2019/1/10.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTCompleteInfoController.h"
#import "MZYTextField+LoginUtils.h"
#import "YTAgePicker.h"
#import "UserInterface.h"

#import "YTAllInfoViewController.h"

@interface YTCompleteInfoController ()

@property (nonatomic, strong) UIImageView *portrait;
@property (nonatomic, strong) MZYTextField *nameField;

@property (nonatomic, strong) CAGradientLayer *femaleLayer;
@property (nonatomic, strong) CAGradientLayer *maleLayer;

@property (nonatomic, strong) UIButton *ageBtn;
@property (nonatomic, strong) UIButton *curSexBtn; //当前性别按钮


@end

@implementation YTCompleteInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationBarTitle:@"完善信息"];
    
    [self createContentView];
}

#pragma mark - events
- (void)sexButtonClick:(UIButton *)sender {
    
    if (sender == self.curSexBtn) {
        return;
    }
    
    [self.curSexBtn setTitleColor:kBlackTextColor forState:UIControlStateNormal];
    [sender setTitleColor:kWhiteTextColor forState:UIControlStateNormal];
    
    if (sender.tag == 0) {
        self.femaleLayer.hidden = YES;
        self.maleLayer.hidden = NO;
    } else {
        self.maleLayer.hidden = YES;
        self.femaleLayer.hidden = NO;
    }
    
    self.curSexBtn = sender;
}

- (void)ageButtonClick:(UIButton *)sender {
    @weakify(self)
    [YTAgePicker agePickerViewAndBlock:^(NSInteger selectRow, NSString * _Nonnull text) {
        @strongify(self)
        [self.ageBtn setTitle:text forState:UIControlStateNormal];
    }];
}

- (void)continueButtonClick {
    [self.view endEditing:YES];
    
    if (!self.nameField.text.length) {
        [self.view showAutoHideHudWithText:@"昵称不能为空"];
        return;
    }
    if (self.nameField.text.length > 10) {
        [self.view showAutoHideHudWithText:@"昵称不能10个字符"];
        return;
    }
    
    NSInteger sex = 0;
    if ([[self.curSexBtn currentTitle] isEqualToString:@"女"]) {
        sex = 1;
    }
    
    NSInteger age = [self.ageBtn currentTitle].integerValue;
    
    
    YTAllInfoViewController *vc = [[YTAllInfoViewController alloc] init];
    vc.mobile = self.mobile;
    vc.password = self.password;
    vc.gender = sex;
    vc.age = age;
    vc.username = self.nameField.text;
    [self.navigationController pushViewController:vc animated:YES];
    
//    [self.view showIndeterminateHudWithText:nil];
//    [UserInterface completeUserInfoWithMobile:self.mobile username:self.nameField.text gender:sex age:age andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage) {
//        [self.view hideHud];
//        if (rspStatusAndMessage.code == kResponseSuccessCode) {
//
//        }
//    }];

    
}

#pragma mark - UI
- (void)createContentView {
    
    UIImageView *portrait = [[UIImageView alloc] initWithImage:KimageName(@"")];
    portrait.frame = CGRectMake(0, kRealValue(30), kRealValue(80), kRealValue(80));
    portrait.centerX = kScreenWidth/2;
    _portrait = portrait;
    [self.view addSubview:portrait];
    portrait.hidden = YES;//暂时隐藏，不上传头像
    
    // 昵称
    UILabel *nameLab = [UILabel labelWithName:@"昵称" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    nameLab.frame = CGRectMake(kRealValue(20), portrait.bottom+kRealValue(20), kRealValue(80), kRealValue(30));
    [self.view addSubview:nameLab];
    
    _nameField = [MZYTextField MZYTextFieldInitWithFrame:CGRectMake(nameLab.right, 0, kScreenWidth-kRealValue(40)-portrait.width, kRealValue(30)) imageString:@"" placeholder:@"昵称不可超过10个字符"];
    _nameField.backgroundColor = kGrayBackgroundColor;
    _nameField.centerY = nameLab.centerY;
    _nameField.layer.cornerRadius = _nameField.height/2;
    _nameField.layer.masksToBounds = YES;
    [self.view addSubview:_nameField];
    
    // 性别
    UILabel *sexLab = [UILabel labelWithName:@"性别" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    sexLab.frame = CGRectMake(kRealValue(20), nameLab.bottom+kRealValue(20), kRealValue(80), kRealValue(30));
    [self.view addSubview:sexLab];
    
    UIButton *maleBtn = [UIButton buttonWithTitle:@"男" taget:self action:@selector(sexButtonClick:) font:kSystemFont15 titleColor:kWhiteTextColor];
    maleBtn.frame = CGRectMake(sexLab.right, 0, kRealValue(80), kRealValue(30));
    maleBtn.tag = 0;
    maleBtn.centerY = sexLab.centerY;
    maleBtn.layer.borderColor = kGrayBorderColor.CGColor;
    maleBtn.layer.borderWidth = 1.f;
    maleBtn.layer.masksToBounds = YES;
    maleBtn.layer.cornerRadius = maleBtn.height/2;
    self.curSexBtn = maleBtn;
    
    CAGradientLayer *maleLayer = [CAGradientLayer layer];
    maleLayer.locations = @[@0.5];
    maleLayer.startPoint = CGPointMake(0, 0);
    maleLayer.endPoint = CGPointMake(1.0, 0.0);
    maleLayer.frame = maleBtn.frame;
    maleLayer.colors = @[(__bridge id)RGB(134, 177, 230).CGColor,(__bridge id)RGB(192, 164, 234).CGColor,];
    maleLayer.cornerRadius = maleBtn.height/2;
    maleLayer.masksToBounds = YES;
    self.maleLayer = maleLayer;
    [self.view.layer addSublayer:maleLayer];
    [self.view addSubview:maleBtn];
    
    UIButton *femaleBtn = [UIButton buttonWithTitle:@"女" taget:self action:@selector(sexButtonClick:) font:kSystemFont15 titleColor:kBlackTextColor];
    femaleBtn.frame = CGRectMake(kScreenWidth-kRealValue(20)-kRealValue(80), 0, kRealValue(80), kRealValue(30));
    femaleBtn.tag = 1;
    femaleBtn.layer.borderColor = kGrayBorderColor.CGColor;
    femaleBtn.layer.borderWidth = 1.f;
    femaleBtn.layer.masksToBounds = YES;
    femaleBtn.layer.cornerRadius = femaleBtn.height/2;
    femaleBtn.centerY = sexLab.centerY;
    
    CAGradientLayer *femaleLayer = [CAGradientLayer layer];
    femaleLayer.locations = @[@0.5];
    femaleLayer.startPoint = CGPointMake(0, 0);
    femaleLayer.endPoint = CGPointMake(1.0, 0.0);
    femaleLayer.frame = femaleBtn.frame;
    femaleLayer.colors = @[(__bridge id)RGB(134, 177, 230).CGColor,(__bridge id)RGB(192, 164, 234).CGColor,];
    femaleLayer.cornerRadius = femaleBtn.height/2;
    femaleLayer.masksToBounds = YES;
    femaleLayer.hidden = YES;
    self.femaleLayer = femaleLayer;
    [self.view.layer addSublayer:femaleLayer];
    [self.view addSubview:femaleBtn];
    
    // 年龄
    UILabel *ageLab = [UILabel labelWithName:@"年龄" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    ageLab.frame = CGRectMake(kRealValue(20), sexLab.bottom+kRealValue(20), kRealValue(80), kRealValue(30));
    [self.view addSubview:ageLab];
    
    _ageBtn = [UIButton buttonWithTitle:@"18" taget:self action:@selector(ageButtonClick:) font:kSystemFont15 titleColor:kBlackTextColor];
    _ageBtn.frame = CGRectMake(ageLab.right, 0, _nameField.width-kRealValue(50), _nameField.height);
    _ageBtn.centerY = ageLab.centerY;
    _ageBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.view addSubview:_ageBtn];
    
    UIImageView *arrow = [[UIImageView alloc] initWithImage:KimageName(@"age_arrow")];
    arrow.frame = CGRectMake(kScreenWidth-kRealValue(20)-kRealValue(30), 0, kRealValue(30), kRealValue(30));
    arrow.centerY = ageLab.centerY;
    [self.view addSubview:arrow];
    
    
    //完成按钮
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
