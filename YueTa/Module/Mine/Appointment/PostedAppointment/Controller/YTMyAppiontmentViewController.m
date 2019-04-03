//
//  YTPostedAppointmentViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/14.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTMyAppiontmentViewController.h"
#import "YTMyAppointmentDetailViewController.h"

#import "YTMyAppointmentCell.h"
#import "MineInterface.h"
#import "NearInterface.h"

@interface YTMyAppiontmentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger pageIndex;

@end

static NSString *YTPostedAppointmentCellID = @"YTPostedAppointmentCellID";

@implementation YTMyAppiontmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageIndex = 1;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.pageIndex = 1;
        [self requestData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self.pageIndex++;
        [self requestData];
    }];
    
    [self requestData];
}

- (void)requestData {
    
    if ([self.type isEqualToString:@"other"]) {
        
        [NearInterface getOneUserdateByPage:_pageIndex latitude:0 longtitude:0 ID:self.ID andBlock:^(ResponseMessage *rspStatusAndMessage, NSArray<YTMyDateModel *> *dateList) {
            if (rspStatusAndMessage.code == kResponseSuccessCode) {
                if (self.pageIndex == 1) {
                    [self.dataArray removeAllObjects];
                }
                [self.dataArray addObjectsFromArray:dateList];
                [self.tableView reloadData];
            }
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }];
    } else {
        [MineInterface getMydateByPage:_pageIndex latitude:0 longtitude:0 date_type:self.type andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage, NSArray<YTMyDateModel *> * _Nonnull dateList) {
            if (rspStatusAndMessage.code == kResponseSuccessCode) {
                if (self.pageIndex == 1) {
                    [self.dataArray removeAllObjects];
                }
                [self.dataArray addObjectsFromArray:dateList];
                [self.tableView reloadData];
            }
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }];
    }
    
}

- (void)ignoreButtonClick:(YTMyDateModel *)model {
    [MineInterface ignoreDate:model.dateId andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage) {
        if ([rspStatusAndMessage.message isEqualToString:@"操作成功"]) {
            [self requestData];
        }
    }];
}

- (void)agreeButtonClick:(YTMyDateModel *)model {
    [MineInterface agreeDate:model.dateId apply_id:model.userId andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage) {
        if ([rspStatusAndMessage.message isEqualToString:@"您已接受该用户邀约！"]) {
            [self requestData];
        }
    }];
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YTMyAppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:YTPostedAppointmentCellID forIndexPath:indexPath];
     YTMyDateModel *model = self.dataArray[indexPath.row];
    [cell configureCellByModel:model type:self.type];
    @weakify(self);
    cell.ignoreButtonClickBlock = ^(YTMyDateModel * _Nonnull model) {
        @strongify(self);
        [self ignoreButtonClick:model];
    };
    cell.agreeButtonClickBlock = ^(YTMyDateModel * _Nonnull model) {
        @strongify(self);
        [self agreeButtonClick:model];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRealValue(270);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YTMyAppointmentDetailViewController *detail = [[YTMyAppointmentDetailViewController alloc] init];
    detail.myDateModel = self.dataArray[indexPath.row];
    detail.type = 1;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - **************** Setter Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[YTMyAppointmentCell class] forCellReuseIdentifier:YTPostedAppointmentCellID];
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
