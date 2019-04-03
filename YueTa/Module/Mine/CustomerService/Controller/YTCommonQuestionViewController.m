//
//  YTCommonQuestionViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/21.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTCommonQuestionViewController.h"
#import "MineInterface.h"
#import "YTCustomerServiceDetailViewController.h"


@interface YTCommonQuestionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

static NSString *YTSystemCellID = @"YTSystemCellID";

@implementation YTCommonQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"常见问题"];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    

    [MineInterface getCommonProblemListAndBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage, NSArray<YTMyProblemModel *> * _Nonnull problemList) {
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            [self.dataArray addObjectsFromArray:problemList];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YTSystemCellID forIndexPath:indexPath];
    
    YTMyProblemModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.problem;
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
    YTMyProblemModel *model = self.dataArray[indexPath.row];
    YTCustomerServiceDetailViewController *detail = [[YTCustomerServiceDetailViewController alloc] init];
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - **************** Setter Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = kWhiteBackgroundColor;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:YTSystemCellID];
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
