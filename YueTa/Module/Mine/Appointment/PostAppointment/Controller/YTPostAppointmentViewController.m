//
//  YTPostAppointmentViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTPostAppointmentViewController.h"
#import "YTAppointmentContentViewController.h"
#import "YTAppiontmentAddressViewController.h"

#import "YTPostAppointmentContentView.h"
#import "YTPostAppointmentStyleView.h"
#import "YTPostAppointmentTimeView.h"
#import "YTPostAppointmentAddressView.h"
#import "YTPostAppointmentImageVideoView.h"
#import "ValuePickerView.h"
#import "YCTimePickerView.h"
#import "MineInterface.h"
#import "UserInterface.h"
#import "YTSelectPictureHelper.h"

@interface YTPostAppointmentViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YTPostAppointmentContentView *contentView;
@property (nonatomic, strong) YTPostAppointmentStyleView *styleView;
@property (nonatomic, strong) YTPostAppointmentTimeView *timeView;
@property (nonatomic, strong) YTPostAppointmentAddressView *addressView;
@property (nonatomic, strong) UIView *sepLine;
@property (nonatomic, strong) YTPostAppointmentImageVideoView *imageVideoView;
@property (nonatomic, strong) UIButton *postButton;
@property (nonatomic, strong) UILabel *tipsLabel;

@property (nonatomic, copy) NSString *program;
@property (nonatomic, assign) NSInteger reward_type;
@property (nonatomic, copy) NSString *date_time;
@property (nonatomic, copy) NSString *duration;
@property (nonatomic, assign) NSInteger reward;
@property (nonatomic, assign) NSInteger use_coin;
@property (nonatomic, copy) NSString *area;//所在区域
@property (nonatomic, copy) NSString *site;//约会地点
@property (nonatomic, assign) double site_abscissa;
@property (nonatomic, assign) double site_ordinate;

@end

@implementation YTPostAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    [self.scrollView addSubview:self.styleView];
    [self.scrollView addSubview:self.timeView];
    [self.scrollView addSubview:self.addressView];
    [self.scrollView addSubview:self.sepLine];
    [self.scrollView addSubview:self.imageVideoView];
    [self.scrollView addSubview:self.postButton];
    [self.scrollView addSubview:self.tipsLabel];

    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).offset(kRealValue(10));
        make.left.equalTo(self.scrollView);
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@kRealValue(50));
    }];
    
    [self.styleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.scrollView);
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@kRealValue(90));
    }];
    
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.styleView.mas_bottom);
        make.left.equalTo(self.scrollView);
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@kRealValue(90));
    }];
    
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeView.mas_bottom);
        make.left.equalTo(self.scrollView);
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@kRealValue(50));
    }];
    
    [self.sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressView.mas_bottom);
        make.left.equalTo(self.scrollView);
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@kRealValue(10));
    }];
    
    [self.imageVideoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sepLine.mas_bottom);
        make.left.equalTo(self.scrollView);
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@kRealValue(153));
    }];
    
    [self.postButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageVideoView.mas_bottom).offset(kRealValue(50));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kRealValue(325), kRealValue(45)));
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.postButton.mas_bottom).offset(kRealValue(15));
        make.left.and.right.equalTo(self.view);
    }];
}

#pragma mark - **************** Event Response
- (void)postAppiontmentClicked {
    
    if (!self.program.length) {
        [kAppWindow showAutoHideHudWithText:@"请选择约会内容"];
        return;
    }
    if (self.reward == 0) {
        [kAppWindow showAutoHideHudWithText:@"请选择打赏金额"];
        return;
    }
    [kAppWindow showIndeterminateHudWithText:@"请稍后.."];
    if (self.imageVideoView.isSelectVideo) {
        //选择视频
        [[YTSelectPictureHelper sharedHelper] convertVideoQuailtyWithInputURL:self.imageVideoView.videoURL completeHandler:^(AVAssetExportSession * _Nullable session) {
            if (session) {
                [YTUploadHelper uploadVideoToQiniu:session.outputURL progressHandler:^(NSString * _Nonnull progressShowValue, float percent) {
                } andComplete:^(NSMutableArray * _Nullable fileNameArray) {
                    [self postAppiontmentByVideoUrl:fileNameArray[0] imageUrls:nil];
                }];
            }
        }];
    } else if (!self.imageVideoView.isSelectVideo && self.imageVideoView.imageArray.count) {
        //选择图片
        [YTUploadHelper uploadImageArrayToQiniu:self.imageVideoView.imageArray isSelectOriginalPhoto:NO progressHandler:^(NSString * _Nonnull progressShowValue, float percent) {
        } andComplete:^(NSMutableArray * _Nullable fileNameArray) {
            if (fileNameArray.count) {
                [self postAppiontmentByVideoUrl:nil imageUrls:fileNameArray];
            } else {
                [kAppWindow showAutoHideHudWithText:@"图片上传失败,请重试"];
            }
        }];
    } else {
        //没有视频图片
        [self postAppiontmentByVideoUrl:nil imageUrls:nil];
    }
}

- (void)postAppiontmentByVideoUrl:(NSString *)videoUrl imageUrls:(NSArray *)imageUrls {
    
    NSString *show1;
    NSString *show2;
    NSString *show3;
    NSString *show4;

    if (videoUrl) {
        show1 = videoUrl;
    } else {
        if (imageUrls.count == 1) {
            show1 = imageUrls[0];
        }
        if (imageUrls.count == 2) {
            show2 = imageUrls[1];
        }
        if (imageUrls.count == 3) {
            show3 = imageUrls[2];
        }
        if (imageUrls.count == 4) {
            show4 = imageUrls[3];
        }
    }
    
    [MineInterface postYuaTaByObject_id:self.dateUserId area:self.area use_coin:1 date_time:self.date_time duration:self.duration reward_type:self.reward_type reward:self.reward program:self.program site:self.site show1:show1 show2:show2 show3:show3 show4:show4 site_abscissa:0 site_ordinate:0 andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage, NSDictionary * _Nonnull responseDic) {
        [kAppWindow hideHud];
        if ([rspStatusAndMessage.message containsString:@"邀约成功"]) {
            [kAppWindow showAutoHideHudWithText:rspStatusAndMessage.message];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
}

- (void)selectAppiontmentContentClicked {
    NSLog(@"约会内容");
    [UserInterface getRegisterTagLabelAndBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage, AllInfoModel * _Nonnull model) {
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            YTAppointmentContentViewController *contentVC = [[YTAppointmentContentViewController alloc] init];
            contentVC.engagementArr = model.engagementArr;
            contentVC.contentSelectedBlock = ^(NSString * _Nonnull content) {
                NSLog(@"%@",content);
                self.program = [NSString stringWithFormat:@"%ld",[model.engagementArr indexOfObject:content]];
                [self.contentView refreshViewByContent:content];
            };
            [self.navigationController pushViewController:contentVC animated:YES];
        }
    }];
}

- (void)selectStyleClicked {
    NSLog(@"打赏金额");
    [ValuePickerView showPickerWithTitle:@"请选择打赏金额"
                              dataSource:@[@"100",@"200",@"300",@"400"]
                              defaultStr:nil
                     valueDidSelectBlock:^(NSString *selectedString, NSInteger index) {
                         self.reward = selectedString.integerValue;
                         [self.styleView refreshViewByMoney:selectedString];
                     }];
}

- (void)selectDateClicked {
    NSLog(@"日期");
    [YCTimePickerView timePickerWithType:YCTimePickerViewYearMothDay
                                 maxDate:@"2030-12-31"
                            selectedYear:2019
                           selectedMonth:1
                             selectedDay:1
                               timeBlock:^(NSInteger year, NSInteger month, NSInteger day) {
                                   NSString *dateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",year, month, day];
                                   NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                   [dateFormatter setDateFormat:@"YYYY-MM-dd"];
                                   NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
                                   [dateFormatter setTimeZone:timeZone];
                                   NSDate *date = [dateFormatter dateFromString:dateStr];
                                   self.date_time = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] stringValue];;
                                   [self.timeView refreshViewByDate:dateStr];
                               }];
}

- (void)selectTimeClicked {
    NSLog(@"时间");
    [ValuePickerView showPickerWithTitle:@"请选择时间"
                              dataSource:@[@"一天",@"上午",@"中午",@"下午",@"晚上",@"通宵"]
                              defaultStr:nil
                     valueDidSelectBlock:^(NSString *selectedString, NSInteger index) {
                         self.duration = selectedString;
                         [self.timeView refreshViewByTime:selectedString];
                     }];
}

- (void)selectAddressClicked {
    NSLog(@"选择地区");
    YTAppiontmentAddressViewController *address = [[YTAppiontmentAddressViewController alloc] init];
    address.addressComfirmBlock = ^(NSString * _Nonnull area, NSString * _Nonnull site, CLLocationCoordinate2D coordinate) {
        self.site_abscissa = coordinate.longitude;
        self.site_ordinate = coordinate.latitude;
        self.area = area;
        self.site = site;
        [self.addressView refreshViewByAddress:site];
    };
    [self.navigationController pushViewController:address animated:YES];
}

#pragma mark - **************** Setter Getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.contentSize = CGSizeMake(0, kRealValue(610));
    }
    return _scrollView;
}

- (YTPostAppointmentContentView *)contentView {
    if (!_contentView) {
        _contentView = [[YTPostAppointmentContentView alloc] init];
        @weakify(self);
        _contentView.contentViewClickedBlock = ^{
            @strongify(self);
            [self selectAppiontmentContentClicked];
        };
    }
    return _contentView;
}

- (YTPostAppointmentStyleView *)styleView {
    if (!_styleView) {
        _styleView = [[YTPostAppointmentStyleView alloc] init];
        @weakify(self);
        _styleView.styleClickedBlock = ^{
            @strongify(self);
            [self selectStyleClicked];
        };
        
        _styleView.rewardTypeClickBlock = ^(NSInteger index) {
            @strongify(self);
            self.reward_type = index;
        };
    }
    return _styleView;
}

- (YTPostAppointmentTimeView *)timeView {
    if (!_timeView) {
        _timeView = [[YTPostAppointmentTimeView alloc] init];
        @weakify(self);
        _timeView.dateClickedBlock = ^{
            @strongify(self);
            [self selectDateClicked];
        };
        _timeView.timeClickedBlock = ^{
            @strongify(self);
            [self selectTimeClicked];
        };
    }
    return _timeView;
}

- (YTPostAppointmentAddressView *)addressView {
    if (!_addressView) {
        _addressView = [[YTPostAppointmentAddressView alloc] init];
        @weakify(self);
        _addressView.selectAddressBlock = ^{
            @strongify(self);
            [self selectAddressClicked];
        };
    }
    return _addressView;
}

- (UIView *)sepLine {
    if (!_sepLine) {
        _sepLine = [[UIView alloc] init];
        _sepLine.backgroundColor = kMineBackgroundColor;
    }
    return _sepLine;
}

- (YTPostAppointmentImageVideoView *)imageVideoView {
    if (!_imageVideoView) {
        _imageVideoView = [[YTPostAppointmentImageVideoView alloc] init];
    }
    return _imageVideoView;
}

- (UIButton *)postButton {
    if (!_postButton) {
        NSString *title = self.dateUserId > 0 ? @"邀请约会" : @"发布约会";
        _postButton = [UIButton buttonWithTitle:title taget:self action:@selector(postAppiontmentClicked) font:kSystemFont16 titleColor:[UIColor whiteColor]];
        _postButton.layer.cornerRadius = 20;
        _postButton.backgroundColor = kPurpleTextColor;
    }
    return _postButton;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [UILabel labelWithName:@"已认证女士免费,VIP可免费邀约10次，否则需要支付10约豆" Font:kSystemFont13 textColor:kGrayTextColor textAlignment:NSTextAlignmentCenter];
    }
    return _tipsLabel;
}

@end
