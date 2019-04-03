//
//  YTMallViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/21.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTMallViewController.h"

#import "YTYueDouPackageView.h"
#import "YTVipPackageView.h"
#import "YTPayStyleCell.h"
#import "YTPayStyleModel.h"

@interface YTMallViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *segmentView;
@property (nonatomic, strong) UIButton *yueDouButton;
@property (nonatomic, strong) UIButton *vipButton;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *userBalanceView;
@property (nonatomic, strong) UIView *yueDouPackageView;
@property (nonatomic, strong) NSMutableArray *yueDouPackageViewList;
@property (nonatomic, strong) UIView *vipPackageView;
@property (nonatomic, strong) NSMutableArray *vipPackageViewList;
@property (nonatomic, strong) UILabel *payStyleLabel;
@property (nonatomic, strong) UIView *confirmView;

@property (nonatomic, assign) NSInteger selectedSegmentIndex;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

static NSString *YTPayStyleCellID = @"YTPayStyleCellID";

@implementation YTMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"设置"];
    self.navigationItem.titleView = self.segmentView;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"说明" titleColor:[UIColor whiteColor] target:self action:@selector(rightBarItemClicked)];

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    self.tableView.tableHeaderView = self.headerView;
    
    YTPayStyleModel *balance = [[YTPayStyleModel alloc] initWithLeftImageName:@"ic_balance" titleName:@"余额支付" isSelected:YES];
    
    YTPayStyleModel *aliPay = [[YTPayStyleModel alloc] initWithLeftImageName:@"ic_alipay" titleName:@"支付宝支付" isSelected:NO];

    YTPayStyleModel *wxPay = [[YTPayStyleModel alloc] initWithLeftImageName:@"ic_wechat_pay" titleName:@"微信支付" isSelected:NO];

    self.dataArray = [@[balance,aliPay,wxPay] mutableCopy];
    
    [self.tableView reloadData];
}

#pragma mark - **************** Event
- (void)segmentButtonClicked:(UIButton *)button {
    
    [self.headerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.selectedSegmentIndex = button.tag;
    
    if (button.tag == 0) {
        //约豆
        _yueDouButton.layer.borderWidth = 1;
        _vipButton.layer.borderWidth = 0;
        //用户余额
        [self.headerView addSubview:self.userBalanceView];
        //选择套餐
        self.yueDouPackageView.y = self.userBalanceView.maxY;
        [self.headerView addSubview:self.yueDouPackageView];
        //支付方式
        self.payStyleLabel.y = self.yueDouPackageView.maxY + kRealValue(8);
        [self.headerView addSubview:self.payStyleLabel];
        self.headerView.height = self.payStyleLabel.maxY;
    } else if (button.tag == 1) {
        //Vip
        _yueDouButton.layer.borderWidth = 0;
        _vipButton.layer.borderWidth = 1;
        //用户余额
        [self.headerView addSubview:self.userBalanceView];
        //选择套餐
        self.vipPackageView.y = self.userBalanceView.maxY;
        [self.headerView addSubview:self.vipPackageView];
        //支付方式
        self.payStyleLabel.y = self.vipPackageView.maxY + kRealValue(8);
        [self.headerView addSubview:self.payStyleLabel];
        self.headerView.height = self.payStyleLabel.maxY;
    }
    self.tableView.tableHeaderView = self.headerView;
}


- (void)yueDouPackageViewClick:(YTYueDouPackageView *)packageView {
    NSLog(@"约豆套餐");
    for (YTYueDouPackageView *view in self.yueDouPackageViewList) {
        if (view == packageView) {
            view.isSelected = YES;
        } else {
            view.isSelected = NO;
        }
    }
}

- (void)vipPackageViewClick:(YTVipPackageView *)packageView {
    NSLog(@"vip套餐");
    for (YTVipPackageView *view in self.vipPackageViewList) {
        if (view == packageView) {
            view.isSelected = YES;
        } else {
            view.isSelected = NO;
        }
    }
}

- (void)rightBarItemClicked {
    NSLog(@"说明");
}

- (void)comfirmButtonClicked {
    NSLog(@"确认提交");
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YTPayStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:YTPayStyleCellID forIndexPath:indexPath];
    
    cell.payStyleModel = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRealValue(45);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YTPayStyleModel *payStyleModel = self.dataArray[indexPath.row];
    for (YTPayStyleModel *payStyle in self.dataArray) {
        payStyle.isSelected = NO;
    }
    payStyleModel.isSelected = YES;
    [self.tableView reloadData];
}

#pragma mark - **************** Setter Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = kWhiteBackgroundColor;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[YTPayStyleCell class] forCellReuseIdentifier:YTPayStyleCellID];
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

- (UIView *)segmentView {
    if (!_segmentView) {
        UIView *segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRealValue(160), kRealValue(30))];
        _segmentView = segmentView;
        
        UIButton *yueDouButton = [UIButton buttonWithTitle:@"约豆" taget:self action:@selector(segmentButtonClicked:) font:kSystemFont16 titleColor:kBlackTextColor];
        yueDouButton.tag = 0;
        yueDouButton.layer.borderColor = kBlackTextColor.CGColor;
        yueDouButton.frame = CGRectMake(0, 0, kRealValue(70), kRealValue(30));
        [segmentView addSubview:yueDouButton];
        _yueDouButton = yueDouButton;
        
        UIButton *vipButton = [UIButton buttonWithTitle:@"VIP会员" taget:self action:@selector(segmentButtonClicked:) font:kSystemFont16 titleColor:kBlackTextColor];
        vipButton.frame = CGRectMake(yueDouButton.maxX + kRealValue(20), 0, kRealValue(70), kRealValue(30));
        vipButton.tag = 1;
        vipButton.layer.borderColor = kBlackTextColor.CGColor;
        [segmentView addSubview:vipButton];
        _vipButton = vipButton;
        
        [self segmentButtonClicked:yueDouButton];
    }
    return _segmentView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        _headerView.backgroundColor = kMineGrayBackgroundColor;
    }
    return _headerView;
}

- (UIView *)userBalanceView {
    if (!_userBalanceView) {
        _userBalanceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(180))];
        _userBalanceView.backgroundColor = kMineGrayBackgroundColor;
        
        UIView *whiteBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(25), kRealValue(25), _userBalanceView.width - kRealValue(50), _userBalanceView.height - kRealValue(50))];
        whiteBackgroundView.layer.cornerRadius = 8;
        whiteBackgroundView.backgroundColor = [UIColor whiteColor];
        [_userBalanceView addSubview:whiteBackgroundView];
        
        //头像
        UIImageView *avartarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(35), whiteBackgroundView.height/2 - kRealValue(30), kRealValue(60), kRealValue(60))];
        avartarImageView.image = [UIImage imageNamed:@"ic_head_pink"];
        [whiteBackgroundView addSubview:avartarImageView];
        
        //昵称
        UILabel *nameLabel = [UILabel labelWithName:@"张三（23123123）" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
        nameLabel.frame = CGRectMake(avartarImageView.maxX + kRealValue(20), avartarImageView.y, kRealValue(150), kRealValue(16));
        [whiteBackgroundView addSubview:nameLabel];

        //约豆数量
        UILabel *yueDouNumLabel = [UILabel labelWithName:@"约豆数量：1" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
        yueDouNumLabel.frame = CGRectMake(nameLabel.x, nameLabel.maxY + kRealValue(30), kRealValue(100), kRealValue(16));
        [whiteBackgroundView addSubview:yueDouNumLabel];
    }
    return _userBalanceView;
}

- (UIView *)yueDouPackageView {
    if (!_yueDouPackageView) {
        _yueDouPackageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(220))];
        _yueDouPackageView.backgroundColor = kWhiteBackgroundColor;
        
        //选择套餐
        UILabel *choosePackageLabel = [UILabel labelWithName:@"选择套餐" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
        choosePackageLabel.frame = CGRectMake(kRealValue(15), kRealValue(20), kScreenWidth, kRealValue(16));
        [_yueDouPackageView addSubview:choosePackageLabel];
        
        //套餐
        for (int i = 0; i < 6; i++) {
            YTYueDouPackageView *packageView = [[YTYueDouPackageView alloc] initWithFrame:CGRectMake(kRealValue(20) + (i%3)*(kRealValue(100) + kRealValue(15)), (i/3) * (kRealValue(65) + kRealValue(15)) + choosePackageLabel.maxY + kRealValue(20), kRealValue(100), kRealValue(65))];
            @weakify(self);
            packageView.yueDouPackageViewClickBlock = ^(YTYueDouPackageView * _Nonnull view) {
                @strongify(self);
                [self yueDouPackageViewClick:view];
            };
            [_yueDouPackageView addSubview:packageView];
            [self.yueDouPackageViewList addObject:packageView];
        }
    }
    return _yueDouPackageView;
}

- (NSMutableArray *)yueDouPackageViewList {
    if (!_yueDouPackageViewList) {
        _yueDouPackageViewList = [NSMutableArray array];
    }
    return _yueDouPackageViewList;
}

- (UIView *)vipPackageView {
    if (!_vipPackageView) {
        _vipPackageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(340))];
        _vipPackageView.backgroundColor = kWhiteBackgroundColor;
        
        //选择套餐
        UILabel *choosePackageLabel = [UILabel labelWithName:@"选择套餐" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
        choosePackageLabel.frame = CGRectMake(kRealValue(15), kRealValue(20), kScreenWidth, kRealValue(16));
        [_vipPackageView addSubview:choosePackageLabel];
        
        //套餐
        for (int i = 0; i < 6; i++) {
            YTVipPackageView *packageView = [[YTVipPackageView alloc] initWithFrame:CGRectMake(kRealValue(20) + (i%3)*(kRealValue(100) + kRealValue(15)), (i/3) * (kRealValue(125) + kRealValue(15)) + choosePackageLabel.maxY + kRealValue(20), kRealValue(100), kRealValue(125))];
            @weakify(self);
            packageView.vipPackageViewClickBlock = ^(YTVipPackageView * _Nonnull view) {
                @strongify(self);
                [self vipPackageViewClick:view];
            };
            [_vipPackageView addSubview:packageView];
            [self.vipPackageViewList addObject:packageView];
        }
    }
    return _vipPackageView;
}

- (NSMutableArray *)vipPackageViewList {
    if (!_vipPackageViewList) {
        _vipPackageViewList = [NSMutableArray array];
    }
    return _vipPackageViewList;
}

- (UILabel *)payStyleLabel {
    if (!_payStyleLabel) {
        UILabel *payStyleLabel = [UILabel labelWithName:@"     支付方式" Font:kSystemFont14 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
        payStyleLabel.frame = CGRectMake(0, 0, kScreenWidth, kRealValue(40));
        payStyleLabel.backgroundColor = kWhiteBackgroundColor;
        _payStyleLabel = payStyleLabel;
    }
    return _payStyleLabel;
}

- (UIView *)confirmView {
    if (!_confirmView) {
        _confirmView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(300))];
        
        //提交认证
        UIButton *comfirmButton = [UIButton buttonWithTitle:@"确认支付" taget:self action:@selector(comfirmButtonClicked) font:kSystemFont15 titleColor:kWhiteTextColor];
        comfirmButton.frame = CGRectMake(kRealValue(30), kRealValue(120), kScreenWidth - kRealValue(60), kRealValue(40));
        comfirmButton.layer.cornerRadius = comfirmButton.height/2;
        [_confirmView addSubview:comfirmButton];
        
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
    return _confirmView;
}

@end
