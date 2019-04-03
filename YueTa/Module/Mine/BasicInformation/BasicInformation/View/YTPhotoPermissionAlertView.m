//
//  YTPhotoPermissionAlertView.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/10.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTPhotoPermissionAlertView.h"

@interface YTPhotoPermissionAlertView ()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, copy) ValueSelectBlock valueSelectBlock;

@end

@implementation YTPhotoPermissionAlertView

+ (void)showAlertViewValueSelectBlock:(ValueSelectBlock)block {
    YTPhotoPermissionAlertView *view = [[YTPhotoPermissionAlertView alloc] initWithFrame:kMainScreen_Bounds];
    view.valueSelectBlock = block;
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
    CGFloat containerViewH = kRealValue(250);
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - containerViewW/2, kScreenHeight, containerViewW, containerViewH)];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.layer.cornerRadius = 5;
    [self addSubview:containerView];
    _containerView = containerView;
    
    CGFloat buttonW = kRealValue(240);
    CGFloat buttonH = kRealValue(50);
    UIButton *publicButton = [UIButton buttonWithTitle:@"公开" taget:self action:@selector(publicButtonClicked) font:kSystemFont16 titleColor:kBlackTextColor];
    publicButton.backgroundColor = kMineGrayBackgroundColor;
    publicButton.frame = CGRectMake(containerViewW/2 - buttonW/2, kRealValue(35), buttonW, buttonH);
    publicButton.layer.cornerRadius = 25;
    [containerView addSubview:publicButton];
    
    UIButton *payButton = [UIButton buttonWithTitle:@"付费" taget:self action:@selector(payButtonClicked) font:kSystemFont16 titleColor:kBlackTextColor];
    payButton.backgroundColor = kMineGrayBackgroundColor;
    payButton.frame = CGRectMake(containerViewW/2 - buttonW/2, publicButton.maxY + kRealValue(20), buttonW, buttonH);
    payButton.layer.cornerRadius = 25;
    [containerView addSubview:payButton];
    
    UIButton *cancelButton = [UIButton buttonWithTitle:@"取消" taget:self action:@selector(cancelButtonClicked) font:kSystemFont16 titleColor:kPurpleTextColor];
    cancelButton.frame = CGRectMake(containerViewW/2 - buttonW/2, payButton.maxY + kRealValue(20), buttonW, buttonH);
    [containerView addSubview:cancelButton];
}

- (void)publicButtonClicked {
    if (self.valueSelectBlock) {
        self.valueSelectBlock(@"公开");
    }
    [self cancelButtonClicked];
}

- (void)payButtonClicked {
    if (self.valueSelectBlock) {
        self.valueSelectBlock(@"付费");
    }
    [self cancelButtonClicked];
}

- (void)cancelButtonClicked {
    [UIView animateWithDuration:0.4 animations:^{
        self.maskView.alpha = 0;
        self.containerView.y = kScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)show {
    [UIView animateWithDuration:0.4 animations:^{
        self.maskView.alpha = 0.6;
        self.containerView.centerY = self.centerY;
    }];
}

@end
