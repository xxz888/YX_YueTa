//
//  YTUserInfoController.m
//  YueTa
//
//  Created by Awin on 2019/1/30.
//  Copyright © 2019年 姚兜兜. All rights reserved.
//

#import "YTUserInfoController.h"
#import "YTUserInfoHeader.h"
#import "NearInterface.h"
#import "MineInterface.h"
#import "MineInterface.h"

#import "YTMyAlbumViewController.h"
#import "YTMyAppiontmentViewController.h"
#import "YTPostAppointmentViewController.h"
#import "YTReportViewController.h"

@interface YTUserInfoController ()<UIActionSheetDelegate>

@property (nonatomic, strong) NearUserInfo *model;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YTUserInfoHeader *userHeader;
@property (nonatomic, strong) NSArray *educationArr;

@end

@implementation YTUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 用户详细页面
    
    [self requestData];
}

- (void)requestData {
    [self.view showIndeterminateHudWithText:nil];
    [NearInterface getNearUserInfoWithID:self.ID andBlock:^(ResponseMessage *rspStatusAndMessage, NearUserInfo *model) {
        [self.view hideHud];
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            self.model = model;
            [self setNavigationItem];
            [self createUI];
        }
    }];
}

#pragma mark - 导航相关
- (void)setNavigationItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:@"near_more" target:self action:@selector(rightBarButtonClick)];
}

- (void)rightBarButtonClick {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拉黑名单",@"举报", nil];
    [sheet showInView:self.view];
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        //黑名单
        [MineInterface disBlackUser:self.ID andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage) {
            if ([rspStatusAndMessage.message isEqualToString:@"操作成功"]) {
                [self.view showAutoHideHudWithText:@"拉黑名单成功"];
            }
        }];
    } else if (buttonIndex == 1) {//举报
        YTReportViewController *report = [[YTReportViewController alloc] init];
        report.userId = self.ID;
        [self.navigationController pushViewController:report animated:YES];
    }
}

#pragma mark - events
- (void)userLikeButtonClick:(UIButton *)button {
    
    if (self.model.like == 1) {//取消关注
        [self.view showIndeterminateHudWithText:nil];
        [MineInterface disLikeUser:self.ID andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage) {
            [self.view hideHud];
            if ([rspStatusAndMessage.message isEqualToString:@"操作成功"]) {
                self.model.like = 0;
                [button setBackgroundImage:KimageName(@"ic_un_follow") forState:UIControlStateNormal];
            }
        }];
    } else {//关注
        [self.view showIndeterminateHudWithText:nil];
        [MineInterface likeUser:self.ID andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage) {
            [self.view hideHud];
            if ([rspStatusAndMessage.message isEqualToString:@"操作成功"]) {
                self.model.like = 1;
                [button setBackgroundImage:KimageName(@"ic_follow") forState:UIControlStateNormal];
            }
        }];
    }
}

- (void)appointmentButtonClick {//ta的约会
    YTMyAppiontmentViewController *vc = [[YTMyAppiontmentViewController alloc] init];
    vc.ID = self.ID;
    vc.type = @"other";
    [vc setNavigationBarTitle:@"Ta的约会"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)askAppointmentButtonClick {//约ta
    YTPostAppointmentViewController *vc = [[YTPostAppointmentViewController alloc] init];
    vc.dateUserId = self.ID;
    [vc setNavigationBarTitle:@"约Ta"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)photoCHekcMore {// 查看更多照片
    YTMyAlbumViewController *vc = [[YTMyAlbumViewController alloc] init];
    vc.ID = self.ID;
    vc.isMineAlbum = NO;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UI
- (void)createUI {
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight-kTabBarHeight);
    self.scrollView.backgroundColor = kWhiteBackgroundColor;
    [self.view addSubview:self.scrollView];
    
    // 头部用户信息
    self.userHeader = [[YTUserInfoHeader alloc] init];
    [self.userHeader loadDataWithModel:self.model];
    @weakify(self)
    self.userHeader.block = ^(UIButton *button) {
        @strongify(self)
        [self userLikeButtonClick:button];
    };
    [self.scrollView addSubview:self.userHeader];
    
    // 个人相册
    UILabel *photoNum = [UILabel labelWithName:[NSString stringWithFormat:@"个人相册(%ld张)",self.model.pic_list.count] Font:kSystemFont14 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    photoNum.frame = CGRectMake(kRealValue(10), self.userHeader.bottom, kRealValue(150), kRealValue(40));
    [self.scrollView addSubview:photoNum];
    
    UIButton *moreBtn = [UIButton buttonWithTitle:@"更多" taget:self action:@selector(photoCHekcMore) font:kSystemFont13 titleColor:kBlackTextColor];
    UIImage *arrowIg = [UIImage imageNamed:@"near_arrow"];
    [moreBtn setImage:arrowIg forState:UIControlStateNormal];
    moreBtn.frame = CGRectMake(kScreenWidth-kRealValue(80), photoNum.y, kRealValue(70), photoNum.height);
    [moreBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -arrowIg.size.width, 0, arrowIg.size.width)];
    [moreBtn setImageEdgeInsets:UIEdgeInsetsMake(0, [@"更多" calculateMaxWidthWithFont:kSystemFont13]+3, 0, -([@"更多" calculateMaxWidthWithFont:kSystemFont13]+3))];
    [self.scrollView addSubview:moreBtn];
    
    NSInteger num = self.model.pic_list.count;
    if (self.model.pic_list.count >= 3) {
        num = 3;
    }
    UIView *lastImg = photoNum;
    CGFloat imageW = (kScreenWidth-kRealValue(20)*4)/3;
    for (NSInteger i = 0; i < num; i ++) {
        UIImageView *image = [[UIImageView alloc] init];
        [image sd_setImageWithURL:self.model.pic_list[i]];
        image.frame = CGRectMake(kRealValue(20)+(imageW+kRealValue(20))*i, photoNum.bottom, imageW, imageW);
        image.layer.cornerRadius = kRealValue(5);
        image.layer.masksToBounds = YES;
        image.contentMode = UIViewContentModeScaleAspectFill;
        image.clipsToBounds = YES;
        [self.scrollView addSubview:image];
        
        lastImg = image;
    }
    
    // 个人介绍
    UILabel *introduceLab = [UILabel labelWithName:@"个人介绍" Font:kSystemFont14 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    introduceLab.frame = CGRectMake(kRealValue(10), lastImg.bottom+kRealValue(20), kRealValue(100), kRealValue(20));
    [self.scrollView addSubview:introduceLab];
    
    NSString *introduceStr;
    if (self.model.introduction.length) {
        introduceStr = self.model.introduction;
    } else {
        introduceStr = @"这个人很懒,什么都没留下";
    }
    UILabel *introduceInfo = [UILabel labelWithName:introduceStr Font:kSystemFont12 textColor:kGrayTextColor textAlignment:NSTextAlignmentLeft];
    introduceInfo.frame = CGRectMake(kRealValue(10), introduceLab.bottom+kRealValue(5), kRealValue(100), kRealValue(40));
    introduceInfo.numberOfLines = 2;
    [self.scrollView addSubview:introduceInfo];
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(kRealValue(10), introduceInfo.bottom+kRealValue(10), kScreenWidth-kRealValue(20), 0.5);
    line.backgroundColor = kGrayBorderColor;
    [self.scrollView addSubview:line];
    
    // 关于Ta
    UILabel *aboutLab = [UILabel labelWithName:@"关于Ta" Font:kSystemFont14 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    aboutLab.frame = CGRectMake(kRealValue(10), line.bottom+kRealValue(20), kRealValue(100), kRealValue(20));
    [self.scrollView addSubview:aboutLab];
    
    NSArray *titleArr = @[@"用户ID",@"约会意向",@"感情状况",@"身高",@"体重",@"微信",@"手机号",@"学历"];
    NSArray *infoArr = @[[NSString stringWithFormat:@"%ld",self.ID],self.model.program,self.model.emotion,[NSString stringWithFormat:@"%.0lfcm",self.model.height],[NSString stringWithFormat:@"%.2lfkg",self.model.weight],self.model.wechat,[NSString stringWithFormat:@"%ld",(long)self.model.mobile],self.educationArr[self.model.education]];
    UILabel *lastLab = aboutLab;
    for (NSInteger i = 0; i < titleArr.count; i ++) {
        UILabel *titleLab = [UILabel labelWithName:titleArr[i] Font:kSystemFont13 textColor:kGrayTextColor textAlignment:NSTextAlignmentLeft];
        titleLab.frame = CGRectMake(kRealValue(20), lastLab.bottom, kRealValue(100), kRealValue(30));
        [self.scrollView addSubview:titleLab];
        
        if ([infoArr[i] isEqualToString:@"微信"] || [infoArr[i] isEqualToString:@"手机号"]) {
            UIButton *button = [UIButton buttonWithTitle:@"点击查看" taget:self action:@selector(clickCheckButton:) font:kSystemFont13 titleColor:kWhiteTextColor];
            button.frame = CGRectMake(titleLab.right, 0, kRealValue(80), kRealValue(20));
            button.centerY = titleLab.centerY;
            [self.scrollView addSubview:button];
        } else {
            UILabel *infoLab = [UILabel labelWithName:infoArr[i] Font:kSystemFont13 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
            infoLab.frame = CGRectMake(titleLab.right, 0, kRealValue(150), kRealValue(20));
            infoLab.centerY = titleLab.centerY;
            [self.scrollView addSubview:infoLab];
        }
        
        lastLab = titleLab;
    }
    
    // 底部提醒
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, lastLab.bottom, kScreenWidth, kRealValue(80))];
    bottomView.backgroundColor = kGrayBackgroundColor;
    [self.scrollView addSubview:bottomView];
    
    UILabel *bottomTips = [UILabel labelWithName:@"请勿通过约会进行不法交易,如被举报核实将作封号处理" Font:kSystemFont14 textColor:kDarkGrayTextColor textAlignment:NSTextAlignmentLeft];
    bottomTips.frame = CGRectMake(kRealValue(10), 0, kScreenWidth-kRealValue(20), kRealValue(40));
    bottomTips.numberOfLines = 0;
    [bottomView addSubview:bottomTips];
    
    // 底部按钮
    UIButton *appointment = [UIButton buttonWithTitle:@"Ta的约会" taget:self action:@selector(appointmentButtonClick) font:kSystemFont14 titleColor:kBlackTextColor];
    appointment.frame = CGRectMake(0, self.scrollView.bottom, kScreenWidth/3, kTabBarHeight);
    [self.view addSubview:appointment];
    
    UIButton *askAppointment = [UIButton buttonWithTitle:@"约Ta" taget:self action:@selector(askAppointmentButtonClick) font:kSystemFont14 titleColor:kWhiteTextColor];
    askAppointment.frame = CGRectMake(kScreenWidth/3, self.scrollView.bottom, kScreenWidth/3*2, kTabBarHeight);
    
    CAGradientLayer *btnLayer = [CAGradientLayer layer];
    btnLayer.locations = @[@0.5];
    btnLayer.startPoint = CGPointMake(0, 0);
    btnLayer.endPoint = CGPointMake(1.0, 0.0);
    btnLayer.frame = askAppointment.frame;
    btnLayer.colors = @[(__bridge id)RGB(134, 177, 230).CGColor,(__bridge id)RGB(192, 164, 234).CGColor,];
    [self.view.layer addSublayer:btnLayer];
    [self.view addSubview:askAppointment];
    
    
    self.scrollView.contentSize = CGSizeMake(0, appointment.bottom);
}

#pragma mark - lazy init
- (NSArray *)educationArr {
    if (!_educationArr) {
        _educationArr = @[@"初中",@"高中",@"专科",@"本科",@"研究生",@"硕士",@"博士",@"博士后"];
    }
    return _educationArr;
}



@end
