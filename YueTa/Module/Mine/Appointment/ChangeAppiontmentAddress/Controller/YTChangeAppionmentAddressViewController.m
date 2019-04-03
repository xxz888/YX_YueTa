//
//  YTChangeAppionmentAddressViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/4.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTChangeAppionmentAddressViewController.h"
#import "YCProvince.h"
#import "YCCity.h"
#import "YCAreaDataHelper.h"
#import "YCLocationManager.h"
#import "SCIndexView.h"
#import "YTCurrentAddressView.h"

@interface YTChangeAppionmentAddressViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SCIndexView *indexView;
@property (nonatomic, strong) YTCurrentAddressView *currentAddressView;

@property (nonatomic,strong) NSArray *rowArray;
@property (nonatomic,strong) NSArray *sectionArray;
@property (nonatomic, strong) NSArray<YCProvince *> *provinceList;
@property (nonatomic, strong) NSArray<YCCity *> *cityList;

@property (nonatomic, copy) NSString *provinceName;
@property (nonatomic, copy) NSString *cityName;

@end

@implementation YTChangeAppionmentAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"切换城市"];
    [self setupDataSource];
    [self setupSubViews];
    [self getCurrentLocation];
    
    NSMutableArray *indexArray = [self.sectionArray mutableCopy];
    self.indexView.dataSource = indexArray;
}

- (void)setupDataSource {
    self.provinceList = [YCAreaDataHelper provinceList];
    self.cityList = [YCAreaDataHelper cityList];
    [YCAreaDataHelper getAreaListDataBy:self.cityList andComplete:^(NSArray *rowArray, NSArray *sectionArray) {
        self.rowArray = rowArray;
        self.sectionArray = sectionArray;
    }];
}

- (void)setupSubViews {
    [self.view addSubview:self.currentAddressView];
    self.currentAddressView.frame = CGRectMake(0, 0, kScreenWidth, kRealValue(55));
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, self.currentAddressView.maxY, kScreenWidth, kScreenHeight - kNavBarHeight);
}

- (void)getCurrentLocation {
    @weakify(self);
    [[YCLocationManager sharedManager] getCurrentLocationAndCompleteBlock:^(NSString *province, NSString *city, NSError *error) {
        @strongify(self);
        if (!error) {
            [self.currentAddressView refreshByAddress:@"定位失败"];
        } else {
            [self.currentAddressView refreshByAddress:[NSString stringWithFormat:@"%@", city]];
            self.cityName = city;
            self.provinceName = province;
        }
    }];
}

- (UILabel *)createTableSectionHeaderLabel {
    UILabel * sectionLab = [[UILabel alloc] init];
    [sectionLab setFont:kSystemFont14];
    [sectionLab setTextColor:[UIColor colorWithHexString:@"#848688"]];
    [sectionLab setBackgroundColor:kGrayBackgroundColor];
    return sectionLab;
}

#pragma mark - Event
- (void)reLocationClicked {
    [self getCurrentLocation];
}

- (void)currentAddressClicked {
    if (!self.cityName.length) {
        [kAppWindow showAutoHideHudWithText:@"当前定位失败，请手动选择"];
        return;
    }
    if (self.selectAddressBlock) {
        self.selectAddressBlock(self.provinceName, self.cityName);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.rowArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_rowArray[section] count];
}

#pragma mark - UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSystemCellDefaultHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*cell样式*/
    static NSString * SystemCellID = @"SystemCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SystemCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SystemCellID];
    }
    
    /*cell附件样式*/
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    /*cell设置数据*/
    YCCity *city = self.rowArray[indexPath.section][indexPath.row];
    cell.textLabel.text = city.citysName;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //viewforHeader
    id label = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (!label) {
        label = [self createTableSectionHeaderLabel];
    }
    [label setText:[NSString stringWithFormat:@"  %@",_sectionArray[section]]];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kRealValue(22.0);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YCCity *city = self.rowArray[indexPath.section][indexPath.row];
    self.cityName = city.citysName;
    self.provinceName = city.proviceName;
    if (self.selectAddressBlock) {
        self.selectAddressBlock(self.provinceName, self.cityName);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - **************** Setter Getter
- (SCIndexView *)indexView {
    if (!_indexView) {
        _indexView = [[SCIndexView alloc] initWithTableView:self.tableView configuration:[SCIndexViewConfiguration configurationWithIndexViewStyle:SCIndexViewStyleDefault]];
        _indexView.configuration.indexItemTextColor = kBlackTextColor;
        _indexView.configuration.indexItemSelectedBackgroundColor = kPurpleTextColor;
        _indexView.configuration.indexItemsSpace = 8.f;
        //        _indexView.delegate = self;
        [self.view addSubview:self.indexView];
        
    }
    return _indexView;
}

- (YTCurrentAddressView *)currentAddressView {
    if (!_currentAddressView) {
        _currentAddressView = [[YTCurrentAddressView alloc] init];
        @weakify(self);
        _currentAddressView.locationClickedBlock = ^{
            @strongify(self);
            [self reLocationClicked];
        };
        _currentAddressView.addressSelectedBlock = ^{
            @strongify(self);
            [self currentAddressClicked];
        };
    }
    return _currentAddressView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = kGrayBackgroundColor;
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.sectionIndexColor = kBlackTextColor;
        _tableView.separatorInset = UIEdgeInsetsMake(0, kRealValue(15), 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
