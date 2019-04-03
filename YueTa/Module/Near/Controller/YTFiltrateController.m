//
//  YTFiltrateController.m
//  YueTa
//
//  Created by Awin on 2019/1/31.
//  Copyright © 2019年 姚兜兜. All rights reserved.
//

#import "YTFiltrateController.h"
#import "SDRangeSliderView.h"
#import "YTAllInfoCell.h"
#import "BaseConfigModel.h"
#import "YTAllInfoPicker.h"
#import "UserInterface.h"

static NSString *Identifier = @"Identifier";

@interface YTFiltrateController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *curVipBtn;
@property (nonatomic, strong) UIButton *curAuthBtn;
@property (nonatomic, strong) UIButton *curSortBtn;

@property (nonatomic, strong) AllInfoModel *model;

@property (nonatomic, strong) NSArray *educationArr;
@property (nonatomic, strong) NSArray *heightArr;
@property (nonatomic, strong) NSArray *weightArr;


@property (nonatomic, assign) NSInteger max_weight;
@property (nonatomic, assign) NSInteger min_weight;
@property (nonatomic, assign) NSInteger max_age;
@property (nonatomic, assign) NSInteger min_age;
@property (nonatomic, assign) NSInteger max_height;
@property (nonatomic, assign) NSInteger min_height;
@property (nonatomic, assign) BOOL isVip;//是否VIP
@property (nonatomic, assign) BOOL auth_status;//是否认证
@property (nonatomic, assign) BOOL sort;//排序
@property (nonatomic, strong) NSString *work;//职业
@property (nonatomic, assign) NSInteger education;//教育
@property (nonatomic, strong) NSString *show;//约会节目

@end

@implementation YTFiltrateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationBarTitle:@"筛选"];
    
    [self configData];
    
    [self requestData];
    
}

- (void)configData {
    self.max_age = 60;
    self.min_age = 18;
    self.max_height = 240;
    self.min_height = 150;
    self.max_weight = 120;
    self.min_weight = 30;
    self.work = @"1";
    self.education = 0;
    self.show = @"1";
    self.dataArray = @[[BaseConfigModel modelWithTitle:@"职业" subTitle:@"不限" icon:@""],
                       [BaseConfigModel modelWithTitle:@"城市" subTitle:@"不限" icon:@""],
                       [BaseConfigModel modelWithTitle:@"学历" subTitle:@"不限" icon:@""],
                       ];
}

- (void)requestData {
    [UserInterface getRegisterTagLabelAndBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage, AllInfoModel * _Nonnull model) {
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            self.model = model;
            [self setupSubViews];
            [self createUI];
        }
    }];
}

#pragma mark - events
- (void)vipButtonClick:(UIButton *)button {
    button.selected = YES;
    self.curVipBtn.selected = NO;
    self.curVipBtn = button;
    self.isVip = button.tag;
}

- (void)authButtonClick:(UIButton *)button {
    button.selected = YES;
    self.curAuthBtn.selected = NO;
    self.curAuthBtn = button;
    self.auth_status = button.tag;
}

- (void)sortButtonClick:(UIButton *)button {
    button.selected = YES;
    self.curSortBtn.selected = NO;
    self.curSortBtn = button;
    self.sort = button.tag;
}

- (void)continueButtonClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(YTFiltrateControllerCompleteWithMax_weight:min_weight:max_age:min_age:max_height:min_height:isVip:auth_status:sort:work:education:show:)]) {
        
        [self.delegate YTFiltrateControllerCompleteWithMax_weight:self.max_weight min_weight:self.min_weight max_age:self.max_age min_age:self.min_age max_height:self.max_height min_height:self.min_height isVip:self.isVip auth_status:self.auth_status sort:self.sort work:self.work education:self.education show:self.show];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UI
- (void)createUI {
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    
    // 身高
    UILabel *height = [UILabel labelWithName:@"身高" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    height.frame = CGRectMake(kRealValue(10), kRealValue(10), kRealValue(100), kRealValue(20));
    [self.headerView addSubview:height];
    
    UILabel *leftH = [UILabel labelWithName:@"150cm" Font:kSystemFont12 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    leftH.frame = CGRectMake(kRealValue(20), height.bottom, kRealValue(100), kRealValue(20));
    [self.headerView addSubview:leftH];
    
    UILabel *rightH = [UILabel labelWithName:@"240cm" Font:kSystemFont12 textColor:kBlackTextColor textAlignment:NSTextAlignmentRight];
    rightH.frame = CGRectMake(kScreenWidth-kRealValue(110), height.bottom, kRealValue(100), kRealValue(20));
    [self.headerView addSubview:rightH];
    
    SDRangeSliderView *sliderH = [[SDRangeSliderView alloc] initWithFrame:CGRectMake(kRealValue(10), leftH.bottom+kRealValue(10), kScreenWidth-kRealValue(20), 50)];
    sliderH.lineColor = kGrayBorderColor;
    sliderH.highlightLineColor = RGB(192, 164, 234);
    sliderH.lineHeight = 30;
    [self.headerView addSubview:sliderH];
    sliderH.minValue = 150;
    sliderH.maxValue = 240;
    sliderH.leftValue = 150;
    sliderH.rightValue = 240;
    [sliderH eventValueDidChanged:^(double left, double right) {
        leftH.text = [NSString stringWithFormat:@"%@cm",@(left)];
        rightH.text = [NSString stringWithFormat:@"%@cm",@(right)];
        self.max_height = (NSInteger)right;
        self.min_height = (NSInteger)left;
    }];
    
    // 年龄
    UILabel *age = [UILabel labelWithName:@"年龄" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    age.frame = CGRectMake(kRealValue(10), sliderH.bottom+kRealValue(10), kRealValue(100), kRealValue(20));
    [self.headerView addSubview:age];
    
    UILabel *leftAge = [UILabel labelWithName:@"18岁" Font:kSystemFont12 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    leftAge.frame = CGRectMake(kRealValue(20), age.bottom, kRealValue(100), kRealValue(20));
    [self.headerView addSubview:leftAge];
    
    UILabel *rightAge = [UILabel labelWithName:@"60岁" Font:kSystemFont12 textColor:kBlackTextColor textAlignment:NSTextAlignmentRight];
    rightAge.frame = CGRectMake(kScreenWidth-kRealValue(110), age.bottom, kRealValue(100), kRealValue(20));
    [self.headerView addSubview:rightAge];
    
    SDRangeSliderView *sliderAge = [[SDRangeSliderView alloc] initWithFrame:CGRectMake(kRealValue(10), leftAge.bottom+kRealValue(10), kScreenWidth-kRealValue(20), 50)];
    sliderAge.lineColor = kGrayBorderColor;
    sliderAge.highlightLineColor = RGB(192, 164, 234);
    [self.headerView addSubview:sliderAge];
    sliderAge.minValue = 18;
    sliderAge.maxValue = 60;
    sliderAge.leftValue = 18;
    sliderAge.rightValue = 60;
    [sliderAge eventValueDidChanged:^(double left, double right) {
        leftAge.text = [NSString stringWithFormat:@"%@岁",@(left)];
        rightAge.text = [NSString stringWithFormat:@"%@岁",@(right)];
        self.max_age = (NSInteger)right;
        self.min_age = (NSInteger)left;
    }];
    
    // 体重
    UILabel *weight = [UILabel labelWithName:@"体重" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    weight.frame = CGRectMake(kRealValue(10), sliderAge.bottom+kRealValue(10), kRealValue(100), kRealValue(20));
    [self.headerView addSubview:weight];
    
    UILabel *leftW = [UILabel labelWithName:@"30kg" Font:kSystemFont12 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    leftW.frame = CGRectMake(kRealValue(20), weight.bottom, kRealValue(100), kRealValue(20));
    [self.headerView addSubview:leftW];
    
    UILabel *rightW = [UILabel labelWithName:@"120kg" Font:kSystemFont12 textColor:kBlackTextColor textAlignment:NSTextAlignmentRight];
    rightW.frame = CGRectMake(kScreenWidth-kRealValue(110), weight.bottom, kRealValue(100), kRealValue(20));
    [self.headerView addSubview:rightW];
    
    SDRangeSliderView *sliderW = [[SDRangeSliderView alloc] initWithFrame:CGRectMake(kRealValue(10), leftW.bottom+kRealValue(10), kScreenWidth-kRealValue(20), 50)];
    sliderW.lineColor = kGrayBorderColor;
    sliderW.highlightLineColor = RGB(192, 164, 234);
    [self.headerView addSubview:sliderW];
    sliderW.minValue = 30;
    sliderW.maxValue = 120;
    sliderW.leftValue = 30;
    sliderW.rightValue = 120;
    [sliderW eventValueDidChanged:^(double left, double right) {
        leftW.text = [NSString stringWithFormat:@"%@kg",@(left)];
        rightW.text = [NSString stringWithFormat:@"%@kg",@(right)];
        self.max_height = (NSInteger)right;
        self.min_height = (NSInteger)left;
    }];
    

    // VIP
    UILabel *VIPLab = [UILabel labelWithName:@"VIP" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    VIPLab.frame = CGRectMake(kRealValue(10), sliderW.bottom+kRealValue(10), kRealValue(100), kRealValue(20));
    [self.headerView addSubview:VIPLab];
    
    UIButton *vipLeft = [UIButton buttonWithTitle:@"不限" taget:self action:@selector(vipButtonClick:) font:kSystemFont14 titleColor:kBlackTextColor];
    vipLeft.frame = CGRectMake(kRealValue(20), VIPLab.bottom+kRealValue(10), kRealValue(60), kRealValue(30));
    [vipLeft setTitleColor:kWhiteTextColor forState:UIControlStateSelected];
    vipLeft.layer.cornerRadius = vipLeft.height/2;
    vipLeft.layer.masksToBounds = YES;
    vipLeft.layer.borderColor = kGrayBorderColor.CGColor;
    vipLeft.layer.borderWidth = 1.f;
    vipLeft.tag = 0;
    [vipLeft setBackgroundImage:[self createImageWithColor:RGB(255, 255, 255)] forState:UIControlStateNormal];
    [vipLeft setBackgroundImage:[self createImageWithColor:RGB(192, 164, 234)] forState:UIControlStateSelected];
    vipLeft.selected = YES;
    [self.headerView addSubview:vipLeft];
    self.curVipBtn = vipLeft;
    
    UIButton *vipRight = [UIButton buttonWithTitle:@"仅VIP" taget:self action:@selector(vipButtonClick:) font:kSystemFont14 titleColor:kBlackTextColor];
    vipRight.frame = CGRectMake(vipLeft.right + kRealValue(100), VIPLab.bottom+kRealValue(10), kRealValue(60), kRealValue(30));
    [vipRight setTitleColor:kWhiteTextColor forState:UIControlStateSelected];
    vipRight.layer.cornerRadius = vipRight.height/2;
    vipRight.layer.masksToBounds = YES;
    vipRight.layer.borderColor = kGrayBorderColor.CGColor;
    vipRight.layer.borderWidth = 1.f;
    vipRight.tag = 1;
    [vipRight setBackgroundImage:[self createImageWithColor:RGB(255, 255, 255)] forState:UIControlStateNormal];
    [vipRight setBackgroundImage:[self createImageWithColor:RGB(192, 164, 234)] forState:UIControlStateSelected];
    [self.headerView addSubview:vipRight];
    
    // 是否认证
    UILabel *authLab = [UILabel labelWithName:@"是否认证" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    authLab.frame = CGRectMake(kRealValue(10), vipLeft.bottom+kRealValue(10), kRealValue(100), kRealValue(20));
    [self.headerView addSubview:authLab];
    
    UIButton *authLeft = [UIButton buttonWithTitle:@"不限" taget:self action:@selector(authButtonClick:) font:kSystemFont14 titleColor:kBlackTextColor];
    authLeft.frame = CGRectMake(kRealValue(20), authLab.bottom+kRealValue(10), kRealValue(60), kRealValue(30));
    [authLeft setTitleColor:kWhiteTextColor forState:UIControlStateSelected];
    authLeft.layer.cornerRadius = vipLeft.height/2;
    authLeft.layer.masksToBounds = YES;
    authLeft.layer.borderColor = kGrayBorderColor.CGColor;
    authLeft.layer.borderWidth = 1.f;
    authLeft.tag = 0;
    [authLeft setBackgroundImage:[self createImageWithColor:RGB(255, 255, 255)] forState:UIControlStateNormal];
    [authLeft setBackgroundImage:[self createImageWithColor:RGB(192, 164, 234)] forState:UIControlStateSelected];
    authLeft.selected = YES;
    [self.headerView addSubview:authLeft];
    self.curAuthBtn = authLeft;
    
    UIButton *authRight = [UIButton buttonWithTitle:@"已认证" taget:self action:@selector(authButtonClick:) font:kSystemFont14 titleColor:kBlackTextColor];
    authRight.frame = CGRectMake(authLeft.right + kRealValue(100), authLab.bottom+kRealValue(10), kRealValue(60), kRealValue(30));
    [authRight setTitleColor:kWhiteTextColor forState:UIControlStateSelected];
    authRight.layer.cornerRadius = authRight.height/2;
    authRight.layer.masksToBounds = YES;
    authRight.layer.borderColor = kGrayBorderColor.CGColor;
    authRight.layer.borderWidth = 1.f;
    authRight.tag = 1;
    [authRight setBackgroundImage:[self createImageWithColor:RGB(255, 255, 255)] forState:UIControlStateNormal];
    [authRight setBackgroundImage:[self createImageWithColor:RGB(192, 164, 234)] forState:UIControlStateSelected];
    authRight.backgroundColor = RGB(192, 164, 234);
    [self.headerView addSubview:authRight];
    
    // 排序
    UILabel *sortLab = [UILabel labelWithName:@"排序" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    sortLab.frame = CGRectMake(kRealValue(10), authLeft.bottom+kRealValue(10), kRealValue(100), kRealValue(20));
    [self.headerView addSubview:sortLab];
    
    UIButton *sortLeft = [UIButton buttonWithTitle:@"不限" taget:self action:@selector(sortButtonClick:) font:kSystemFont14 titleColor:kBlackTextColor];
    sortLeft.frame = CGRectMake(kRealValue(20), sortLab.bottom+kRealValue(10), kRealValue(60), kRealValue(30));
    [sortLeft setTitleColor:kWhiteTextColor forState:UIControlStateSelected];
    sortLeft.layer.cornerRadius = sortLeft.height/2;
    sortLeft.layer.masksToBounds = YES;
    sortLeft.layer.borderColor = kGrayBorderColor.CGColor;
    sortLeft.layer.borderWidth = 1.f;
    sortLeft.tag = 0;
    [sortLeft setBackgroundImage:[self createImageWithColor:RGB(255, 255, 255)] forState:UIControlStateNormal];
    [sortLeft setBackgroundImage:[self createImageWithColor:RGB(192, 164, 234)] forState:UIControlStateSelected];
    sortLeft.selected = YES;
    [self.headerView addSubview:sortLeft];
    self.curSortBtn = sortLeft;
    
    UIButton *sortRight = [UIButton buttonWithTitle:@"已认证" taget:self action:@selector(sortButtonClick:) font:kSystemFont14 titleColor:kBlackTextColor];
    sortRight.frame = CGRectMake(sortLeft.right + kRealValue(100), sortLab.bottom+kRealValue(10), kRealValue(60), kRealValue(30));
    [sortRight setTitleColor:kWhiteTextColor forState:UIControlStateSelected];
    sortRight.layer.cornerRadius = sortRight.height/2;
    sortRight.layer.masksToBounds = YES;
    sortRight.layer.borderColor = kGrayBorderColor.CGColor;
    sortRight.layer.borderWidth = 1.f;
    sortRight.tag = 1;
    [sortRight setBackgroundImage:[self createImageWithColor:RGB(255, 255, 255)] forState:UIControlStateNormal];
    [sortRight setBackgroundImage:[self createImageWithColor:RGB(192, 164, 234)] forState:UIControlStateSelected];
    [self.headerView addSubview:sortRight];
    
    self.headerView.height = sortRight.bottom+kRealValue(10);
    [self.tableView setTableHeaderView:self.headerView];
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
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //完成按钮
    UIButton *continueBtn = [UIButton buttonWithTitle:@"确定" taget:self action:@selector(continueButtonClick) font:kSystemFont15 titleColor:kWhiteTextColor];
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
        if ([UserInfoManager sharedInstance].gender == 1) {
            jobsArr = self.model.maleJobsArr;
        } else {
            jobsArr = self.model.famaleJobsArr;
        }
        @weakify(self)
        [YTAllInfoPicker allInfoPickerrViewWithArray:jobsArr AndBlock:^(NSInteger selectRow, NSString * _Nonnull text) {
            @strongify(self)
            self.work = text;
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
            YTAllInfoCell *cell = [self.tableView cellForRowAtIndexPath:index];
            cell.infoLab.text = text;
        }];
        
    } else if (indexPath.row == 1) { //学历
        @weakify(self)
        [YTAllInfoPicker allInfoPickerrViewWithArray:self.educationArr AndBlock:^(NSInteger selectRow, NSString * _Nonnull text) {
            @strongify(self)
            self.education = selectRow;
            NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:0];
            YTAllInfoCell *cell = [self.tableView cellForRowAtIndexPath:index];
            cell.infoLab.text = text;
        }];
        
    } else if (indexPath.row == 2) {// 约会节目
        @weakify(self)
        [YTAllInfoPicker allInfoPickerrViewWithArray:self.model.engagementArr AndBlock:^(NSInteger selectRow, NSString * _Nonnull text) {
            @strongify(self)
            self.show = text;
            NSIndexPath *index = [NSIndexPath indexPathForRow:2 inSection:0];
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

- (UIImage*)createImageWithColor:(UIColor*)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}




@end
