//
//  YTMyWalletViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/14.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTMyWalletViewController.h"

@interface YTMyWalletViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *balanceLabel;
@property (nonatomic, strong) UILabel *yueDouLabel;

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *YTSystemCellID = @"YTSystemCellID";

@implementation YTMyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupTableView];
    [self setupHeaderView];
}

- (void)setupNavigationBar {
    [self setNavigationBarTitle:@"我的钱包"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提现" titleColor:[UIColor whiteColor] target:self action:@selector(withdrawItemClicked)];
}

- (void)setupTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight)];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:YTSystemCellID];
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

- (void)setupHeaderView {
    //头视图
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(238))];
    _headerView = headerView;
    
    //钱包
    UIView *walletView = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(15), kScreenWidth - kRealValue(30), kRealValue(180))];
    walletView.layer.cornerRadius = 8;
    [headerView addSubview:walletView];
    
    CAGradientLayer *btnLayer = [CAGradientLayer layer];
    btnLayer.locations = @[@0.5];
    btnLayer.startPoint = CGPointMake(0, 0);
    btnLayer.endPoint = CGPointMake(1.0, 0.0);
    btnLayer.frame = walletView.bounds;
    btnLayer.cornerRadius = 8;
    btnLayer.masksToBounds = YES;
    btnLayer.colors = @[(__bridge id)RGB(134, 172, 231).CGColor, (__bridge id)RGB(183, 163, 237).CGColor];
    [walletView.layer addSublayer:btnLayer];
    
    //账户余额title
    UILabel *balanceTitleLabel = [UILabel labelWithName:@"账户余额" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentCenter];
    balanceTitleLabel.frame = CGRectMake(0, kRealValue(30), walletView.width/2, kRealValue(16));
    [walletView addSubview:balanceTitleLabel];
    
    //账户余额
    UILabel *balanceLabel = [UILabel labelWithName:@"¥888" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentCenter];
    balanceLabel.frame = CGRectMake(0, balanceTitleLabel.maxY + kRealValue(15), walletView.width/2, kRealValue(16));
    [walletView addSubview:balanceLabel];
    _balanceLabel = balanceLabel;
    
    CGFloat buttonWidth = kRealValue(100);
    CGFloat buttonHeight = kRealValue(30);
    
    //充值
    UIButton *rechargeButton = [UIButton buttonWithTitle:@"充值" taget:self action:@selector(rechargeBalanceButtonClicked) font:kSystemFont15 titleColor:kBlackTextColor];
    rechargeButton.layer.cornerRadius = 15;
    rechargeButton.layer.borderWidth = 1;
    rechargeButton.layer.borderColor = kBlackTextColor.CGColor;
    rechargeButton.frame = CGRectMake(walletView.width/4 - buttonWidth/2, balanceLabel.maxY + kRealValue(30), buttonWidth, buttonHeight);
    [walletView addSubview:rechargeButton];
    
    //分割线
    UIView *centerSepLine = [[UIView alloc] initWithFrame:CGRectMake(walletView.width/2 - 1, kRealValue(20), 1, walletView.height - kRealValue(40))];
    centerSepLine.backgroundColor = kBlackTextColor;
    [walletView addSubview:centerSepLine];
    
    //约豆title
    UILabel *yueDouTitleLabel = [UILabel labelWithName:@"约豆" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentCenter];
    yueDouTitleLabel.frame = CGRectMake(walletView.width/2, balanceTitleLabel.y, walletView.width/2, kRealValue(16));
    [walletView addSubview:yueDouTitleLabel];
    
    //账户余额
    UILabel *yueDouLabel = [UILabel labelWithName:@"888" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentCenter];
    yueDouLabel.frame = CGRectMake(walletView.width/2, yueDouTitleLabel.maxY + kRealValue(15), walletView.width/2, kRealValue(16));
    [walletView addSubview:yueDouLabel];
    _yueDouLabel = yueDouLabel;
    
    //充值
    UIButton *yueDouRechargeButton = [UIButton buttonWithTitle:@"充值" taget:self action:@selector(rechargeYueDouButtonClicked) font:kSystemFont15 titleColor:kBlackTextColor];
    yueDouRechargeButton.layer.cornerRadius = 15;
    yueDouRechargeButton.layer.borderWidth = 1;
    yueDouRechargeButton.layer.borderColor = kBlackTextColor.CGColor;
    yueDouRechargeButton.frame = CGRectMake(walletView.width/2 + walletView.width/4 - buttonWidth/2, balanceLabel.maxY + kRealValue(30), buttonWidth, buttonHeight);
    [walletView addSubview:yueDouRechargeButton];
    
    //提示
    UILabel *tipsLabel = [UILabel labelWithName:@"每当有人付费查看你的相册时，所得收益直接进入账户余额" Font:kSystemFont13 textColor:kGrayTextColor textAlignment:NSTextAlignmentCenter];
    tipsLabel.frame = CGRectMake(0, walletView.maxY + kRealValue(15), kScreenWidth, kRealValue(15));
    [headerView addSubview:tipsLabel];
    
    //分割线
    UIView *bottmSepLine = [[UIView alloc] initWithFrame:CGRectMake(0, tipsLabel.maxY + kRealValue(15), kScreenWidth, 0.5)];
    bottmSepLine.backgroundColor = kSepLineGrayBackgroundColor;
    [headerView addSubview:bottmSepLine];
    
    self.tableView.tableHeaderView = headerView;
}

- (void)withdrawItemClicked {
    NSLog(@"提现");
}

- (void)rechargeBalanceButtonClicked {
    NSLog(@"充值");
}

- (void)rechargeYueDouButtonClicked {
    NSLog(@"约豆充值");
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YTSystemCellID forIndexPath:indexPath];
    
    cell.textLabel.font = kSystemFont16;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"余额记录";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"约豆记录";
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_arrow_right"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRealValue(50);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSLog(@"余额");
    } else if (indexPath.row == 1) {
        NSLog(@"约豆");
    }
}

@end
