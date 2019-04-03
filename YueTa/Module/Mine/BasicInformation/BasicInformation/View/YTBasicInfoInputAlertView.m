//
//  YTAgeInputAlertView.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/10.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTBasicInfoInputAlertView.h"

@interface YTBasicInfoInputAlertView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) BasicInfoInputBlock basicInfoInputBlock;

@end

@implementation YTBasicInfoInputAlertView

+ (void)showAlertViewWithPlaceHolder:(NSString *)placeholder
                   inputConfirmBlock:(BasicInfoInputBlock)block {
    YTBasicInfoInputAlertView *view = [[YTBasicInfoInputAlertView alloc] initWithFrame:kMainScreen_Bounds];
    view.basicInfoInputBlock = block;
    view.placeholder = placeholder;
    [kAppWindow addSubview:view];
    [view show];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_setupSubViews];
    }
    return self;
}

- (void)p_setupSubViews {
    UIView *maskView = [[UIView alloc] initWithFrame:kMainScreen_Bounds];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0;
    [self addSubview:maskView];
    _maskView = maskView;
    
    CGFloat containerViewW = kRealValue(280);
    CGFloat containerViewH = kRealValue(190);
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - containerViewW/2, kScreenHeight, containerViewW, containerViewH)];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.layer.cornerRadius = 5;
    [self addSubview:containerView];
    _containerView = containerView;
    
    CGFloat textFieldW = kRealValue(240);
    CGFloat textFieldH = kRealValue(50);
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(containerViewW/2 - textFieldW/2, kRealValue(50), textFieldW, textFieldH)];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    NSAttributedString *attri = [[NSAttributedString alloc] initWithString:@"请输入年龄" attributes:@{NSForegroundColorAttributeName:kGrayTextColor,NSFontAttributeName:kSystemFont15, NSParagraphStyleAttributeName:style}];
    textField.attributedPlaceholder = attri;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.textColor = kBlackTextColor;
    textField.font = kSystemFont15;
    textField.delegate = self;
    textField.layer.cornerRadius = 8;
    textField.backgroundColor = kMineGrayBackgroundColor;
    [_containerView addSubview:textField];
    _textField = textField;
    
    CGFloat buttonW = kRealValue(100);
    CGFloat buttonH = kRealValue(30);
    UIButton *cancelButton = [UIButton buttonWithTitle:@"取消" taget:self action:@selector(cancelButtonClicked) font:kSystemFont15 titleColor:kPurpleTextColor];
    cancelButton.frame = CGRectMake(containerViewW/2 - buttonW, textField.maxY + kRealValue(30), buttonW, buttonH);
    [_containerView addSubview:cancelButton];

    UIButton *confirmButton = [UIButton buttonWithTitle:@"确定" taget:self action:@selector(confirmButtonClicked) font:kSystemFont15 titleColor:kPurpleTextColor];
    confirmButton.frame = CGRectMake(containerViewW/2, textField.maxY + kRealValue(30), buttonW, buttonH);
    [_containerView addSubview:confirmButton];
}

- (void)show {
    [UIView animateWithDuration:0.4 animations:^{
        self.maskView.alpha = 0.6;
        self.containerView.centerY = self.centerY;
    }];
}

- (void)dissmiss {
    [UIView animateWithDuration:0.4 animations:^{
        self.maskView.alpha = 0;
        self.containerView.y = kScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - **************** Event Response
- (void)confirmButtonClicked {
    if (!self.textField.text.length) {
        [kAppWindow showAutoHideHudWithText:self.placeholder];
        return;
    }
    
    if (self.basicInfoInputBlock) {
        self.basicInfoInputBlock(self.textField.text);
    }
    [self dissmiss];
}

- (void)cancelButtonClicked {
    [self dissmiss];
}

#pragma mark - **************** UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.textField.placeholder = placeholder;
}

@end
