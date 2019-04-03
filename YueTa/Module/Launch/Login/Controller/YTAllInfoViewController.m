//
//  YTAllInfoViewController.m
//  YueTa
//
//  Created by 姚兜兜 on 2019/1/10.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTAllInfoViewController.h"
#import "BaseConfigModel.h"
#import "YTAllInfoCell.h"
#import "YTAllInfoFooter.h"
#import "UserInterface.h"
#import "YTAllInfoPicker.h"
#import "YCAddressPickerView.h"

static NSString *Identifier = @"Identifier";

@interface YTAllInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YTAllInfoFooter *footer;
@property (nonatomic, strong) AllInfoModel *model;

@property (nonatomic, strong) NSArray *educationArr;
@property (nonatomic, strong) NSArray *heightArr;
@property (nonatomic, strong) NSArray *weightArr;

@end

@implementation YTAllInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationBarTitle:@"完善资料"];
    
    [self requestData];
    
    [self configData];
}

- (void)configData {
    self.dataArray = @[[BaseConfigModel modelWithTitle:@"职业" subTitle:@"" icon:@""],
                       [BaseConfigModel modelWithTitle:@"城市" subTitle:@"" icon:@""],
                       [BaseConfigModel modelWithTitle:@"学历" subTitle:@"" icon:@""],
                       [BaseConfigModel modelWithTitle:@"身高(cm)" subTitle:@"" icon:@""],
                       [BaseConfigModel modelWithTitle:@"体重(kg)" subTitle:@"" icon:@""]
                       ];
}

- (void)requestData {
    [UserInterface getRegisterTagLabelAndBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage, AllInfoModel * _Nonnull model) {
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            self.model = model;
            [self setupSubViews];
            [self.footer setupTapLabelWithArray:model.personalaArr];
            [self.tableView setTableFooterView:self.footer];
        }
    }];
}

#pragma mark - events
- (void)continueButtonClick {
    
    [self.view endEditing:YES];
    
    if (!self.model.job.length) {
        [self.view showAutoHideHudWithText:@"请选择职业"];
        return;
    }
    if (!self.model.city.length || !self.model.province.length) {
        [self.view showAutoHideHudWithText:@"请选择城市"];
        return;
    }
    if (!self.model.education.length) {
        [self.view showAutoHideHudWithText:@"请选择学历"];
        return;
    }
    if (!self.model.height.length) {
        [self.view showAutoHideHudWithText:@"请选择身高"];
        return;
    }
    if (!self.model.weight.length) {
        [self.view showAutoHideHudWithText:@"请选择体重"];
        return;
    }
    
    if (!self.footer.wxStr.length && !self.footer.phoneStr.length) {
        [self.view showAutoHideHudWithText:@"联系方式至少填写1种"];
        return;
    }
    if (!self.footer.introduceStr.length) {
        [self.view showAutoHideHudWithText:@"请选择个人介绍"];
        return;
    }
    
    if (self.footer.wxStr.length > 20) {
        [self.view showAutoHideHudWithText:@"微信号不能超过20位字符"];
        return;
    }
    
    if (self.footer.introduceStr.length > 100) {
        [self.view showAutoHideHudWithText:@"个人介绍不能超过100位字符"];
        return;
    }
    
    [self.view showIndeterminateHudWithText:nil];
    [UserInterface completeUserInfoWithMobile:self.mobile password:self.password username:self.username gender:self.gender age:self.age job:self.model.job height:self.model.height weight:self.model.weight education:self.model.educationInt province:self.model.province city:self.model.city wechat:self.footer.wxStr introduction:self.footer.introduceStr andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage,  NSDictionary *responseDataDic) {
        [self.view hideHud];
        
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            [[UserInfoManager sharedInstance] saveUserInfo:responseDataDic];
            [UserInterface initHuanXinAndBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage) {
                if ([rspStatusAndMessage.message isEqualToString:@"操作成功！"]) {
                    [self turnToMainTabBarViewController];
                }
            }];
        }
    }];
}

#pragma mark - UI
- (void)setupSubViews {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight -kRealValue(65)) style:UITableViewStylePlain];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView registerClass:[YTAllInfoCell class] forCellReuseIdentifier:Identifier];
    [self.view addSubview:self.tableView];
    
    self.footer = [[YTAllInfoFooter alloc] init];
    self.tableView.tableFooterView = self.footer;
    
    //完成按钮
    UIButton *continueBtn = [UIButton buttonWithTitle:@"继续" taget:self action:@selector(continueButtonClick) font:kSystemFont15 titleColor:kWhiteTextColor];
    continueBtn.frame = CGRectMake(kRealValue(20), kScreenHeight-kNavBarHeight-kRealValue(55), kScreenWidth-kRealValue(40), kRealValue(45));
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

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return allInfoCellH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YTAllInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BaseConfigModel *model = self.dataArray[indexPath.row];
    [cell loadDataWithModel:model withIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {//职业
        
        NSArray *jobsArr = [NSArray array];
        if (self.gender == 1) {
            jobsArr = self.model.maleJobsArr;
        } else {
            jobsArr = self.model.famaleJobsArr;
        }
        @weakify(self)
        [YTAllInfoPicker allInfoPickerrViewWithArray:jobsArr AndBlock:^(NSInteger selectRow, NSString * _Nonnull text) {
            @strongify(self)
            self.model.job = text;
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
            YTAllInfoCell *cell = [self.tableView cellForRowAtIndexPath:index];
            cell.infoLab.text = text;
        }];
        
    } else if (indexPath.row == 1) { //城市
        
        @weakify(self)
        [YCAddressPickerView areaPickerViewWithAreaBlock:^(NSString *province, NSString *city) {
            @strongify(self)
            self.model.city = [NSString stringWithFormat:@"%@%@",province,city];
            NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:0];
            YTAllInfoCell *cell = [self.tableView cellForRowAtIndexPath:index];
            cell.infoLab.text = self.model.city;
            self.model.province = province;
            self.model.cith = city;
        }];

        
    } else if (indexPath.row == 2) { //学历
        
        @weakify(self)
        [YTAllInfoPicker allInfoPickerrViewWithArray:self.educationArr AndBlock:^(NSInteger selectRow, NSString * _Nonnull text) {
            @strongify(self)
            self.model.education = text;
            self.model.educationInt = selectRow;
            NSIndexPath *index = [NSIndexPath indexPathForRow:2 inSection:0];
            YTAllInfoCell *cell = [self.tableView cellForRowAtIndexPath:index];
            cell.infoLab.text = text;
        }];
        
    } else if (indexPath.row == 3) { //身高
        
        @weakify(self)
        [YTAllInfoPicker allInfoPickerrViewWithArray:self.heightArr AndBlock:^(NSInteger selectRow, NSString * _Nonnull text) {
            @strongify(self)
            self.model.height = text;
            NSIndexPath *index = [NSIndexPath indexPathForRow:3 inSection:0];
            YTAllInfoCell *cell = [self.tableView cellForRowAtIndexPath:index];
            cell.infoLab.text = text;
        }];
        
    } else if (indexPath.row == 4) { //体重
        
        @weakify(self)
        [YTAllInfoPicker allInfoPickerrViewWithArray:self.weightArr AndBlock:^(NSInteger selectRow, NSString * _Nonnull text) {
            @strongify(self)
            self.model.weight = text;
            NSIndexPath *index = [NSIndexPath indexPathForRow:4 inSection:0];
            YTAllInfoCell *cell = [self.tableView cellForRowAtIndexPath:index];
            cell.infoLab.text = text;
        }];
        
    }
}

#pragma mark - lazy init
- (NSArray *)educationArr {
    if (!_educationArr) {
        _educationArr = @[@"初中",@"高中",@"专科",@"本科",@"研究生",@"硕士",@"博士",@"博士后"];
    }
    return _educationArr;
}

- (NSArray *)heightArr { // 身高范围100-250cm
    if (!_heightArr) {
        NSMutableArray *temp = [NSMutableArray array];
        for (NSInteger i = 100; i < 251; i++) {
            [temp addObject:[NSString stringWithFormat:@"%ld",i]];
        }
        _heightArr = [temp copy];
    }
    return _heightArr;
}

- (NSArray *)weightArr { // 体重范围25-150kg
    if (!_weightArr) {
        NSMutableArray *temp = [NSMutableArray array];
        for (NSInteger i = 25; i < 151; i++) {
            [temp addObject:[NSString stringWithFormat:@"%ld",i]];
        }
        _weightArr = [temp copy];
    }
    return _weightArr;
}


@end
