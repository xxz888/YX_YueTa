//
//  YTSquareChildController.m
//  YueTa
//
//  Created by Awin on 2019/1/28.
//  Copyright © 2019年 姚兜兜. All rights reserved.
//

#import "YTSquareChildController.h"
#import "YTSquareListCell.h"
#import "SquareInterface.h"

#import "YTMyAppointmentDetailViewController.h"

@interface YTSquareChildController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger pageIndex;

@end

@implementation YTSquareChildController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pageIndex = 1;
    
    [self createUI];
    
    [self requestData];
}


- (void)requestData {
    [SquareInterface getSquareListWithPage:self.pageIndex andBlock:^(ResponseMessage *rspStatusAndMessage, NSArray *array) {
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


- (void)reloadFiltrateData:(NSArray *)array {
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:array];
    [self.tableView reloadData];
}

#pragma mark - events
- (void)cellButtonClick:(NSInteger)row {
    YTMyDateModel *model = self.dataArray[row];
    YTMyAppointmentDetailViewController *vc = [[YTMyAppointmentDetailViewController alloc] init];
    vc.myDateModel = (YTMyDateModel *)model;
    if (model.reward_type == 1) {//求打赏  约Ta
        vc.type = 3;
    } else {// 打赏   报名
        vc.type = 2;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma makr - UI
- (void)createUI {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight - kTabBarHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kWhiteBackgroundColor;
    _tableView.rowHeight = squareListCellH;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.separatorInset = UIEdgeInsetsMake(0, kRealValue(10), 0, 0);
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView registerClass:[YTSquareListCell class] forCellReuseIdentifier:@"identifier"];
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
    YTSquareListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
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
    YTMyDateModel *model = self.dataArray[indexPath.row];
    YTMyAppointmentDetailViewController *vc = [[YTMyAppointmentDetailViewController alloc] init];
    vc.myDateModel = (YTMyDateModel *)model;
    if (model.reward_type == 1) {//求打赏  约Ta
        vc.type = 3;
    } else {// 打赏   报名
        vc.type = 2;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - lazy init
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



@end
