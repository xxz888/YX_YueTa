//
//  YTPostedAppointmentDetailViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/17.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTMyAppointmentDetailViewController.h"
#import "YTPostAppointmentViewController.h"
#import "YTAppiontmentPersonCell.h"
#import "MineInterface.h"
#import "YTAlbumScrollView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "YTReportViewController.h"
#import "YTMessageDetailViewController.h"

#import "YTPostAppointmentViewController.h"

@interface YTMyAppointmentDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *userInfoView;
@property (nonatomic, strong) UIView *appoitmentInfoView;
@property (nonatomic, strong) UIView *appiontmentPersonListView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

static NSString *YTAppiontmentPersonCellID = @"YTAppiontmentPersonCellID";

@implementation YTMyAppointmentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"发布详情"];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    if (self.myDateModel.userId != [UserInfoManager sharedInstance].ID) {
        //举报
        UIBarButtonItem *reportItem = [[UIBarButtonItem alloc] initWithImage:@"ic_more" target:self action:@selector(reportItemClick)];
        self.navigationItem.rightBarButtonItem = reportItem;
    }
    
    [self setupUI];
    [self getApplyList];
    
    if (self.type != 1) {
        
        NSString *string;
        if (self.type == 2) {
            string = @"报名";
        } else {
            string = @"约Ta";
        }
        UIButton *bottomBtn = [UIButton buttonWithTitle:string taget:self action:@selector(bottomButtonClick) font:kSystemFont15 titleColor:kWhiteTextColor];
        bottomBtn.frame = CGRectMake(0, kScreenHeight-kNavBarHeight-kRealValue(50), kScreenWidth, kRealValue(50));
        
        // 登录按钮渐变色
        CAGradientLayer *btnLayer = [CAGradientLayer layer];
        btnLayer.locations = @[@0.5];
        btnLayer.startPoint = CGPointMake(0, 0);
        btnLayer.endPoint = CGPointMake(1.0, 0.0);
        btnLayer.frame = bottomBtn.frame;
        btnLayer.masksToBounds = YES;
        btnLayer.colors = @[(__bridge id)RGB(134, 177, 230).CGColor,(__bridge id)RGB(192, 164, 234).CGColor,];
        [self.view.layer addSublayer:btnLayer];
        [self.view addSubview:bottomBtn];
    }
    
}

// 点击底部按钮
- (void)bottomButtonClick {
    
    if (self.type == 2) {//报名
        [MineInterface applyDate:self.myDateModel.dateId andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage, NSDictionary * _Nonnull responseDic) {
            if ([rspStatusAndMessage.message isEqualToString:@"1"]) {
                [kAppWindow showAutoHideHudWithText:@"报名成功"];
            }
        }];
    } else if (self.type == 3) {// 约ta
        YTPostAppointmentViewController *vc = [[YTPostAppointmentViewController alloc] init];
        vc.dateUserId = self.myDateModel.dateId;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)setupUI {
    [self setupHeaderView];
    [self setupBottomButtons];
}

- (void)getApplyList {
    if (self.myDateModel.userId == [UserInfoManager sharedInstance].ID) {
        [MineInterface getApplyList:self.myDateModel.dateId andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage, NSArray<YTApplyModel *> * _Nonnull applyList) {
            if (rspStatusAndMessage.code == kResponseSuccessCode) {
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:applyList];
                [self.tableView reloadData];
            }
        }];
    }
}

- (void)setupHeaderView {
    [self.headerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setupUserInfoViewSubViews];
    [self setupAppoitmentInfoViewSubViews];
    
    self.userInfoView.y = 0;
    [self.headerView addSubview:self.userInfoView];
    
    self.appoitmentInfoView.y = self.userInfoView.maxY + kRealValue(10);
    [self.headerView addSubview:self.appoitmentInfoView];
    self.headerView.height = self.appoitmentInfoView.maxY;
    
    if (self.myDateModel.userId == [UserInfoManager sharedInstance].ID) {
        self.appiontmentPersonListView.y = self.appoitmentInfoView.maxY + kRealValue(10);
        [self.headerView addSubview:self.appiontmentPersonListView];
        self.headerView.height = self.appiontmentPersonListView.maxY;
    }
    
    self.tableView.tableHeaderView = self.headerView;
}

- (void)setupUserInfoViewSubViews {
    self.userInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(100))];
    self.userInfoView.backgroundColor = kWhiteBackgroundColor;
    
    //头像
    UIImageView *avartarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(20), kRealValue(70), kRealValue(70))];
    avartarImageView.layer.cornerRadius = kRealValue(35);
    avartarImageView.backgroundColor = kGrayBackgroundColor;
    if (self.myDateModel.photo) {
        [avartarImageView sd_setImageWithURL:[NSURL URLWithString:self.myDateModel.photo]];
    } else {
        avartarImageView.image = [UIImage imageNamed:@"ic_head_pink"];
    }
    [self.userInfoView addSubview:avartarImageView];
    self.userInfoView.height = avartarImageView.maxY + kRealValue(30);

    //是否是vip
    UIImageView *vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(30), kRealValue(5), kRealValue(15), kRealValue(15))];
    vipImageView.image = [UIImage imageNamed:@"ic_vip"];
    [self.userInfoView addSubview:vipImageView];
    vipImageView.hidden = !self.myDateModel.VIP;
    
    //昵称
    UILabel *nameLabel = [UILabel labelWithName:@"" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    nameLabel.text = self.myDateModel.name;
    nameLabel.frame = CGRectMake(avartarImageView.maxX + kRealValue(20), avartarImageView.y + kRealValue(5), kRealValue(100), kRealValue(16));
    [nameLabel sizeToFit];
    [self.userInfoView addSubview:nameLabel];
    
    //性别
    UIImageView *sexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(nameLabel.maxX + kRealValue(10), nameLabel.y, kRealValue(16), kRealValue(16))];
    if (self.myDateModel.gender == 0) {
        sexImageView.image = [UIImage imageNamed:@"ic_male"];
    } else {
        sexImageView.image = [UIImage imageNamed:@"ic_female"];
    }
    [self.userInfoView addSubview:sexImageView];
    
    //认证标志
    UILabel *authLabel = [UILabel labelWithName:@"证" Font:kSystemFont12 textColor:kWhiteTextColor textAlignment:NSTextAlignmentCenter];
    authLabel.frame = CGRectMake(sexImageView.maxX + kRealValue(10), nameLabel.y - kRealValue(2), kRealValue(20), kRealValue(20));
    authLabel.clipsToBounds = YES;
    authLabel.backgroundColor = kYellowBackgroundColor;
    authLabel.layer.cornerRadius = kRealValue(10);
    [self.userInfoView addSubview:authLabel];
    authLabel.hidden = !self.myDateModel.auth_job || !self.myDateModel.auth_status;
    
    //发布时间
    UILabel *postTimeLabel = [UILabel labelWithName:@"" Font:kSystemFont12 textColor:kYellowTextColor textAlignment:NSTextAlignmentLeft];
    postTimeLabel.frame = CGRectMake(nameLabel.x, nameLabel.maxY + kRealValue(20), kRealValue(170), kRealValue(14));
    [self.userInfoView addSubview:postTimeLabel];
    postTimeLabel.text = [NSString stringWithFormat:@"发布于:%@",[NSDate dateWithTimestamp:self.myDateModel.publish_time format:@"yyyy-MM-dd HH:mm:ss"]];
    
    //信息失效还是有效
    UILabel *validLabel = [UILabel labelWithName:@"" Font:kSystemFont14 textColor:kWhiteTextColor textAlignment:NSTextAlignmentCenter];
    validLabel.backgroundColor = kSepLineGrayBackgroundColor;
    validLabel.layer.cornerRadius = kRealValue(12);
    validLabel.layer.masksToBounds = YES;
    validLabel.frame = CGRectMake(postTimeLabel.maxX + kRealValue(10), postTimeLabel.y - kRealValue(5), kRealValue(80), kRealValue(25));
    [self.userInfoView addSubview:validLabel];
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:self.myDateModel.date_time.doubleValue];
    NSTimeInterval time2 =[date1 timeIntervalSinceNow];
    if (time2 < 0) {
        validLabel.text = @"信息失效";
        validLabel.hidden = NO;
        validLabel.backgroundColor = kSepLineGrayBackgroundColor;
    } else {
        if (self.myDateModel.agree_number == 1) {
            validLabel.hidden = NO;
            validLabel.text = @"邀约成功";
            validLabel.backgroundColor = kPurpleTextColor;
        } else {
            validLabel.hidden = YES;
        }
    }
    
    //图片视频
    if ([self.myDateModel.show1 containsString:@"jpg"]) {
        //图片
        for (int i = 0; i < self.myDateModel.picList.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(15) + i*kRealValue(85), avartarImageView.maxY + kRealValue(20), kRealValue(75), kRealValue(75))];
            imageView.backgroundColor = kGrayBackgroundColor;
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.myDateModel.picList[i]]];
            [self.userInfoView addSubview:imageView];
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicTap:)];
            [imageView addGestureRecognizer:tap];
            self.userInfoView.height = imageView.maxY + kRealValue(20);
        }
    } else if ([self.myDateModel.show1 containsString:@"mp4"]) {
        //视频
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(15), avartarImageView.maxY + kRealValue(20), kRealValue(80), kRealValue(80))];
        imageView.backgroundColor = kGrayBackgroundColor;
        [self.userInfoView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVideoTap:)];
        [imageView addGestureRecognizer:tap];
        self.userInfoView.height = imageView.maxY + kRealValue(20);
    }
}

- (void)setupAppoitmentInfoViewSubViews {
    self.appoitmentInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(100))];
    self.appoitmentInfoView.backgroundColor = [UIColor whiteColor];
    
    CGFloat labelW = kScreenWidth - kRealValue(40);
    CGFloat labelH = kRealValue(16);
    CGFloat labelX = kRealValue(20);
    CGFloat labelY = kRealValue(15);
    
    //约会时间
    NSString *dateTime = [self.myDateModel.date_time isEqualToString:@"0"] ? @"" : [NSDate dateWithTimestamp:self.myDateModel.date_time format:@"yyyy-MM-dd"];
    NSString *rangeTimeStr = [NSString stringWithFormat:@"%@ %@",dateTime,self.myDateModel.duration];
    NSString *totalTimeStr =[NSString stringWithFormat:@"约会时间     %@",rangeTimeStr];
    
    UILabel *timelInfoLabel = [UILabel labelWithName:nil Font:kSystemFont14 textColor:kGrayTextColor textAlignment:NSTextAlignmentLeft];
    timelInfoLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    NSMutableAttributedString *timeInfoLabelAttrString = [self setupAttributeString:totalTimeStr rangeText:rangeTimeStr textColor:kBlackTextColor font:kSystemFont14];
    timelInfoLabel.attributedText = timeInfoLabelAttrString;
    [self.appoitmentInfoView addSubview:timelInfoLabel];
    
    //约会地点
    NSString *rangeLocationStr = self.myDateModel.agree_number != 0 ? self.myDateModel.site : @"约会成功后可见";
    NSString *totalLocationStr =[NSString stringWithFormat:@"约会地点     %@",rangeLocationStr];
    UIColor *rangeColor = self.myDateModel.agree_number != 0 ? kBlackTextColor : [UIColor colorWithHexString:@"#8EBAEC"];
    
    UILabel *locationInfoLabel = [UILabel labelWithName:nil Font:kSystemFont14 textColor:kGrayTextColor textAlignment:NSTextAlignmentLeft];
    locationInfoLabel.frame = CGRectMake(labelX, timelInfoLabel.maxY + kRealValue(15), kRealValue(240), labelH);
    NSMutableAttributedString *locationLabelAttrString = [self setupAttributeString:totalLocationStr rangeText:rangeLocationStr textColor:rangeColor font:kSystemFont14];
    locationInfoLabel.attributedText = locationLabelAttrString;
    [self.appoitmentInfoView addSubview:locationInfoLabel];
    
    //距离
    UIImageView *locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(locationInfoLabel.maxX + kRealValue(15), locationInfoLabel.y, kRealValue(16), kRealValue(16))];
    locationImageView.image = [UIImage imageNamed:@"ic_location_city"];
    [self.appoitmentInfoView addSubview:locationImageView];

    UILabel *distanceLabel = [UILabel labelWithName:[NSString stringWithFormat:@"%ldkm",(long)(self.myDateModel.distance/1000)] Font:kSystemFont14 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    distanceLabel.frame = CGRectMake(locationImageView.maxX + kRealValue(5), locationImageView.y, kRealValue(80), locationImageView.height);
    [self.appoitmentInfoView addSubview:distanceLabel];
    
    //约会方式
    NSString *rangeStyleStr = self.myDateModel.reward_type == 0 ? @"打赏" : @"求打赏";
    NSString *totalStyleStr =[NSString stringWithFormat:@"约会方式     %@",rangeStyleStr];
    
    UILabel *styleInfoLabel = [UILabel labelWithName:nil Font:kSystemFont14 textColor:kGrayTextColor textAlignment:NSTextAlignmentLeft];
    styleInfoLabel.frame = CGRectMake(labelX, distanceLabel.maxY + kRealValue(15), labelW, labelH);
    NSMutableAttributedString *styleInfoLabelAttrString = [self setupAttributeString:totalStyleStr rangeText:rangeStyleStr textColor:kBlackTextColor font:kSystemFont14];
    styleInfoLabel.attributedText = styleInfoLabelAttrString;
    [self.appoitmentInfoView addSubview:styleInfoLabel];
    
    //赏金金额
    NSString *rangeMoneyStr = [NSString stringWithFormat:@"¥%@",self.myDateModel.reward];
    NSString *totalMoneyStr = [NSString stringWithFormat:@"赏金金额     %@",rangeMoneyStr];
    
    UILabel *moneyInfoLabel = [UILabel labelWithName:nil Font:kSystemFont14 textColor:kGrayTextColor textAlignment:NSTextAlignmentLeft];
    moneyInfoLabel.frame = CGRectMake(labelX, styleInfoLabel.maxY + kRealValue(15), labelW, labelH);
    NSMutableAttributedString *moenyInfoLabelAttrString = [self setupAttributeString:totalMoneyStr rangeText:rangeMoneyStr textColor:kRedBackgroundColor font:kSystemFont14];
    moneyInfoLabel.attributedText = moenyInfoLabelAttrString;
    [self.appoitmentInfoView addSubview:moneyInfoLabel];
    
    //约会内容
    NSString *rangeContentStr = self.myDateModel.program_str;
    NSString *totalContentStr = [NSString stringWithFormat:@"约会内容    %@",rangeContentStr];
    
    UILabel *contentInfoLabel = [UILabel labelWithName:nil Font:kSystemFont14 textColor:kGrayTextColor textAlignment:NSTextAlignmentLeft];
    contentInfoLabel.frame = CGRectMake(labelX, moneyInfoLabel.maxY + kRealValue(15), labelW, labelH);
    NSMutableAttributedString *contentInfoLabelAttrString = [self setupAttributeString:totalContentStr rangeText:rangeContentStr textColor:kBlackTextColor font:kSystemFont14];
    contentInfoLabel.attributedText = contentInfoLabelAttrString;
    [self.appoitmentInfoView addSubview:contentInfoLabel];
    
    self.appoitmentInfoView.height = contentInfoLabel.maxY + kRealValue(15);
}

- (void)setupBottomButtons {
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:self.myDateModel.date_time.doubleValue];
    NSTimeInterval time2 =[date1 timeIntervalSinceNow];
    if (time2 < 0) {
        return;
    }

    //Object_id = 0 就是无目标的约会，让其他人主动约她或者报名
    if (self.myDateModel.userId != [UserInfoManager sharedInstance].ID
        && self.myDateModel.object_id != 0) {
        if (self.myDateModel.agree_number == 1){
            //同意约会 显示聊天
            UIButton *chatButton = [UIButton buttonWithTitle:@"聊天" taget:self action:@selector(chatButtonClick) font:kSystemFont15 titleColor:kWhiteTextColor];
            chatButton.frame = CGRectMake(0, kScreenHeight - kTabBarHeight - kNavBarHeight, kScreenWidth, kTabBarHeight);
            [self.view addSubview:chatButton];
            
            CAGradientLayer *btnLayer = [CAGradientLayer layer];
            btnLayer.locations = @[@0.5];
            btnLayer.startPoint = CGPointMake(0, 0);
            btnLayer.endPoint = CGPointMake(1.0, 0.0);
            btnLayer.frame = chatButton.bounds;
            btnLayer.masksToBounds = YES;
            btnLayer.colors = @[(__bridge id)RGB(134, 172, 231).CGColor, (__bridge id)RGB(183, 163, 237).CGColor];
            [chatButton.layer insertSublayer:btnLayer atIndex:0];
        } else if (self.myDateModel.agree_number == 10) {
            //已忽略
            UIButton *ignoreButton = [[UIButton alloc] init];
            ignoreButton.frame = CGRectMake(0, kScreenHeight - kTabBarHeight - kNavBarHeight, kScreenWidth, kTabBarHeight);
            ignoreButton.backgroundColor = kSepLineGrayBackgroundColor;
            [ignoreButton setTitle:@"已忽略" forState:UIControlStateNormal];
            [ignoreButton setTitleColor:kBlackTextColor forState:UIControlStateNormal];
            ignoreButton.titleLabel.font = kSystemFont15;
            ignoreButton.backgroundColor = kSepLineGrayBackgroundColor;
            [self.view addSubview:ignoreButton];
        } else {
            //还没同意约会 显示接受或忽略
            UIButton *ignoreButton = [UIButton buttonWithTitle:@"忽略" taget:self action:@selector(ignoreButtonClick) font:kSystemFont15 titleColor:kBlackTextColor];
            ignoreButton.frame = CGRectMake(0, kScreenHeight - kTabBarHeight - kNavBarHeight, kScreenWidth/2, kTabBarHeight);
            ignoreButton.backgroundColor = kSepLineGrayBackgroundColor;
            [self.view addSubview:ignoreButton];
            
            UIButton *agreeButton = [UIButton buttonWithTitle:@"同意邀约" taget:self action:@selector(agreeButtonClick) font:kSystemFont15 titleColor:kBlackTextColor];
            agreeButton.frame = CGRectMake(kScreenWidth/2, kScreenHeight - kTabBarHeight - kNavBarHeight, kScreenWidth/2, kTabBarHeight);
            [self.view addSubview:agreeButton];
            
            CAGradientLayer *btnLayer = [CAGradientLayer layer];
            btnLayer.locations = @[@0.5];
            btnLayer.startPoint = CGPointMake(0, 0);
            btnLayer.endPoint = CGPointMake(1.0, 0.0);
            btnLayer.frame = agreeButton.bounds;
            btnLayer.masksToBounds = YES;
            btnLayer.colors = @[(__bridge id)RGB(134, 172, 231).CGColor, (__bridge id)RGB(183, 163, 237).CGColor];
            [agreeButton.layer insertSublayer:btnLayer atIndex:0];
        }
    } else if (self.myDateModel.userId != [UserInfoManager sharedInstance].ID
               && self.myDateModel.object_id == 0) {
        if (self.myDateModel.reward_type == 1) {
            //约她
            UIButton *yueTaButton = [UIButton buttonWithTitle:@"约她" taget:self action:@selector(yueTaButtonClick) font:kSystemFont15 titleColor:kWhiteTextColor];
            yueTaButton.frame = CGRectMake(0, kScreenHeight - kTabBarHeight - kNavBarHeight, kScreenWidth, kTabBarHeight);
            [self.view addSubview:yueTaButton];
            
            CAGradientLayer *btnLayer = [CAGradientLayer layer];
            btnLayer.locations = @[@0.5];
            btnLayer.startPoint = CGPointMake(0, 0);
            btnLayer.endPoint = CGPointMake(1.0, 0.0);
            btnLayer.frame = yueTaButton.bounds;
            btnLayer.masksToBounds = YES;
            btnLayer.colors = @[(__bridge id)RGB(134, 172, 231).CGColor, (__bridge id)RGB(183, 163, 237).CGColor];
            [yueTaButton.layer insertSublayer:btnLayer atIndex:0];
        } else {
            //报名
            UIButton *signButton = [UIButton buttonWithTitle:@"报名" taget:self action:@selector(signupButtonClick) font:kSystemFont15 titleColor:kWhiteTextColor];
            signButton.frame = CGRectMake(0, kScreenHeight - kTabBarHeight - kNavBarHeight, kScreenWidth, kTabBarHeight);
            [self.view addSubview:signButton];
            
            CAGradientLayer *btnLayer = [CAGradientLayer layer];
            btnLayer.locations = @[@0.5];
            btnLayer.startPoint = CGPointMake(0, 0);
            btnLayer.endPoint = CGPointMake(1.0, 0.0);
            btnLayer.frame = signButton.bounds;
            btnLayer.masksToBounds = YES;
            btnLayer.colors = @[(__bridge id)RGB(134, 172, 231).CGColor, (__bridge id)RGB(183, 163, 237).CGColor];
            [signButton.layer insertSublayer:btnLayer atIndex:0];
        }
    }
}

- (NSMutableAttributedString *)setupAttributeString:(NSString *)text
                                          rangeText:(NSString *)rangeText
                                          textColor:(UIColor *)color
                                               font:(UIFont *)font {
    NSRange hightlightTextRange = [text rangeOfString:rangeText];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    if (hightlightTextRange.length > 0) {
        [attributeStr addAttribute:NSForegroundColorAttributeName
                             value:color
                             range:hightlightTextRange];
        [attributeStr addAttribute:NSFontAttributeName
                             value:font
                             range:hightlightTextRange];
        return attributeStr;
    } else {
        return attributeStr;
    }
}

#pragma mark - **************** Event
- (void)reportItemClick {
    NSLog(@"举报");
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *addBtn = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        YTReportViewController *report = [[YTReportViewController alloc] init];
        report.userId = self.myDateModel.userId;
        [self.navigationController pushViewController:report animated:YES];
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:addBtn];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)appiontmentButtonClick:(YTApplyModel *)model {
    NSLog(@"与他相约");
    if (model.status == 2) {
        return;
    }
    [UIViewController showAlertViewWithTitle:@"是否确定与Ta相约" message:nil confirmTitle:@"确认" cancelTitle:@"取消" confirmAction:^{
        [MineInterface agreeDate:model.date_id apply_id:model.apply_id andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage) {
            if ([rspStatusAndMessage.message isEqualToString:@"操作成功"]) {
                [self getApplyList];
            }
        }];
    } cancelAction:nil];
}

- (void)showPicTap:(UITapGestureRecognizer *)ges {
    NSLog(@"照片");
    NSInteger index = ges.view.tag;
    NSLog(@"%ld",(long)index);
    [YTAlbumScrollView showAlbumByDataArray:self.myDateModel.picList selectedIndex:index];
}

- (void)showVideoTap:(UITapGestureRecognizer *)ges {
    NSLog(@"视频");
    MPMoviePlayerController *moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:self.myDateModel.show1]];
    moviePlayer.view.frame = self.view.bounds;
    moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:moviePlayer.view];
    [moviePlayer prepareToPlay];
    [moviePlayer play];
}

- (void)chatButtonClick {
    NSLog(@"聊天");
    
    YTMessageDetailViewController *msg = [[YTMessageDetailViewController alloc] initWithConversationChatter:[NSString stringWithFormat:@"%@%ld",HXUserPREFIX,self.myDateModel.userId] conversationType:EMConversationTypeChat];
    [self.navigationController pushViewController:msg animated:YES];
}

- (void)ignoreButtonClick {
    NSLog(@"忽略");
    [MineInterface ignoreDate:self.myDateModel.dateId andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage) {
        if ([rspStatusAndMessage.message isEqualToString:@"操作成功"]) {
            [kAppWindow showAutoHideHudWithText:@"忽略成功"];
            self.myDateModel.agree_number = 10;
            [self setupUI];
        }
    }];
}

- (void)agreeButtonClick {
    NSLog(@"同意邀约");
    [MineInterface agreeDate:self.myDateModel.dateId apply_id:self.myDateModel.userId andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage) {
        if ([rspStatusAndMessage.message isEqualToString:@"您已接受该用户邀约！"]) {
            [kAppWindow showAutoHideHudWithText:@"同意成功"];
            self.myDateModel.agree_number = 1;
            [self setupUI];
        }
    }];
}

- (void)signupButtonClick {
    NSLog(@"报名");
    [MineInterface applyDate:self.myDateModel.dateId andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage, NSDictionary * _Nonnull responseDic) {
        if ([rspStatusAndMessage.message isEqualToString:@"操作成功"]) {
            [kAppWindow showAutoHideHudWithText:@"报名成功"];
        }
    }];
}

- (void)yueTaButtonClick {
    NSLog(@"约ta");
    YTPostAppointmentViewController *post = [[YTPostAppointmentViewController alloc] init];
    post.dateUserId = self.myDateModel.userId;
    [self.navigationController pushViewController:post animated:YES];
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YTAppiontmentPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:YTAppiontmentPersonCellID forIndexPath:indexPath];
    
    cell.applyModel = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    @weakify(self);
    cell.appiontmentButtonClickBlock = ^(YTApplyModel * _Nonnull model) {
        @strongify(self);
        [self appiontmentButtonClick:model];
    };
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRealValue(100);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - **************** Setter Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = kGrayBackgroundColor;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[YTAppiontmentPersonCell class] forCellReuseIdentifier:YTAppiontmentPersonCellID];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        _headerView.backgroundColor = kMineBackgroundColor;
    }
    return _headerView;
}

- (UIView *)userInfoView {
    if (!_userInfoView) {
        _userInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        _userInfoView.backgroundColor = kWhiteBackgroundColor;
    }
    return _userInfoView;
}

- (UIView *)appoitmentInfoView {
    if (!_appoitmentInfoView) {
        _appoitmentInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        _appoitmentInfoView.backgroundColor = kWhiteBackgroundColor;
    }
    return _appoitmentInfoView;
}

- (UIView *)appiontmentPersonListView {
    if (!_appiontmentPersonListView) {
        _appiontmentPersonListView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(30))];
        _appiontmentPersonListView.backgroundColor = kWhiteBackgroundColor;
        
        UILabel *appiontmentPersonListLabel = [UILabel labelWithName:@"邀约人列表" Font:kSystemFont15 textColor:kGrayTextColor textAlignment:NSTextAlignmentLeft];
        appiontmentPersonListLabel.frame = CGRectMake(kRealValue(20), 0, _appiontmentPersonListView.width, kRealValue(30));
        [_appiontmentPersonListView addSubview:appiontmentPersonListLabel];
    }
    return _appiontmentPersonListView;
}


@end
