//
//  YTNearController.m
//  YueTa
//
//  Created by 姚兜兜 on 2018/12/20.
//  Copyright © 2018 姚兜兜. All rights reserved.
//

#import "YTNearController.h"
#import "YTNearListCell.h"
#import "NearInterface.h"
#import "YTPostAppointmentViewController.h"
#import "YTUserInfoController.h"
#import "YTFiltrateController.h"

@interface YTNearController ()<UITableViewDelegate,UITableViewDataSource,YTFiltrateControllerDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger pageIndex;

@end

@implementation YTNearController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageIndex = 1;
    [self setNavigationBarTitle:@"附近"];
    
    [self createUI];
    
    [self requestData];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:@"near_filtrate" target:self action:@selector(rightBarButtonClick)];
}

- (void)requestData {
    [self.view showIndeterminateHudWithText:nil];
    [NearInterface getNearListWithPage:self.pageIndex andBlock:^(ResponseMessage *rspStatusAndMessage, NSArray *array) {
        [self.view hideHud];
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            if (self.pageIndex == 1) {
                [self.dataArray removeAllObjects];
            }
            
            [self.dataArray addObjectsFromArray:array];
            [self.tableView reloadData];
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - events
- (void)cellButtonClick:(NSInteger)row {
    NearListModel *model = self.dataArray[row];
    YTPostAppointmentViewController *vc = [[YTPostAppointmentViewController alloc] init];
    vc.dateUserId = model.ID;
    [vc setNavigationBarTitle:@"约Ta"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightBarButtonClick {
    YTFiltrateController *vc = [[YTFiltrateController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma makr - UI
- (void)createUI {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight - kTabBarHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kWhiteBackgroundColor;
    _tableView.rowHeight = kRealValue(130);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.separatorInset = UIEdgeInsetsMake(0, kRealValue(10), 0, 0);
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView registerClass:[YTNearListCell class] forCellReuseIdentifier:@"identifier"];
    [self.view addSubview:_tableView];
    
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
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YTNearListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    [cell loadDataWithModel:self.dataArray[indexPath.row] withIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    @weakify(self)
    cell.block = ^(NSInteger row) {
        @strongify(self)
        [self cellButtonClick:row];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YTUserInfoController *vc = [[YTUserInfoController alloc] init];
    NearListModel *model = self.dataArray[indexPath.row];
    vc.ID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - YTFiltrateControllerDelegate
- (void)YTFiltrateControllerCompleteWithMax_weight:(NSInteger)max_weight min_weight:(NSInteger)min_weight max_age:(NSInteger)max_age min_age:(NSInteger)min_age max_height:(NSInteger)max_height min_height:(NSInteger)min_height isVip:(BOOL)isVip auth_status:(BOOL)auth_status sort:(BOOL)sort work:(NSString *)work education:(NSInteger)education show:(NSString *)show {
    
    [self.view showIndeterminateHudWithText:nil];
    [NearInterface filtrateNearListWithMax_weight:max_weight min_weight:min_weight max_age:max_age min_age:min_age max_height:max_height min_height:min_height isVip:isVip auth_status:auth_status sort:sort work:work education:education show:show page:1 andBlock:^(ResponseMessage *rspStatusAndMessage, NSArray *array) {
        [self.view hideHud];
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:array];
            [self.tableView reloadData];
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}


#pragma mark - lazy init
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


@end
