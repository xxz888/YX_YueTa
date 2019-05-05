//
//  YTBasicInformationViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/7.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTBasicInformationViewController.h"
#import "YTMyAlbumViewController.h"
#import "YTChangeBasicInfoInputViewController.h"
#import "YTPersonIntroductionViewController.h"
#import "YTAppointmentContentViewController.h"
#import "YTSetAppionmentMoneyAlertView.h"

#import "ValuePickerView.h"
#import "YTPhotoPermissionAlertView.h"
#import "YTBasicInfoInputAlertView.h"

#import "YTSettingItem.h"
#import "YTSettingCell.h"
#import "YTBasicInfoTitleCell.h"
#import "YTSelectPictureHelper.h"
#import "MineInterface.h"
#import "UserInterface.h"
#import "YTUserModel.h"

@interface YTBasicInformationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) YTUserModel *userModel;
@property (nonatomic, strong) AllInfoModel *tagsModel;
@property (nonatomic, strong) NSArray *emotionArray;
@property (nonatomic, strong) NSArray *educationArray;


@end

static NSString *YTSettingCellID = @"YTSettingCellID";
static NSString *YTBasicInfoTitleCellID = @"YTBasicInfoTitleCellID";

@implementation YTBasicInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _emotionArray = @[@"已婚",@"单身",@"热恋中",@"保密"];
    _educationArray = @[@"初中",@"高中",@"专科",@"本科",@"研究生",@"博士",@"博士后"];
    
    [self setNavigationBarTitle:@"基本资料"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" titleColor:[UIColor whiteColor] target:self action:@selector(rightBarButtonItemClicked)];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [UserInterface getRegisterTagLabelAndBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage, AllInfoModel * _Nonnull model) {
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            self.tagsModel = model;
        }
    }];
    
    [MineInterface getPersonalDataAndBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage, NSDictionary * _Nonnull userDataDic) {
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            YTUserModel *userModel = [YTUserModel mj_objectWithKeyValues:userDataDic];
            self.userModel = userModel;
            [self createDataSource];
        }
    }];
}

- (void)createDataSource {
    YTSettingItem *personInfoItem = [[YTSettingItem alloc] init];
    personInfoItem.leftTitle = @"个人资料";

    YTSettingItem *avatarItem = [[YTSettingItem alloc] init];
    avatarItem.leftTitle = @"头像";
    avatarItem.cellType = YTSettingItemTypeAvartar;
    avatarItem.cellHeight = kRealValue(80);
    avatarItem.avatarURL = self.userModel.photo;
    
    YTSettingItem *albumItem = [[YTSettingItem alloc] init];
    albumItem.leftTitle = @"个人相册";
    
    YTSettingItem *photoPermissionItem = [[YTSettingItem alloc] init];
    photoPermissionItem.leftTitle = @"照片权限";
    photoPermissionItem.rightTitle = self.userModel.auth_photo ? [NSString stringWithFormat:@"收费%ld",(long)self.userModel.auth_photo] : @"公开";
    photoPermissionItem.cellType = YTSettingItemTypeAccessnoryTitle;
    
    YTSettingItem *nickNameItem = [[YTSettingItem alloc] init];
    nickNameItem.leftTitle = @"昵称";
    nickNameItem.rightTitle = self.userModel.username;
    nickNameItem.cellType = YTSettingItemTypeAccessnoryTitle;
    
    YTSettingItem *introItem = [[YTSettingItem alloc] init];
    introItem.leftTitle = @"个人介绍";
    introItem.rightTitle = self.userModel.introduction.length ? self.userModel.introduction : @"这个人很懒，什么都没留下";
    introItem.cellType = YTSettingItemTypeAccessnoryTitle;

    YTSettingItem *basicInfoItem = [[YTSettingItem alloc] init];
    basicInfoItem.leftTitle = @"基本资料";
    
    YTSettingItem *sexItem = [[YTSettingItem alloc] init];
    sexItem.leftTitle = @"性别";
    sexItem.rightTitle = self.userModel.gender == 0 ? @"男" : @"女";
    sexItem.cellType = YTSettingItemTypeLeftRightTitle;
    
    YTSettingItem *ageItem = [[YTSettingItem alloc] init];
    ageItem.leftTitle = @"年龄";
    ageItem.rightTitle = self.userModel.age;
    ageItem.cellType = YTSettingItemTypeAccessnoryTitle;
    
    YTSettingItem *intentionItem = [[YTSettingItem alloc] init];
    intentionItem.leftTitle = @"约会意向";
    intentionItem.rightTitle = self.userModel.program;
    intentionItem.cellType = YTSettingItemTypeAccessnoryTitle;
    
    YTSettingItem *relationshipItem = [[YTSettingItem alloc] init];
    relationshipItem.leftTitle = @"感情状况";
    relationshipItem.rightTitle = _emotionArray[self.userModel.emotion];
    relationshipItem.cellType = YTSettingItemTypeAccessnoryTitle;
    
    NSArray *jobArr = self.userModel.gender == 0 ? self.tagsModel.maleJobsArr : self.tagsModel.famaleJobsArr;
    YTSettingItem *careerItem = [[YTSettingItem alloc] init];
    careerItem.leftTitle = @"职业";
    if (jobArr) {
        careerItem.rightTitle = jobArr[self.userModel.job];
    }
    careerItem.cellType = YTSettingItemTypeAccessnoryTitle;
    
    YTSettingItem *heightItem = [[YTSettingItem alloc] init];
    heightItem.leftTitle = @"身高";
    heightItem.rightTitle = [NSString stringWithFormat:@"%@cm", self.userModel.height];
    heightItem.cellType = YTSettingItemTypeAccessnoryTitle;
    
    YTSettingItem *weightItem = [[YTSettingItem alloc] init];
    weightItem.leftTitle = @"体重";
    weightItem.rightTitle = [NSString stringWithFormat:@"%@kg",self.userModel.weight];
    weightItem.cellType = YTSettingItemTypeAccessnoryTitle;
    
    YTSettingItem *wechatItem = [[YTSettingItem alloc] init];
    wechatItem.leftTitle = @"微信";
    wechatItem.rightTitle = self.userModel.wechat;
    wechatItem.cellType = YTSettingItemTypeAccessnoryTitle;
    
    YTSettingItem *educationItem = [[YTSettingItem alloc] init];
    educationItem.leftTitle = @"学历";
    educationItem.rightTitle = _educationArray[self.userModel.education];
    educationItem.cellType = YTSettingItemTypeAccessnoryTitle;
    
    self.dataArray = [@[@[personInfoItem,
                         avatarItem,
                         albumItem,
                         photoPermissionItem,
                         nickNameItem,
                         introItem],
                       @[basicInfoItem,
                         sexItem,
                         ageItem,
                         intentionItem,
                         relationshipItem,
                         careerItem,
                         heightItem,
                         weightItem,
                         wechatItem,
                         educationItem]] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - **************** Event Response
- (void)rightBarButtonItemClicked {
    
    [MineInterface modifyUserInfoWithUsername:self.userModel.username gender:self.userModel.gender age:self.userModel.age.integerValue photo:self.userModel.photo job:self.userModel.job height:self.userModel.height weight:self.userModel.weight emotion:self.userModel.emotion program:self.userModel.program wechat:self.userModel.wechat education:self.userModel.education introduction:self.userModel.introduction province:self.userModel.province city:self.userModel.city auth_photo:self.userModel.auth_photo andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage) {
        if ([rspStatusAndMessage.message isEqualToString:@"操作成功"]) {
        }
    }];
    
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YTSettingItem *item = self.dataArray[indexPath.section][indexPath.row];
    
    if (indexPath.row == 0) {
        YTBasicInfoTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:YTBasicInfoTitleCellID forIndexPath:indexPath];
        [cell configureCellBySettingItem:item];
        return cell;
    }
    
    YTSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:YTSettingCellID forIndexPath:indexPath];
    [cell configureCellBySettingItem:item];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YTSettingItem *item = self.dataArray[indexPath.section][indexPath.row];
    return item.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return kSystemCellSectionHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YTSettingItem *item = self.dataArray[indexPath.section][indexPath.row];
    if ([item.leftTitle isEqualToString:@"头像"]) {
        [[YTSelectPictureHelper sharedHelper] showVideoPictureSelectActionSheetWithMaxPicCount:1 isNeedVideo:NO pictureCompleteBlock:^(NSArray * _Nonnull selectImageArray) {
            
            [YTUploadHelper uploadImageArrayToQiniu:selectImageArray isSelectOriginalPhoto:NO progressHandler:^(NSString * _Nonnull progressShowValue, float percent) {
            } andComplete:^(NSMutableArray * _Nonnull fileNameArray) {
                item.avatarURL = fileNameArray[0];
                [self.tableView reloadData];
            }];
        } videoCompleteBlock:nil];
    } else if ([item.leftTitle isEqualToString:@"个人相册"]) {
        YTMyAlbumViewController *myAlbum = [[YTMyAlbumViewController alloc] init];
        myAlbum.isMineAlbum = YES;
        [self.navigationController pushViewController:myAlbum animated:YES];
    } else if ([item.leftTitle isEqualToString:@"照片权限"]) {
        [YTPhotoPermissionAlertView showAlertViewValueSelectBlock:^(NSString * _Nonnull valueString) {
            if ([valueString isEqualToString:@"付费"]) {
                [YTSetAppionmentMoneyAlertView showAlertViewMoenySetBlock:^(NSString * _Nonnull money) {
                    self.userModel.auth_photo = money.integerValue;
                    item.rightTitle = [NSString stringWithFormat:@"收费%@",money];
                    [self.tableView reloadData];
                }];
            } else {
                self.userModel.auth_photo = 0;
                item.rightTitle = valueString;
                [self.tableView reloadData];
            }
        }];
    } else if ([item.leftTitle isEqualToString:@"昵称"]) {
        YTChangeBasicInfoInputViewController *nickName = [[YTChangeBasicInfoInputViewController alloc] init];
        nickName.placeholder = @"请输入昵称";
        nickName.basicInfoCompleteInputBlock = ^(NSString * _Nonnull text) {
            self.userModel.username = text;
            item.rightTitle = text;
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:nickName animated:YES];
    } else if ([item.leftTitle isEqualToString:@"个人介绍"]) {
        YTPersonIntroductionViewController *intro = [[YTPersonIntroductionViewController alloc] init];
        intro.personalaArr = self.tagsModel.personalaArr;
        intro.personIntroductionSaveBlock = ^(NSString * _Nonnull text) {
            self.userModel.introduction = text;
            item.rightTitle = text;
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:intro animated:YES];
    } else if ([item.leftTitle isEqualToString:@"年龄"]) {
        [YTBasicInfoInputAlertView showAlertViewWithPlaceHolder:@"请输入年龄" inputConfirmBlock:^(NSString * _Nonnull inputText) {
            item.rightTitle = inputText;
            [self.tableView reloadData];
        }];
    } else if ([item.leftTitle isEqualToString:@"约会意向"]) {
        YTAppointmentContentViewController *appointment = [[YTAppointmentContentViewController alloc] init];
        appointment.engagementArr = self.tagsModel.engagementArr;
        appointment.contentSelectedBlock = ^(NSString * _Nonnull content) {
            self.userModel.program = content;
            item.rightTitle = content;
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:appointment animated:YES];
    } else if ([item.leftTitle isEqualToString:@"感情状况"]) {
        [ValuePickerView showPickerWithTitle:@"请选择感情状况"
                                  dataSource:_emotionArray
                                  defaultStr:nil
                         valueDidSelectBlock:^(NSString *selectedString, NSInteger index) {
                             self.userModel.emotion = index;
                             item.rightTitle = selectedString;
                             [self.tableView reloadData];
                         }];
    } else if ([item.leftTitle isEqualToString:@"职业"]) {
        [ValuePickerView showPickerWithTitle:@"请选择职业"
                                  dataSource:self.userModel.gender == 0 ? self.tagsModel.maleJobsArr : self.tagsModel.famaleJobsArr
                                  defaultStr:nil
                         valueDidSelectBlock:^(NSString *selectedString, NSInteger index) {
                             self.userModel.job = index;
                             item.rightTitle = selectedString;
                             [self.tableView reloadData];
                         }];
    } else if ([item.leftTitle isEqualToString:@"身高"]) {
        // 身高范围100-250cm
        [YTBasicInfoInputAlertView showAlertViewWithPlaceHolder:@"请输入身高(CM)" inputConfirmBlock:^(NSString * _Nonnull inputText) {
            if (inputText.integerValue > 250
                || inputText.integerValue < 100) {
                [kAppWindow showAutoHideHudWithText:@"身高范围100-250cm"];
                return;
            }
            self.userModel.height = inputText;
            item.rightTitle = inputText;
            [self.tableView reloadData];
        }];
    } else if ([item.leftTitle isEqualToString:@"体重"]) {
        // 体重范围25-150kg
        [YTBasicInfoInputAlertView showAlertViewWithPlaceHolder:@"请输入体重(KG)" inputConfirmBlock:^(NSString * _Nonnull inputText) {
            if (inputText.integerValue > 150
                || inputText.integerValue < 25) {
                [kAppWindow showAutoHideHudWithText:@"体重范围25-150kg"];
                return;
            }
            self.userModel.weight = [NSString stringWithFormat:@"%@",inputText];
            item.rightTitle = inputText;
            [self.tableView reloadData];
        }];
    } else if ([item.leftTitle isEqualToString:@"微信"]) {
        YTChangeBasicInfoInputViewController *wx = [[YTChangeBasicInfoInputViewController alloc] init];
        wx.placeholder = @"请填写微信";
        wx.basicInfoCompleteInputBlock = ^(NSString * _Nonnull text) {
            self.userModel.wechat = text;
            item.rightTitle = text;
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:wx animated:YES];
    } else if ([item.leftTitle isEqualToString:@"学历"]) {
        [ValuePickerView showPickerWithTitle:@"请选择学历"
                                  dataSource:_educationArray
                                  defaultStr:nil
                         valueDidSelectBlock:^(NSString *selectedString, NSInteger index) {
                             self.userModel.education = index;
                             item.rightTitle = selectedString;
                             [self.tableView reloadData];
                         }];
    }
}

#pragma mark - **************** Setter Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = kGrayBackgroundColor;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[YTSettingCell class] forCellReuseIdentifier:YTSettingCellID];
        [_tableView registerClass:[YTBasicInfoTitleCell class] forCellReuseIdentifier:YTBasicInfoTitleCellID];
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

@end
