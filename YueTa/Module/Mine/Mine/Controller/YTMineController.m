//
//  YTMineController.m
//  YueTa
//
//  Created by 姚兜兜 on 2018/12/20.
//  Copyright © 2018 姚兜兜. All rights reserved.
//

#import "YTMineController.h"
#import "YTPostAppointmentViewController.h"
#import "YTBasicInformationViewController.h"
#import "YTMyRelationViewController.h"
#import "YTMyAppiontmentViewController.h"
#import "YTMyWalletViewController.h"
#import "YTCertificationCenterViewController.h"
#import "YTSettingViewController.h"
#import "YTMallViewController.h"
#import "YTCustomerServiceViewController.h"
#import "YTAboutusViewController.h"
#import "YTReportViewController.h"

#import "YTMineInfoView.h"
#import "YTMineEntryView.h"

#import "MineInterface.h"
#import "YTUserModel.h"

@interface YTMineController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YTMineInfoView *mineInfoView;
@property (nonatomic, strong) UIView *sepLine;
@property (nonatomic, strong) YTMineEntryView *mineEntryView;

@end

@implementation YTMineController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [self requestData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"我的"];
    [self setupSubViews];
}

- (void)setupSubViews {
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.mineInfoView];
    [self.scrollView addSubview:self.sepLine];
    [self.scrollView addSubview:self.mineEntryView];

    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, kTabBarHeight, 0));
    }];
    
    [self.mineInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self.scrollView);
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@kRealValue(425));
    }];
    
    [self.sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mineInfoView.mas_bottom);
        make.left.equalTo(self.scrollView);
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@kRealValue(10));
    }];
    
    [self.mineEntryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mineInfoView.mas_bottom).offset(kRealValue(10));
        make.left.equalTo(self.scrollView);
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@kRealValue(270));
    }];
    
    self.scrollView.contentSize = CGSizeMake(0, kRealValue(705));
}

- (void)requestData {
    [MineInterface getPersonalDataAndBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage, NSDictionary * _Nonnull userDataDic) {
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            YTUserModel *userModel = [YTUserModel mj_objectWithKeyValues:userDataDic];
            self.mineInfoView.userModel = userModel;
        }
    }];
    
    [MineInterface getFansLikeNumberAndBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage, NSString * _Nonnull fansNumber, NSString * _Nonnull likeNumber) {
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            self.mineInfoView.likedNumber = likeNumber;
            self.mineInfoView.fansNumber = fansNumber;
        }
    }];
}

#pragma mark - **************** Event Response
- (void)shareClicked {
//    YTReportViewController *report = [[YTReportViewController alloc] init];
//    [self.navigationController pushViewController:report animated:YES];
}

- (void)infoViewClickedInfoType:(YTMineInfoType)type {
    if (type == YTMineInfoTypePost) {
        YTPostAppointmentViewController *post = [[YTPostAppointmentViewController alloc] init];
        [self.navigationController pushViewController:post animated:YES];
    } else if (type == YTMineInfoTypeMyPost) {
        YTMyAppiontmentViewController *vc = [[YTMyAppiontmentViewController alloc] init];
        vc.type = @"own";
        [vc setNavigationBarTitle:@"我发布的"];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (type == YTMineInfoTypeMyRegistration) {
        YTMyAppiontmentViewController *vc = [[YTMyAppiontmentViewController alloc] init];
        vc.type = @"apply";
        [vc setNavigationBarTitle:@"我报名的"];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (type == YTMineInfoTypeMyDate) {
        YTMyAppiontmentViewController *vc = [[YTMyAppiontmentViewController alloc] init];
        vc.type = @"all";
        [vc setNavigationBarTitle:@"我的约会"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)entryClickedEntryType:(YTMineEntryType)type {
    if (type == YTMineEntryTypeBasicInfo) {
        YTBasicInformationViewController *basicInfo = [[YTBasicInformationViewController alloc] init];
        [self.navigationController pushViewController:basicInfo animated:YES];
    } else if (type == YTMineEntryTypeWallet) {
        YTMyWalletViewController *wallet = [[YTMyWalletViewController alloc] init];
        [self.navigationController pushViewController:wallet animated:YES];
    } else if (type == YTMineEntryTypeStore) {
        YTMallViewController *mall = [[YTMallViewController alloc] init];
        [self.navigationController pushViewController:mall animated:YES];
    } else if (type == YTMineEntryTypeCertificationCenter) {
        YTCertificationCenterViewController *certificationCenter = [[YTCertificationCenterViewController alloc] init];
        [self.navigationController pushViewController:certificationCenter animated:YES];
    } else if (type == YTMineEntryTypeServiceCenter) {
        YTCustomerServiceViewController *scrvice = [[YTCustomerServiceViewController alloc] init];
        [self.navigationController pushViewController:scrvice animated:YES];
    } else if (type == YTMineEntryTypeSetting) {
        YTSettingViewController *setting = [[YTSettingViewController alloc] init];
        [self.navigationController pushViewController:setting animated:YES];
    } else if (type == YTMineEntryTypeBlackList) {
        YTMyRelationViewController *blackList = [[YTMyRelationViewController alloc] init];
        blackList.type = 2;
        [self.navigationController pushViewController:blackList animated:YES];
    } else if (type == YTMineEntryTypeAboutus) {
        YTAboutusViewController *aboutus = [[YTAboutusViewController alloc] init];
        [self.navigationController pushViewController:aboutus animated:YES];
    }
}

- (void)avartarClicked {
    YTBasicInformationViewController *basicInfo = [[YTBasicInformationViewController alloc] init];
    [self.navigationController pushViewController:basicInfo animated:YES];
}

- (void)myfocusClicked {
    YTMyRelationViewController *myFocus = [[YTMyRelationViewController alloc] init];
    myFocus.type = 1;
    [self.navigationController pushViewController:myFocus animated:YES];
}

- (void)myfansClicked {
    YTMyRelationViewController *myFans = [[YTMyRelationViewController alloc] init];
    myFans.type = 0;
    [self.navigationController pushViewController:myFans animated:YES];
}

#pragma mark - **************** Setter Getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}

- (YTMineInfoView *)mineInfoView {
    if (!_mineInfoView) {
        _mineInfoView = [[YTMineInfoView alloc] init];
        @weakify(self);
        _mineInfoView.infoClickedBlock = ^(YTMineInfoType type) {
            @strongify(self);
            [self infoViewClickedInfoType:type];
        };
        _mineInfoView.shareClickedBlock = ^{
            @strongify(self);
            [self shareClicked];
        };
        _mineInfoView.avartarClickedBlock = ^{
            @strongify(self);
            [self avartarClicked];
        };
        _mineInfoView.myfocusClickedBlock = ^{
            @strongify(self);
            [self myfocusClicked];
        };
        _mineInfoView.myfansClickedBlock = ^{
            @strongify(self);
            [self myfansClicked];
        };
    }
    return _mineInfoView;
}

- (UIView *)sepLine {
    if (!_sepLine) {
        _sepLine = [[UIView alloc] init];
        _sepLine.backgroundColor = kMineBackgroundColor;
    }
    return _sepLine;
}

- (YTMineEntryView *)mineEntryView {
    if (!_mineEntryView) {
        _mineEntryView = [[YTMineEntryView alloc] init];
        @weakify(self);
        _mineEntryView.entryClickedBlock = ^(YTMineEntryType type) {
            @strongify(self);
            [self entryClickedEntryType:type];
        };
    }
    return _mineEntryView;
}

@end
