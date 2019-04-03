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

@interface YTBasicInformationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

static NSString *YTSettingCellID = @"YTSettingCellID";
static NSString *YTBasicInfoTitleCellID = @"YTBasicInfoTitleCellID";

@implementation YTBasicInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"基本资料"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" titleColor:[UIColor whiteColor] target:self action:@selector(rightBarButtonItemClicked)];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    YTSettingItem *personInfoItem = [[YTSettingItem alloc] init];
    personInfoItem.leftTitle = @"个人资料";

    YTSettingItem *avatarItem = [[YTSettingItem alloc] init];
    avatarItem.leftTitle = @"头像";
    avatarItem.cellType = YTSettingItemTypeAvartar;
    avatarItem.cellHeight = kRealValue(80);
    
    YTSettingItem *albumItem = [[YTSettingItem alloc] init];
    albumItem.leftTitle = @"个人相册";
    
    YTSettingItem *photoPermissionItem = [[YTSettingItem alloc] init];
    photoPermissionItem.leftTitle = @"照片权限";
    photoPermissionItem.cellType = YTSettingItemTypeAccessnoryTitle;
    
    YTSettingItem *nickNameItem = [[YTSettingItem alloc] init];
    nickNameItem.leftTitle = @"昵称";
    nickNameItem.rightTitle = @"裘千仞";
    nickNameItem.cellType = YTSettingItemTypeAccessnoryTitle;
    
    YTSettingItem *introItem = [[YTSettingItem alloc] init];
    introItem.leftTitle = @"个人介绍";
    introItem.rightTitle = @"裘千仞";
    introItem.cellType = YTSettingItemTypeAccessnoryTitle;

    YTSettingItem *basicInfoItem = [[YTSettingItem alloc] init];
    basicInfoItem.leftTitle = @"基本资料";
    
    YTSettingItem *sexItem = [[YTSettingItem alloc] init];
    sexItem.leftTitle = @"性别";
    sexItem.rightTitle = @"男";
    sexItem.cellType = YTSettingItemTypeLeftRightTitle;
    
    YTSettingItem *ageItem = [[YTSettingItem alloc] init];
    ageItem.leftTitle = @"年龄";
    ageItem.rightTitle = @"20岁";
    ageItem.cellType = YTSettingItemTypeAccessnoryTitle;
    
    YTSettingItem *intentionItem = [[YTSettingItem alloc] init];
    intentionItem.leftTitle = @"约会意向";
    intentionItem.rightTitle = @"意向";
    intentionItem.cellType = YTSettingItemTypeAccessnoryTitle;
    
    YTSettingItem *relationshipItem = [[YTSettingItem alloc] init];
    relationshipItem.leftTitle = @"感情状况";
    relationshipItem.rightTitle = @"感情";
    relationshipItem.cellType = YTSettingItemTypeAccessnoryTitle;
    
    YTSettingItem *careerItem = [[YTSettingItem alloc] init];
    careerItem.leftTitle = @"职业";
    careerItem.rightTitle = @"职业";
    careerItem.cellType = YTSettingItemTypeAccessnoryTitle;
    
    YTSettingItem *heightItem = [[YTSettingItem alloc] init];
    heightItem.leftTitle = @"身高";
    heightItem.rightTitle = @"170cm";
    heightItem.cellType = YTSettingItemTypeAccessnoryTitle;
    
    YTSettingItem *weightItem = [[YTSettingItem alloc] init];
    weightItem.leftTitle = @"体重";
    weightItem.rightTitle = @"70kg";
    weightItem.cellType = YTSettingItemTypeAccessnoryTitle;
    
    YTSettingItem *wechatItem = [[YTSettingItem alloc] init];
    wechatItem.leftTitle = @"微信";
    wechatItem.rightTitle = @"";
    wechatItem.cellType = YTSettingItemTypeAccessnoryTitle;
    
    YTSettingItem *educationItem = [[YTSettingItem alloc] init];
    educationItem.leftTitle = @"学历";
    educationItem.rightTitle = @"博士后";
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
            
        } videoCompleteBlock:nil];
    } else if ([item.leftTitle isEqualToString:@"个人相册"]) {
        YTMyAlbumViewController *myAlbum = [[YTMyAlbumViewController alloc] init];
        [self.navigationController pushViewController:myAlbum animated:YES];
    } else if ([item.leftTitle isEqualToString:@"照片权限"]) {
        [YTPhotoPermissionAlertView showAlertViewValueSelectBlock:^(NSString * _Nonnull valueString) {
            if ([valueString isEqualToString:@"付费"]) {
                [YTSetAppionmentMoneyAlertView showAlertViewMoenySetBlock:^(NSString * _Nonnull money) {
                    item.rightTitle = money;
                    [self.tableView reloadData];
                }];
            } else {
                item.rightTitle = valueString;
                [self.tableView reloadData];
            }
        }];
    } else if ([item.leftTitle isEqualToString:@"昵称"]) {
        YTChangeBasicInfoInputViewController *nickName = [[YTChangeBasicInfoInputViewController alloc] init];
        nickName.placeholder = @"请输入昵称";
        [self.navigationController pushViewController:nickName animated:YES];
    } else if ([item.leftTitle isEqualToString:@"个人介绍"]) {
        YTPersonIntroductionViewController *intro = [[YTPersonIntroductionViewController alloc] init];
        [self.navigationController pushViewController:intro animated:YES];
    } else if ([item.leftTitle isEqualToString:@"年龄"]) {
        [YTBasicInfoInputAlertView showAlertViewWithPlaceHolder:@"请输入年龄" inputConfirmBlock:^(NSString * _Nonnull inputText) {
            item.rightTitle = inputText;
            [self.tableView reloadData];
        }];
    } else if ([item.leftTitle isEqualToString:@"约会意向"]) {
        YTAppointmentContentViewController *appointment = [[YTAppointmentContentViewController alloc] init];
        appointment.contentSelectedBlock = ^(NSString * _Nonnull content) {
            item.rightTitle = content;
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:appointment animated:YES];
    } else if ([item.leftTitle isEqualToString:@"感情状况"]) {
        [ValuePickerView showPickerWithTitle:@"请选择感情状况"
                                  dataSource:@[@"单身",@"恋爱",@"已婚",@"分居",@"离异"]
                                  defaultStr:nil
                         valueDidSelectBlock:^(NSString *selectedString, NSInteger index) {
                             item.rightTitle = selectedString;
                             [self.tableView reloadData];
                         }];
    } else if ([item.leftTitle isEqualToString:@"职业"]) {
        NSArray *manJobList = @[@"金融",@"互联网",@"私企",@"国企",@"投资人",@"夜场",@"创业",@"学生",@"高管",@"老板",@"金领",@"白领",@"无业游民",@"自由职业者",@"个体",@"其他"];
        NSArray *femaleJobList = @[@"学生",@"少妇",@"夜场",@"OL",@"老师",@"金融",@"家庭主妇",@"空姐",@"模特",@"主播",@"网红",@"秘书",@"护士",@"设计师",@"前台",@"健身教练",@"演员",@"高管",@"销售",@"其他"];
        [ValuePickerView showPickerWithTitle:@"请选择感情状况"
                                  dataSource:manJobList
                                  defaultStr:nil
                         valueDidSelectBlock:^(NSString *selectedString, NSInteger index) {
                             item.rightTitle = selectedString;
                             [self.tableView reloadData];
                         }];
    } else if ([item.leftTitle isEqualToString:@"身高"]) {
        [YTBasicInfoInputAlertView showAlertViewWithPlaceHolder:@"请输入身高(CM)" inputConfirmBlock:^(NSString * _Nonnull inputText) {
            item.rightTitle = inputText;
            [self.tableView reloadData];
        }];
    } else if ([item.leftTitle isEqualToString:@"体重"]) {
        [YTBasicInfoInputAlertView showAlertViewWithPlaceHolder:@"请输入体重(KG)" inputConfirmBlock:^(NSString * _Nonnull inputText) {
            item.rightTitle = inputText;
            [self.tableView reloadData];
        }];
    } else if ([item.leftTitle isEqualToString:@"微信"]) {
        YTChangeBasicInfoInputViewController *nickName = [[YTChangeBasicInfoInputViewController alloc] init];
        nickName.placeholder = @"请填写微信";
        [self.navigationController pushViewController:nickName animated:YES];
    } else if ([item.leftTitle isEqualToString:@"学历"]) {
        [ValuePickerView showPickerWithTitle:@"请选择学历"
                                  dataSource:@[@"小学",@"初中",@"高中",@"专科",@"本科",@"研究生",@"博士",@"博士后"]
                                  defaultStr:nil
                         valueDidSelectBlock:^(NSString *selectedString, NSInteger index) {
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
