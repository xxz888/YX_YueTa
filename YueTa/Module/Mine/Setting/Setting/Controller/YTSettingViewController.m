//
//  YTSettingViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/17.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTSettingViewController.h"
#import "YTTradingPwdViewController.h"
#import "YTLoginPwdViewController.h"
#import "YTSetPasswordController.h"

#import "YTSettingItem.h"
#import "YTSettingCell.h"

@interface YTSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *logoutButton;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

static NSString *YTSettingCellID = @"YTSettingCellID";

@implementation YTSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"设置"];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.logoutButton];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.logoutButton.mas_top);
    }];
    
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-kRealValue(30));
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.right.equalTo(self.view).offset(-kRealValue(15));
        make.height.equalTo(@kRealValue(45));
    }];
    
    YTSettingItem *loginPwdItem = [[YTSettingItem alloc] init];
    loginPwdItem.leftTitle = @"登录密码";
    
    YTSettingItem *transactionPwdItem = [[YTSettingItem alloc] init];
    transactionPwdItem.leftTitle = @"交易密码";
    
    YTSettingItem *clearCacheItem = [[YTSettingItem alloc] init];
    clearCacheItem.leftTitle = @"清除缓存";
    clearCacheItem.rightTitle = [NSString stringWithFormat:@"%ldM",[self getCacheSize]];
    clearCacheItem.cellType = YTSettingItemTypeAccessnoryTitle;
    
    YTSettingItem *versionItem = [[YTSettingItem alloc] init];
    versionItem.leftTitle = @"版本号";
    versionItem.rightTitle = kCurrentVersion;
    versionItem.cellType = YTSettingItemTypeLeftRightTitle;
    
    self.dataArray = [@[loginPwdItem,
                        transactionPwdItem,
                        clearCacheItem,
                        versionItem] mutableCopy];
    [self.tableView reloadData];
}

- (NSInteger)getCacheSize {
    //计算结果
    NSInteger totalSize = 0;
    
    // 构建需要计算大小的文件或文件夹的路径，这里以Caches为例
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];

    // 1.获得文件夹管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 2.检测路径的合理性
    BOOL dir = NO;
    BOOL exits = [mgr fileExistsAtPath:path isDirectory:&dir];
    if (!exits) return 0;
    
    // 3.判断是否为文件夹
    if (dir)//文件夹, 遍历文件夹里面的所有文件
    {
        //这个方法能获得这个文件夹下面的所有子路径(直接\间接子路径),包括子文件夹下面的所有文件及文件夹
        NSArray *subPaths = [mgr subpathsAtPath:path];
        
        //遍历所有子路径
        for (NSString *subPath in subPaths)
        {
            //拼成全路径
            NSString *fullSubPath = [path stringByAppendingPathComponent:subPath];
            
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubPath isDirectory:&dir];
            if (!dir)//子路径是个文件
            {
                NSDictionary *attrs = [mgr attributesOfItemAtPath:fullSubPath error:nil];
                totalSize += [attrs[NSFileSize] intValue];
            }
        }
        totalSize = totalSize / (1024 * 1024.0);//单位M
    }
    else//文件
    {
        NSDictionary *attrs = [mgr attributesOfItemAtPath:path error:nil];
        totalSize = [attrs[NSFileSize] intValue] / (1024 * 1024.0);//单位M
    }
    
    return totalSize;
}

- (void)clearCache {
    //构建需要删除的文件或文件夹的路径，这里以Caches为例
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];

    //拿到path路径的下一级目录的子文件夹
    NSArray *subPathArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString *subPath in subPathArray)
    {
        NSString *filePath = [path stringByAppendingPathComponent:subPath];
        //删除子文件夹
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    }
}

#pragma mark - **************** Event
- (void)logoutButtonClicked {
    [UIViewController showAlertViewWithTitle:@"提示" message:@"您确定要退出登录吗？" confirmTitle:@"确定" cancelTitle:@"取消" confirmAction:^{
        [[UserInfoManager sharedInstance] removeUserInfo];
        [self turnToLoginViewController];
    } cancelAction:nil];
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YTSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:YTSettingCellID forIndexPath:indexPath];
    YTSettingItem *item = self.dataArray[indexPath.row];
    [cell configureCellBySettingItem:item];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YTSettingItem *item = self.dataArray[indexPath.row];
    return item.cellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YTSettingItem *item = self.dataArray[indexPath.row];
    
    if ([item.leftTitle isEqualToString:@"登录密码"]) {
        YTSetPasswordController *pwd = [[YTSetPasswordController alloc] init];
        pwd.phoneStr = [UserInfoManager sharedInstance].mobile;
        [self.navigationController pushViewController:pwd animated:YES];
    } else if ([item.leftTitle isEqualToString:@"交易密码"]) {

    } else if ([item.leftTitle isEqualToString:@"清除缓存"]) {
        [self clearCache];
        [kAppWindow showAutoHideHudWithText:@"清除成功"];
        item.rightTitle = @"0M";
        [self.tableView reloadData];
    }
}

#pragma mark - **************** Setter Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = kWhiteBackgroundColor;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[YTSettingCell class] forCellReuseIdentifier:YTSettingCellID];
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

- (UIButton *)logoutButton {
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithTitle:@"退出登录" taget:self action:@selector(logoutButtonClicked) font:kSystemFont15 titleColor:kBlackTextColor];
        _logoutButton.backgroundColor = kSepLineGrayBackgroundColor;
    }
    return _logoutButton;
}

@end
