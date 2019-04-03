//
//  YTMyFansViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/14.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTMyRelationViewController.h"
#import "YTMyFansCell.h"
#import "MineInterface.h"

@interface YTMyRelationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

static NSString *YTMyFansCellID = @"YTMyFansCellID";

@implementation YTMyRelationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self requestData];
}

- (void)requestData {
    NSString *type;
    //fans/like/black
    if (self.type == 0) {
        type = @"fans";
    } else if (self.type == 1) {
        type = @"like";
    } else if (self.type == 2) {
        type = @"black";
    }
    
    [MineInterface getRelationListByType:type andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage, NSArray<YTRelationUserModel *> * _Nonnull userList) {
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:userList];
            [self.tableView reloadData];
        }
    }];
}

- (void)relationRightButtonClick:(YTRelationUserModel *)model {
    if (self.type == 0) {
        //粉丝
        if (model.mutual_fans) {

            [MineInterface disLikeUser:model.userId andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage) {
                if ([rspStatusAndMessage.message isEqualToString:@"操作成功"]) {
                    [self requestData];
                }
            }];
        } else {
            //关注
            [MineInterface likeUser:model.userId andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage) {
                if ([rspStatusAndMessage.message isEqualToString:@"操作成功"]) {
                    [self requestData];
                }
            }];
        }
    } else if (self.type == 1) {
        //取消关注
        [MineInterface disLikeUser:model.userId andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage) {
            if ([rspStatusAndMessage.message isEqualToString:@"操作成功"]) {
                [self requestData];
            }
        }];
    } else {
        //黑名单
        [MineInterface disBlackUser:model.userId andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage) {
            if ([rspStatusAndMessage.message isEqualToString:@"操作成功"]) {
                [self requestData];
            }
        }];
    }
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YTMyFansCell *cell = [tableView dequeueReusableCellWithIdentifier:YTMyFansCellID forIndexPath:indexPath];
    
    YTRelationUserModel *model = self.dataArray[indexPath.row];
    [cell configureCellByModel:model
                          type:self.type];
    cell.relationRightButtonClickBlock = ^(YTRelationUserModel * _Nonnull model) {
        [self relationRightButtonClick:model];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRealValue(100);
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
        [_tableView registerClass:[YTMyFansCell class] forCellReuseIdentifier:YTMyFansCellID];
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
