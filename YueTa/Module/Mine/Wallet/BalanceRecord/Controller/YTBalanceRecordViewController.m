//
//  YTBalanceRecordViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/14.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTBalanceRecordViewController.h"
#import "YTBalanceRecordCell.h"

@interface YTBalanceRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

static NSString *YTBalanceRecordCellID = @"YTBalanceRecordCellID";

@implementation YTBalanceRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSegmentView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kRealValue(50), kScreenWidth, kScreenHeight - kNavBarHeight - kRealValue(50))];
    [self.view addSubview:self.tableView];
}

- (void)setupSegmentView {
    UIView *segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(50))];
    
    CGFloat buttonWidth = kRealValue(100);
    CGFloat buttonHeight = kRealValue(30);
    
    UIButton *allButton = [UIButton buttonWithTitle:@"收入" taget:self action:@selector(segmentButtonClicked:) font:kSystemFont16 titleColor:kPurpleTextColor];
    allButton.layer.borderColor = kPurpleTextColor.CGColor;
    allButton.layer.borderWidth = 1;
    allButton.frame = CGRectMake(kRealValue(30), kRealValue(10), buttonWidth, buttonHeight);
    [segmentView addSubview:allButton];
    
}

- (void)segmentButtonClicked:(UIButton *)button {
    
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YTBalanceRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:YTBalanceRecordCellID forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRealValue(60);
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
        [_tableView registerClass:[YTBalanceRecordCell class] forCellReuseIdentifier:YTBalanceRecordCellID];
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
