//
//  YTAppiontmentSearchViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/7.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTAppiontmentSearchViewController.h"
#import "YTAppiontmentSearchNavigationBar.h"

@interface YTAppiontmentSearchViewController ()<UITableViewDelegate,UITableViewDataSource,AMapSearchDelegate,YTAppiontmentSearchNavigationBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic) UIView *noResultView;
@property (nonatomic) YTAppiontmentSearchNavigationBar *searchNavigationBar;

@property (nonatomic) NSMutableArray<AMapPOI *> *allMapPOIs;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, strong) AMapPOIKeywordsSearchRequest *request;

@end

@implementation YTAppiontmentSearchViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
}

- (void)setupSubViews {
    [self.view addSubview:self.searchNavigationBar];
    self.searchNavigationBar.frame = CGRectMake(0, 0, kScreenWidth, kNavBarHeight);
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, self.searchNavigationBar.maxY, kScreenWidth, kScreenHeight - self.searchNavigationBar.maxY);
}

- (NSString *)getAddressFromAMapPOI:(AMapPOI *)poi {
    NSString *address;
    if ([poi.city isEqualToString:poi.province]) {
        address = [NSString stringWithFormat:@"%@%@", poi.city, poi.address];
    }else {
        address = [NSString stringWithFormat:@"%@%@%@", poi.province, poi.city, poi.address];
    }
    
    return address;
}

- (void)searchPoiByKeyword:(NSString *)keywords {
    self.request.keywords = keywords;
    [self.search AMapPOIKeywordsSearch:self.request];
}

#pragma mark - **************** AMapSearchDelegate
//搜索发生错误时调用
- (void)AMapSearchRequest:(id)_request didFailWithError:(NSError *)error {
    NSLog(@"%s: searchRequest = %@, errInfo= %@", __func__, [_request class], error);
}

//搜索成功回调
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
//    NSLog(@"搜索结果返回: %ld %ld", (long)request.offset, (unsigned long)response.pois.count);
    
    if (response.pois.count == 0) {
        _curPage = request.page;
        if (_curPage == 1) {
            [self.allMapPOIs removeAllObjects];
            self.tableView.tableHeaderView = self.noResultView;
        }
        
    } else {
        _curPage = request.page;
        self.tableView.tableHeaderView = nil;
        if (_curPage == 1) {
            self.allMapPOIs = [response.pois mutableCopy];
        } else {
            [self.allMapPOIs addObjectsFromArray:response.pois];
        }
    }
    [self.tableView reloadData];
}

#pragma mark - ****************
- (void)searchTextDidChange:(NSString *)searchText {
    self.curPage = 1;
    self.request.page = 1;
    [self searchPoiByKeyword:searchText];
}

- (void)searchButtonDidTapped:(NSString *)searchText {
    self.curPage = 1;
    self.request.page = 1;
    [self searchPoiByKeyword:searchText];
}

- (void)cancelButtonDidTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * SystemCellID = @"SystemCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SystemCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SystemCellID];
    }
    
    AMapPOI *poi = self.allMapPOIs[indexPath.row];
    cell.textLabel.text = poi.name;
    cell.detailTextLabel.text = [self getAddressFromAMapPOI:poi];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allMapPOIs.count;
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSystemCellDefaultHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AMapPOI *poi = self.allMapPOIs[indexPath.row];
    if (self.locationClickedBlock) {
        self.locationClickedBlock(poi);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - **************** Setter Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.sectionIndexColor = kBlackTextColor;
        _tableView.separatorInset = UIEdgeInsetsMake(0, kRealValue(15), 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSMutableArray<AMapPOI *> *)allMapPOIs {
    if (!_allMapPOIs) {
        _allMapPOIs = [NSMutableArray array];
    }
    return _allMapPOIs;
}

- (AMapSearchAPI *)search {
    if (!_search) {
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return _search;
}

- (AMapPOIKeywordsSearchRequest *)request {
    if (!_request) {
        _request = [[AMapPOIKeywordsSearchRequest alloc] init];
        if (self.currentCity) {
            _request.city = self.currentCity;
        }
    }
    return _request;
}

- (UIView *)noResultView {
    if (!_noResultView) {
        _noResultView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
        
        UILabel *_noResultLabel = [[UILabel alloc] init];
        _noResultLabel.text = @"无结果";
        _noResultLabel.font = [UIFont boldSystemFontOfSize:20];
        _noResultLabel.textColor = kGrayTextColor;
        [_noResultLabel sizeToFit];
        _noResultLabel.center = CGPointMake(kScreenWidth/2, 110);
        [_noResultView addSubview:_noResultLabel];
    }
    return _noResultView;
}

- (YTAppiontmentSearchNavigationBar *)searchNavigationBar {
    if (!_searchNavigationBar) {
        _searchNavigationBar = [[YTAppiontmentSearchNavigationBar alloc] init];
        _searchNavigationBar.delegate = self;
    }
    return _searchNavigationBar;
}

@end
