//
//  YTCertificationCenterViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/14.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTCertificationCenterViewController.h"
#import "MineInterface.h"
#import "YTSelectPictureHelper.h"
#import <UIButton+WebCache.h>

@interface YTCertificationCenterViewController ()

/** 身份职业选择 */
@property (nonatomic, strong) UIView *segmentView;
@property (nonatomic, strong) UIButton *idAuthenticationButton;
@property (nonatomic, strong) UIButton *jobAuthenticationButton;

@property (nonatomic, strong) UIScrollView *scrollView;

/** 身份认证 */
@property (nonatomic, strong) UIView *idAuthView;
@property (nonatomic, strong) UIView *idAuthStyle1View;
@property (nonatomic, strong) UIView *idAuthStyle2View;
@property (nonatomic, strong) UIButton *idCardFrontButton;
@property (nonatomic, strong) UIButton *idCardBackButton;
@property (nonatomic, strong) UIButton *idCardSelfHandButton;
@property (nonatomic, strong) UILabel *identityBottomTipsLabel;
/** 身份认证已经提交 */
@property (nonatomic, strong) UIView *submitedIDCardView;
@property (nonatomic, strong) UIButton *submitedIdCardFrontButton;
@property (nonatomic, strong) UIButton *submitedIdCardBackButton;
@property (nonatomic, strong) UIButton *submitedIdCardSelfHandButton;
/** 身份认证失败原因 */
@property (nonatomic, strong) UIView *failedIDAuthReasonView;
@property (nonatomic, strong) UILabel *failedIDAuthReasonLabel;
/** 审核状态 */
@property (nonatomic, strong) UIView *authStateView;
@property (nonatomic, strong) UIImageView *authStateImageView;

/** 职业认证 */
@property (nonatomic, strong) UIView *jobAuthView;
@property (nonatomic, strong) UIButton *jobInfoButton1;
@property (nonatomic, strong) UIButton *jobInfoButton2;
@property (nonatomic, strong) UILabel *jobBottmTipsLabel;
/** 已提交职业认证 */
@property (nonatomic, strong) UIView *submitedJobAuthView;
@property (nonatomic, strong) UIImageView *submitedJobInfoImageView1;
@property (nonatomic, strong) UIImageView *submitedJobInfoImageView2;
/** 重新提交按钮 */
@property (nonatomic, strong) UIButton *resubmitButton;

@property (nonatomic, assign) NSInteger authType;
@property (nonatomic, strong) YTAuthStateModel *authStateModel;
/** 身份认证数据 */
@property (nonatomic, strong) UIImage *idCardFrontImage;
@property (nonatomic, strong) UIImage *idCardBackImage;
@property (nonatomic, strong) UIImage *idCardSelfHandImage;
/** 职业认证数据 */
@property (nonatomic, strong) UIImage *jobInfoImage1;
@property (nonatomic, strong) UIImage *jobInfoImage2;

@end

@implementation YTCertificationCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight);
    [self.view addSubview:self.scrollView];
    [self setupTitleSegmentView];
    [self setupidAuthStyle1View];
    [self setupidAuthStyle2View];
    [self setupIdentityBottomTipsLabel];
    [self setupAuthStateView];
    [self setupSubmitedIDCardView];
    [self setupFailedIDAuthReasonView];
    [self setupSubmitedJobAuthView];
    [self setupJobAuthView];
    [self setupPassTipsLabel];
    [self setupResubmitButton];
}

- (void)requestDataByType:(NSInteger)type {
    self.authType = type;
    [MineInterface getAuthStateByType:type andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage, YTAuthStateModel *authStateModel) {
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            self.authStateModel = authStateModel;
            
            if ([rspStatusAndMessage.message isEqualToString:@"未认证"]) {
                [self setupUnAuthScrollViewByType:type];
            } else {
                [self setupAuthScrollViewByType:type authStateModel:authStateModel];
            }
        }
    }];
}

//认证过程UI
- (void)setupAuthScrollViewByType:(NSInteger)type authStateModel:(YTAuthStateModel *)authStateModel {
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger state = authStateModel.status;
    if (type == 1) {
        //身份认证
        self.authStateView.y = 0;
        [self.scrollView addSubview:self.authStateView];
        
        self.submitedIDCardView.y = self.authStateView.maxY + kRealValue(10);
        [self.scrollView addSubview:self.submitedIDCardView];
        
        [self.submitedIdCardFrontButton sd_setImageWithURL:[NSURL URLWithString:authStateModel.photo_1] forState:UIControlStateNormal];
        
        [self.submitedIdCardBackButton sd_setImageWithURL:[NSURL URLWithString:authStateModel.photo_2] forState:UIControlStateNormal];
        
        [self.submitedIdCardSelfHandButton sd_setImageWithURL:[NSURL URLWithString:authStateModel.photo_3] forState:UIControlStateNormal];
        
        self.identityBottomTipsLabel.y = self.submitedIDCardView.maxY + kRealValue(10);
        [self.scrollView addSubview:self.identityBottomTipsLabel];
        
        self.scrollView.contentSize = CGSizeMake(0, self.identityBottomTipsLabel.maxY);
        
        if (state == 1) {
            self.authStateImageView.image = [UIImage imageNamed:@"ic_shen_success"];
        } else if (state == 2) {
            self.authStateImageView.image = [UIImage imageNamed:@"ic_shen_ing"];
        } else if (state == 3) {
            self.authStateImageView.image = [UIImage imageNamed:@"ic_shen_fail"];
            
            self.failedIDAuthReasonView.y = self.submitedIDCardView.maxY + kRealValue(10);
            self.failedIDAuthReasonLabel.text = [NSString stringWithFormat:@"失败原因：%@",authStateModel.reason];
            [self.failedIDAuthReasonLabel sizeToFit];
            [self.scrollView addSubview:self.failedIDAuthReasonView];
            
            self.identityBottomTipsLabel.y = self.failedIDAuthReasonView.maxY + kRealValue(10);

            self.resubmitButton.y = self.identityBottomTipsLabel.maxY + kRealValue(20);
            [self.scrollView addSubview:self.resubmitButton];
            
            self.scrollView.contentSize = CGSizeMake(0, self.resubmitButton.maxY);
        }
    } else {
        //职业认证
        self.authStateView.y = 0;
        [self.scrollView addSubview:self.authStateView];

        self.submitedJobAuthView.y = self.authStateView.maxY + kRealValue(10);
        [self.scrollView addSubview:self.submitedJobAuthView];
        
        [self.submitedJobInfoImageView1 sd_setImageWithURL:[NSURL URLWithString:authStateModel.photo_1]];
        
        [self.submitedJobInfoImageView2 sd_setImageWithURL:[NSURL URLWithString:authStateModel.photo_2]];
        
        if (state == 1) {
            self.authStateImageView.image = [UIImage imageNamed:@"ic_shen_success"];
            
            self.jobBottmTipsLabel.y = self.submitedJobAuthView.maxY + kRealValue(10);
            [self.scrollView addSubview:self.jobBottmTipsLabel];

            self.scrollView.contentSize = CGSizeMake(0, self.jobBottmTipsLabel.maxY);
        } else if (state == 2) {
            self.authStateImageView.image = [UIImage imageNamed:@"ic_shen_ing"];
            
            self.jobBottmTipsLabel.y = self.submitedJobAuthView.maxY + kRealValue(10);
            [self.scrollView addSubview:self.jobBottmTipsLabel];
            
            self.scrollView.contentSize = CGSizeMake(0, self.jobBottmTipsLabel.maxY);

        } else if (state == 3) {
            self.authStateImageView.image = [UIImage imageNamed:@"ic_shen_fail"];
            
            self.failedIDAuthReasonView.y = self.submitedJobAuthView.maxY + kRealValue(10);
            self.failedIDAuthReasonLabel.text = [NSString stringWithFormat:@"失败原因：%@",authStateModel.reason];
            [self.failedIDAuthReasonLabel sizeToFit];
            [self.scrollView addSubview:self.failedIDAuthReasonView];
            
            self.resubmitButton.y = self.failedIDAuthReasonView.maxY + kRealValue(20);
            [self.scrollView addSubview:self.resubmitButton];
            
            self.scrollView.contentSize = CGSizeMake(0, self.resubmitButton.maxY);
        }
    }
}

//未认证UI
- (void)setupUnAuthScrollViewByType:(NSInteger)type {
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (type == 1) {
        self.idAuthStyle1View.y = 0;
        [self.scrollView addSubview:self.idAuthStyle1View];
        
        self.idAuthStyle2View.y = self.idAuthStyle1View.maxY + kRealValue(10);
        [self.scrollView addSubview:self.idAuthStyle2View];
        
        self.identityBottomTipsLabel.y = self.idAuthStyle2View.maxY + kRealValue(10);
        [self.scrollView addSubview:self.identityBottomTipsLabel];
        
        self.scrollView.contentSize = CGSizeMake(0, self.identityBottomTipsLabel.maxY);
    } else {
        self.jobAuthView.y = 0;
        [self.scrollView addSubview:self.jobAuthView];
        
        self.jobBottmTipsLabel.y = self.jobAuthView.maxY + kRealValue(10);
        [self.scrollView addSubview:self.jobBottmTipsLabel];
        
        self.scrollView.contentSize = CGSizeMake(0, self.jobBottmTipsLabel.maxY);
    }
}

- (void)setupTitleSegmentView {
    UIView *segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRealValue(160), kRealValue(30))];
    _segmentView = segmentView;
    
    UIButton *authenticationButton = [UIButton buttonWithTitle:@"身份认证" taget:self action:@selector(segmentButtonClicked:) font:kSystemFont16 titleColor:kBlackTextColor];
    authenticationButton.tag = 1;
    authenticationButton.layer.borderColor = kBlackTextColor.CGColor;
    authenticationButton.frame = CGRectMake(0, 0, kRealValue(70), kRealValue(30));
    [segmentView addSubview:authenticationButton];
    _idAuthenticationButton = authenticationButton;
    
    UIButton *jobAuthenticationButton = [UIButton buttonWithTitle:@"职业认证" taget:self action:@selector(segmentButtonClicked:) font:kSystemFont16 titleColor:kBlackTextColor];
    jobAuthenticationButton.frame = CGRectMake(authenticationButton.maxX + kRealValue(20), 0, kRealValue(70), kRealValue(30));
    jobAuthenticationButton.tag = 2;
    jobAuthenticationButton.layer.borderColor = kBlackTextColor.CGColor;
    [segmentView addSubview:jobAuthenticationButton];
    _jobAuthenticationButton = jobAuthenticationButton;
    
    self.navigationItem.titleView = segmentView;
    
    [self segmentButtonClicked:authenticationButton];
}

- (void)setupidAuthStyle1View {
    UIView *style1View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(100))];
    style1View.backgroundColor = [UIColor whiteColor];
    _idAuthStyle1View = style1View;
    
    //方式1
    UILabel *styleTitleLabel = [UILabel labelWithName:@"方式一" Font:kSystemFont15 textColor:kGrayTextColor textAlignment:NSTextAlignmentLeft];
    styleTitleLabel.frame = CGRectMake(kRealValue(15), kRealValue(15), kRealValue(60), kRealValue(16));
    [style1View addSubview:styleTitleLabel];
    
    //添加微信号认证
    UILabel *addWxLabel = [UILabel labelWithName:@"添加微信号认证" Font:kSystemFont15 textColor:kPurpleTextColor textAlignment:NSTextAlignmentCenter];
    addWxLabel.frame = CGRectMake(0, styleTitleLabel.maxY + kRealValue(15), kScreenWidth, kRealValue(16));
    [style1View addSubview:addWxLabel];
    
    //官方微信号
    UILabel *officialWxLabel = [UILabel labelWithName:nil Font:kSystemFont15 textColor:kGrayTextColor textAlignment:NSTextAlignmentCenter];
    officialWxLabel.frame = CGRectMake(0, addWxLabel.maxY + kRealValue(10), kScreenWidth, kRealValue(16));
    NSString *totalText = @"请添加官方微信号maskpaerk666进行认证";
    NSString *rangeText = @"maskpaerk666";
    NSRange hightlightTextRange = [totalText rangeOfString:rangeText];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:totalText];
    [attributeStr addAttribute:NSForegroundColorAttributeName
                         value:kPurpleTextColor
                         range:hightlightTextRange];
    [attributeStr addAttribute:NSFontAttributeName
                         value:kSystemFont15
                         range:hightlightTextRange];
    officialWxLabel.attributedText = attributeStr;
    [style1View addSubview:officialWxLabel];
}

- (void)setupidAuthStyle2View {
    UIView *style2View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(290))];
    style2View.backgroundColor = [UIColor whiteColor];
    _idAuthStyle2View = style2View;
    
    //方式2
    UILabel *styleTitleLabel = [UILabel labelWithName:@"方式二" Font:kSystemFont15 textColor:kGrayTextColor textAlignment:NSTextAlignmentLeft];
    styleTitleLabel.frame = CGRectMake(kRealValue(15), kRealValue(15), kRealValue(60), kRealValue(16));
    [style2View addSubview:styleTitleLabel];
    
    //添加微信号认证
    UILabel *selfHelpLabel = [UILabel labelWithName:@"自助认证" Font:kSystemFont15 textColor:kPurpleTextColor textAlignment:NSTextAlignmentCenter];
    selfHelpLabel.frame = CGRectMake(0, styleTitleLabel.maxY + kRealValue(15), kScreenWidth, kRealValue(16));
    [style2View addSubview:selfHelpLabel];
    
    //官方微信号
    UILabel *handHeldIdentityCardLabel = [UILabel labelWithName:@"请手持身份证以及身份证正反面进行上传自助认证" Font:kSystemFont15 textColor:kGrayTextColor textAlignment:NSTextAlignmentCenter];
    handHeldIdentityCardLabel.frame = CGRectMake(0, selfHelpLabel.maxY + kRealValue(10), kScreenWidth, kRealValue(16));
    [style2View addSubview:handHeldIdentityCardLabel];

    CGFloat identityButtonWH = kRealValue(80);
    //证件正面
    _idCardFrontButton = [UIButton buttonWithImage:@"ic_add_big" taget:self action:@selector(idCardFrontButtonClicked)];
    _idCardFrontButton.backgroundColor = kMineBackgroundColor;
    _idCardFrontButton.frame = CGRectMake(kRealValue(50), handHeldIdentityCardLabel.maxY + kRealValue(16), identityButtonWH, identityButtonWH);
    [style2View addSubview:_idCardFrontButton];

    UILabel *idCardFrontLabel = [UILabel labelWithName:@"证件正面" Font:kSystemFont15 textColor:kGrayBorderColor textAlignment:NSTextAlignmentCenter];
    idCardFrontLabel.frame = CGRectMake(_idCardFrontButton.x, _idCardFrontButton.maxY + kRealValue(7), _idCardFrontButton.width, kRealValue(16));
    [style2View addSubview:idCardFrontLabel];
    
    //证件反面
    _idCardBackButton = [UIButton buttonWithImage:@"ic_add_big" taget:self action:@selector(idCardBackButtonClicked)];
    _idCardBackButton.backgroundColor = kMineBackgroundColor;
    _idCardBackButton.frame = CGRectMake(_idCardFrontButton.maxX + kRealValue(20), _idCardFrontButton.y, _idCardFrontButton.width, _idCardFrontButton.height);
    [style2View addSubview:_idCardBackButton];
    
    UILabel *idCardBackLabel = [UILabel labelWithName:@"证件反面" Font:kSystemFont15 textColor:kGrayBorderColor textAlignment:NSTextAlignmentCenter];
    idCardBackLabel.frame = CGRectMake(_idCardBackButton.x, idCardFrontLabel.y, _idCardBackButton.width, kRealValue(16));
    [style2View addSubview:idCardBackLabel];

    //手持身份证
    _idCardSelfHandButton = [UIButton buttonWithImage:@"ic_add_big" taget:self action:@selector(idCardSelfHandButtonClicked)];
    _idCardSelfHandButton.backgroundColor = kMineBackgroundColor;
    _idCardSelfHandButton.frame = CGRectMake(_idCardBackButton.maxX + kRealValue(20), _idCardFrontButton.y, _idCardFrontButton.width, _idCardFrontButton.height);
    [style2View addSubview:_idCardSelfHandButton];
    
    UILabel *idCardSelfHandLabel = [UILabel labelWithName:@"手持身份证" Font:kSystemFont15 textColor:kGrayBorderColor textAlignment:NSTextAlignmentCenter];
    idCardSelfHandLabel.frame = CGRectMake(_idCardSelfHandButton.x, idCardFrontLabel.y, _idCardSelfHandButton.width, kRealValue(16));
    [style2View addSubview:idCardSelfHandLabel];
    
    //提交认证
    UIButton *comfirmButton = [UIButton buttonWithTitle:@"提交认证" taget:self action:@selector(identityComfirmButtonClicked) font:kSystemFont15 titleColor:kWhiteTextColor];
    comfirmButton.frame = CGRectMake(kRealValue(30), idCardSelfHandLabel.maxY + kRealValue(30), kScreenWidth - kRealValue(60), kRealValue(40));
    comfirmButton.layer.cornerRadius = 18;
    [style2View addSubview:comfirmButton];
    
    CAGradientLayer *btnLayer = [CAGradientLayer layer];
    btnLayer.locations = @[@0.5];
    btnLayer.startPoint = CGPointMake(0, 0);
    btnLayer.endPoint = CGPointMake(1.0, 0.0);
    btnLayer.frame = comfirmButton.bounds;
    btnLayer.cornerRadius = 18;
    btnLayer.masksToBounds = YES;
    btnLayer.colors = @[(__bridge id)RGB(134, 172, 231).CGColor, (__bridge id)RGB(183, 163, 237).CGColor];
    [comfirmButton.layer insertSublayer:btnLayer atIndex:0];
    
    style2View.height = comfirmButton.maxY + kRealValue(20);
}

- (void)setupSubmitedIDCardView {
    //已经提交身份证信息
    _submitedIDCardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(180))];
    _submitedIDCardView.backgroundColor = [UIColor whiteColor];
    
    CGFloat identityButtonWH = kRealValue(80);
    //证件正面
    _submitedIdCardFrontButton = [UIButton buttonWithImage:@"ic_add_big" taget:self action:@selector(idCardFrontButtonClicked)];
    _submitedIdCardFrontButton.backgroundColor = kMineBackgroundColor;
    _submitedIdCardFrontButton.frame = CGRectMake(kRealValue(50), kRealValue(30), identityButtonWH, identityButtonWH);
    [_submitedIDCardView addSubview:_submitedIdCardFrontButton];
    
    UILabel *idCardFrontLabel = [UILabel labelWithName:@"证件正面" Font:kSystemFont15 textColor:kGrayBorderColor textAlignment:NSTextAlignmentCenter];
    idCardFrontLabel.frame = CGRectMake(_submitedIdCardFrontButton.x, _submitedIdCardFrontButton.maxY + kRealValue(7), _submitedIdCardFrontButton.width, kRealValue(16));
    [_submitedIDCardView addSubview:idCardFrontLabel];
    
    //证件反面
    _submitedIdCardBackButton = [UIButton buttonWithImage:@"ic_add_big" taget:self action:@selector(idCardBackButtonClicked)];
    _submitedIdCardBackButton.backgroundColor = kMineBackgroundColor;
    _submitedIdCardBackButton.frame = CGRectMake(_submitedIdCardFrontButton.maxX + kRealValue(20), _submitedIdCardFrontButton.y, _submitedIdCardFrontButton.width, _submitedIdCardFrontButton.height);
    [_submitedIDCardView addSubview:_submitedIdCardBackButton];
    
    UILabel *idCardBackLabel = [UILabel labelWithName:@"证件反面" Font:kSystemFont15 textColor:kGrayBorderColor textAlignment:NSTextAlignmentCenter];
    idCardBackLabel.frame = CGRectMake(_submitedIdCardBackButton.x, idCardFrontLabel.y, _submitedIdCardBackButton.width, kRealValue(16));
    [_submitedIDCardView addSubview:idCardBackLabel];
    
    //手持身份证
    _submitedIdCardSelfHandButton = [UIButton buttonWithImage:@"ic_add_big" taget:self action:@selector(idCardSelfHandButtonClicked)];
    _submitedIdCardSelfHandButton.backgroundColor = kMineBackgroundColor;
    _submitedIdCardSelfHandButton.frame = CGRectMake(_submitedIdCardBackButton.maxX + kRealValue(20), _submitedIdCardFrontButton.y, _submitedIdCardFrontButton.width, _submitedIdCardFrontButton.height);
    [_submitedIDCardView addSubview:_submitedIdCardSelfHandButton];
    
    UILabel *idCardSelfHandLabel = [UILabel labelWithName:@"手持身份证" Font:kSystemFont15 textColor:kGrayBorderColor textAlignment:NSTextAlignmentCenter];
    idCardSelfHandLabel.frame = CGRectMake(_submitedIdCardSelfHandButton.x, idCardFrontLabel.y, _submitedIdCardSelfHandButton.width, kRealValue(16));
    [_submitedIDCardView addSubview:idCardSelfHandLabel];
}

- (void)setupFailedIDAuthReasonView {
    _failedIDAuthReasonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(100))];
    _failedIDAuthReasonView.backgroundColor = [UIColor whiteColor];
    _failedIDAuthReasonLabel = [UILabel labelWithName:@"失败原因：" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    _failedIDAuthReasonLabel.frame = CGRectMake(kRealValue(15), kRealValue(15), _failedIDAuthReasonView.width - kRealValue(30), 0);
    [_failedIDAuthReasonLabel sizeToFit];
    [_failedIDAuthReasonView addSubview:_failedIDAuthReasonLabel];
}

- (void)setupAuthStateView {
    UIView *authStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(150))];
    authStateView.backgroundColor = [UIColor whiteColor];
    _authStateView = authStateView;
    
    UIImageView *stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kRealValue(110), kRealValue(130))];
    stateImageView.image = [UIImage imageNamed:@"ic_shen_ing"];
    stateImageView.center = authStateView.center;
    [authStateView addSubview:stateImageView];
    _authStateImageView = stateImageView;
}

- (void)setupJobAuthView {
    UIView *jobAuthView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    jobAuthView.backgroundColor = [UIColor whiteColor];
    _jobAuthView = jobAuthView;
    
    //职业资料上传
    UILabel *jobInfoUploadLabel = [UILabel labelWithName:@"职业资料上传" Font:kSystemFont15 textColor:kGrayTextColor textAlignment:NSTextAlignmentLeft];
    jobInfoUploadLabel.frame = CGRectMake(kRealValue(15), kRealValue(15), kRealValue(200), kRealValue(16));
    [jobAuthView addSubview:jobInfoUploadLabel];
    
    //按钮
    _jobInfoButton1 = [UIButton buttonWithImage:@"ic_add_big" taget:self action:@selector(jobInfoButton1Clicked)];
    _jobInfoButton1.frame = CGRectMake(kScreenWidth/2 - kRealValue(90), jobInfoUploadLabel.maxY + kRealValue(15), kRealValue(80), kRealValue(80));
    _jobInfoButton1.backgroundColor = kMineBackgroundColor;
    [jobAuthView addSubview:_jobInfoButton1];
    
    _jobInfoButton2 = [UIButton buttonWithImage:@"ic_add_big" taget:self action:@selector(jobInfoButton2Clicked)];
    _jobInfoButton2.backgroundColor = kMineBackgroundColor;
    _jobInfoButton2.frame = CGRectMake(kScreenWidth/2 + kRealValue(10), jobInfoUploadLabel.maxY + kRealValue(15), kRealValue(80), kRealValue(80));
    [jobAuthView addSubview:_jobInfoButton2];
    
    UILabel *tipsLabel = [UILabel labelWithName:@"您的认证资料完全保密，请放心上传\n\n职业认证方法：\n方法一：手持工作证/学生证/名片进行自拍\n方法二：上传你的工作照（工作环境合影/身穿工作服照片等）" Font:kSystemFont13 textColor:kGrayTextColor textAlignment:NSTextAlignmentLeft];
    tipsLabel.numberOfLines = 0;
    tipsLabel.frame = CGRectMake(kRealValue(15), _jobInfoButton1.maxY + kRealValue(15), kScreenWidth - kRealValue(30), 0);
    [tipsLabel sizeToFit];
    [jobAuthView addSubview:tipsLabel];
 
    //提交认证
    UIButton *comfirmButton = [UIButton buttonWithTitle:@"提交认证" taget:self action:@selector(jobComfirmButtonClicked) font:kSystemFont15 titleColor:kWhiteTextColor];
    comfirmButton.frame = CGRectMake(kRealValue(30), tipsLabel.maxY + kRealValue(30), kScreenWidth - kRealValue(60), kRealValue(40));
    comfirmButton.layer.cornerRadius = 18;
    [jobAuthView addSubview:comfirmButton];
    
    CAGradientLayer *btnLayer = [CAGradientLayer layer];
    btnLayer.locations = @[@0.5];
    btnLayer.startPoint = CGPointMake(0, 0);
    btnLayer.endPoint = CGPointMake(1.0, 0.0);
    btnLayer.frame = comfirmButton.bounds;
    btnLayer.cornerRadius = 18;
    btnLayer.masksToBounds = YES;
    btnLayer.colors = @[(__bridge id)RGB(134, 172, 231).CGColor, (__bridge id)RGB(183, 163, 237).CGColor];
    [comfirmButton.layer insertSublayer:btnLayer atIndex:0];

    jobAuthView.height = comfirmButton.maxY + kRealValue(20);
}

- (void)setupSubmitedJobAuthView {
    _submitedJobAuthView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(140))];
    _submitedJobAuthView.backgroundColor = [UIColor whiteColor];
    
    //职业资料上传
    UILabel *uploadLabel = [UILabel labelWithName:@"职业资料上传" Font:kSystemFont15 textColor:kGrayTextColor textAlignment:NSTextAlignmentLeft];
    uploadLabel.frame = CGRectMake(kRealValue(15), kRealValue(15), kRealValue(100), kRealValue(16));
    [_submitedJobAuthView addSubview:uploadLabel];
    
    //职业图片
    CGFloat kImageViewWH = kRealValue(80);
    _submitedJobInfoImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - kImageViewWH - kRealValue(10), uploadLabel.maxY + kRealValue(15), kImageViewWH, kImageViewWH)];
    _submitedJobInfoImageView1.backgroundColor = kMineBackgroundColor;
    [_submitedJobAuthView addSubview:_submitedJobInfoImageView1];
    _submitedJobInfoImageView1.userInteractionEnabled = YES;
    [_submitedJobInfoImageView1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [self jobInfoButton1Clicked];
    }]];
    

    _submitedJobInfoImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 + kRealValue(10), uploadLabel.maxY + kRealValue(15), kImageViewWH, kImageViewWH)];
    _submitedJobInfoImageView2.backgroundColor = kMineBackgroundColor;
    [_submitedJobAuthView addSubview:_submitedJobInfoImageView2];
    _submitedJobInfoImageView2.userInteractionEnabled = YES;
    [_submitedJobInfoImageView2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [self jobInfoButton2Clicked];
    }]];
}

- (void)setupPassTipsLabel {
    //通过提示
    UILabel *passTipsLabel = [UILabel labelWithName:@"通过职业认证后，即可：\n-点亮职业认证徽章\n-极大提升约会成功率\n-免费发布广播\n-获得优先展示机会" Font:kSystemFont13 textColor:kGrayTextColor textAlignment:NSTextAlignmentLeft];
    passTipsLabel.numberOfLines = 0;
    passTipsLabel.frame = CGRectMake(kRealValue(10), 0, kScreenWidth - kRealValue(20), 0);
    [passTipsLabel sizeToFit];
    _jobBottmTipsLabel = passTipsLabel;
}

- (void)setupIdentityBottomTipsLabel {
    UILabel *tipLabel = [UILabel labelWithName:@"1.您提交的身份信息只作为实名认证使用，未征求您的同意，绝不向任何第三方透露。请放心填写\n2.通过官方认证后，即可获得认证标识，提高整体APP关注度" Font:kSystemFont13 textColor:kGrayTextColor textAlignment:NSTextAlignmentLeft];
    tipLabel.frame = CGRectMake(kRealValue(10), kRealValue(10), kScreenWidth - kRealValue(20), kRealValue(60));
    tipLabel.numberOfLines = 0;
    [tipLabel sizeToFit];
    _identityBottomTipsLabel = tipLabel;
}

- (void)setupResubmitButton {
    //重新提交
    UIButton *comfirmButton = [UIButton buttonWithTitle:@"重新提交" taget:self action:@selector(reSubmitButtonClicked) font:kSystemFont15 titleColor:kWhiteTextColor];
    comfirmButton.frame = CGRectMake(kRealValue(30), 0, kScreenWidth - kRealValue(60), kRealValue(40));
    comfirmButton.layer.cornerRadius = 18;
    _resubmitButton = comfirmButton;
    
    CAGradientLayer *btnLayer = [CAGradientLayer layer];
    btnLayer.locations = @[@0.5];
    btnLayer.startPoint = CGPointMake(0, 0);
    btnLayer.endPoint = CGPointMake(1.0, 0.0);
    btnLayer.frame = comfirmButton.bounds;
    btnLayer.cornerRadius = 18;
    btnLayer.masksToBounds = YES;
    btnLayer.colors = @[(__bridge id)RGB(134, 172, 231).CGColor, (__bridge id)RGB(183, 163, 237).CGColor];
    [comfirmButton.layer insertSublayer:btnLayer atIndex:0];
}

#pragma mark - **************** Event
- (void)segmentButtonClicked:(UIButton *)button {
    if (button.tag == 1) {
        NSLog(@"身份认证");
        _idAuthenticationButton.layer.borderWidth = 1;
        _jobAuthenticationButton.layer.borderWidth = 0;

    } else if (button.tag == 2) {
        NSLog(@"职业认证");
        _idAuthenticationButton.layer.borderWidth = 0;
        _jobAuthenticationButton.layer.borderWidth = 1;
    }
    
    [self requestDataByType:button.tag];
}

- (void)idCardFrontButtonClicked {
    NSLog(@"身份证正面");
    if (self.authStateModel.status == 1
        || self.authStateModel.status == 2) {
        return;
    }
    [[YTSelectPictureHelper sharedHelper] showVideoPictureSelectActionSheetWithMaxPicCount:1 isNeedVideo:NO pictureCompleteBlock:^(NSArray * _Nonnull selectImageArray) {
        self.idCardFrontImage = selectImageArray[0];
        [self.idCardFrontButton setImage:selectImageArray[0] forState:UIControlStateNormal];
        [self.submitedIdCardFrontButton setImage:selectImageArray[0] forState:UIControlStateNormal];
    } videoCompleteBlock:nil];
}

- (void)idCardBackButtonClicked {
    NSLog(@"身份证反面");
    if (self.authStateModel.status == 1
        || self.authStateModel.status == 2) {
        return;
    }
    [[YTSelectPictureHelper sharedHelper] showVideoPictureSelectActionSheetWithMaxPicCount:1 isNeedVideo:NO pictureCompleteBlock:^(NSArray * _Nonnull selectImageArray) {
        self.idCardBackImage = selectImageArray[0];
        [self.idCardBackButton setImage:selectImageArray[0] forState:UIControlStateNormal];
        [self.submitedIdCardBackButton setImage:selectImageArray[0] forState:UIControlStateNormal];
    } videoCompleteBlock:nil];
}

- (void)idCardSelfHandButtonClicked {
    NSLog(@"手持身份证");
    if (self.authStateModel.status == 1
        || self.authStateModel.status == 2) {
        return;
    }
    [[YTSelectPictureHelper sharedHelper] showVideoPictureSelectActionSheetWithMaxPicCount:1 isNeedVideo:NO pictureCompleteBlock:^(NSArray * _Nonnull selectImageArray) {
        self.idCardSelfHandImage = selectImageArray[0];
        [self.idCardSelfHandButton setImage:selectImageArray[0] forState:UIControlStateNormal];
        [self.submitedIdCardSelfHandButton setImage:selectImageArray[0] forState:UIControlStateNormal];
    } videoCompleteBlock:nil];
}

- (void)identityComfirmButtonClicked {
    NSLog(@"确认身份信息");
    if (!self.idCardFrontImage) {
        [kAppWindow showAutoHideHudWithText:@"请添加证件正面照片"];
        return;
    }
    if (!self.idCardBackImage) {
        [kAppWindow showAutoHideHudWithText:@"请添加证件反面照片"];
        return;
    }
    if (!self.idCardSelfHandImage) {
        [kAppWindow showAutoHideHudWithText:@"请添加手持身份证照片"];
        return;
    }
    
    [self submitByImageArray:@[self.idCardFrontImage,self.idCardBackImage,self.idCardSelfHandImage] authType:self.authType];
}

- (void)jobComfirmButtonClicked {
    NSLog(@"确认职业信息");
    if (!self.jobInfoImage1) {
        [kAppWindow showAutoHideHudWithText:@"请添加第一张职业信息照片"];
        return;
    }
    if (!self.jobInfoImage2) {
        [kAppWindow showAutoHideHudWithText:@"请添加第二张职业信息照片"];
        return;
    }
    
    [self submitByImageArray:@[self.jobInfoImage1, self.jobInfoImage2] authType:self.authType];
}

- (void)submitByImageArray:(NSArray *)imageArray
                  authType:(NSInteger)authType {
    [kAppWindow showIndeterminateHudWithText:@"请稍后..."];
    [YTUploadHelper uploadImageArrayToQiniu:imageArray isSelectOriginalPhoto:NO progressHandler:^(NSString * _Nonnull progressShowValue, float percent) {
        
    } andComplete:^(NSMutableArray * _Nullable fileNameArray) {
        if (fileNameArray.count != imageArray.count) {
            [kAppWindow showAutoHideHudWithText:@"上传图片失败，请重试"];
            return;
        }
        NSString *photo3;
        if (fileNameArray.count == 3) {
            photo3 = fileNameArray[2];
        }
        
        [MineInterface submitAuthByType:authType photo_1:fileNameArray[0] photo_2:fileNameArray[1] photo_3:photo3 andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage, YTAuthStateModel * _Nonnull authStateModel) {
            if (rspStatusAndMessage.code == kResponseSuccessCode) {
                [self requestDataByType:authType];
            }
            [kAppWindow hideHud];
        }];
    }];
}

- (void)jobInfoButton1Clicked {
    NSLog(@"职业信息1");
    if (self.authStateModel.status == 1
        || self.authStateModel.status == 2) {
        return;
    }
    
    [[YTSelectPictureHelper sharedHelper] showVideoPictureSelectActionSheetWithMaxPicCount:1 isNeedVideo:NO pictureCompleteBlock:^(NSArray * _Nonnull selectImageArray) {
        self.jobInfoImage1 = selectImageArray[0];
        [self.jobInfoButton1 setImage:selectImageArray[0] forState:UIControlStateNormal];
        self.submitedJobInfoImageView1.image = selectImageArray[0];
    } videoCompleteBlock:nil];
}

- (void)jobInfoButton2Clicked {
    NSLog(@"职业信息2");
    if (self.authStateModel.status == 1
        || self.authStateModel.status == 2) {
        return;
    }
    
    [[YTSelectPictureHelper sharedHelper] showVideoPictureSelectActionSheetWithMaxPicCount:1 isNeedVideo:NO pictureCompleteBlock:^(NSArray * _Nonnull selectImageArray) {
        self.jobInfoImage2 = selectImageArray[0];
        [self.jobInfoButton2 setImage:selectImageArray[0] forState:UIControlStateNormal];
        self.submitedJobInfoImageView2.image = selectImageArray[0];
    } videoCompleteBlock:nil];
}

- (void)reSubmitButtonClicked {
    NSLog(@"重新提交");
    if (self.authType == 1) {
        [self identityComfirmButtonClicked];
    } else {
        [self jobComfirmButtonClicked];
    }
}

#pragma mark - **************** Setter Getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = kMineBackgroundColor;
    }
    return _scrollView;
}

@end
