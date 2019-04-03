//
//  YTSquareController.m
//  YueTa
//
//  Created by 姚兜兜 on 2018/12/20.
//  Copyright © 2018 姚兜兜. All rights reserved.
//

#import "YTSquareController.h"
#import "YTSquareChildController.h"
#import "SquareInterface.h"

#import "YTFiltrateSquareController.h"
#import "YTAppiontmentAddressViewController.h"

@interface YTSquareController ()<YTFiltrateSquareControllerDelegate>

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIButton *curBtn;

@property (nonatomic, strong) UIScrollView *contentScroll;

@end

@implementation YTSquareController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self createNavigationItem];
    
    [self setupChildController];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:@"near_filtrate" target:self action:@selector(rightBarButtonClick)];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"↓ 地区" titleColor:kWhiteTextColor target:self action:@selector(leftBarButtonClik)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithareaBackTitle:@"地区" target:self action:@selector(leftBarButtonClik)];
    
}

#pragma mark - events
- (void)titleButtonClick:(UIButton *)buton {
    
    self.curBtn.layer.borderWidth = 0.f;
    
    buton.layer.borderWidth = 1.f;
    self.curBtn = buton;
    
    [self.contentScroll setContentOffset:CGPointMake(kScreenWidth * self.curBtn.tag, 0) animated:YES];
}

- (void)rightBarButtonClick {
    YTFiltrateSquareController *vc = [[YTFiltrateSquareController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)leftBarButtonClik {
    YTAppiontmentAddressViewController *address = [[YTAppiontmentAddressViewController alloc] init];
    address.addressComfirmBlock = ^(NSString * _Nonnull area, NSString * _Nonnull site, CLLocationCoordinate2D coordinate) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithareaBackTitle:[NSString stringWithFormat:@"%@",area] target:self action:@selector(leftBarButtonClik)];
        
    };
    [self.navigationController pushViewController:address animated:YES];
}


#pragma mark - UI
- (void)createNavigationItem {
    
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 35)];
    self.navigationItem.titleView = _titleView;
    
    NSArray *titleArr = @[@"打赏",@"求打赏"];
    for (NSInteger i = 0; i < titleArr.count; i ++) {
        UIButton *button = [UIButton buttonWithTitle:titleArr[i] taget:self action:@selector(titleButtonClick:) font:kSystemFont14 titleColor:kWhiteTextColor];
        button.frame = CGRectMake(80*i, 0, 60, 25);
        button.tag = i;
        button.layer.borderColor = kWhiteTextColor.CGColor;
        [_titleView addSubview:button];
        
        if (i == 0) {
            button.layer.borderWidth = 1.f;
            self.curBtn = button;
        }
    }
}

- (void)setupChildController {
    for (NSInteger i = 0; i < 2; i ++) {
        YTSquareChildController *vc = [[YTSquareChildController alloc] init];
        vc.type = i;
        vc.view.frame = CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight-kNavBarHeight);
        [self addChildViewController:vc];
        [self.contentScroll addSubview:vc.view];
    }
}

#pragma mark - YTFiltrateSquareControllerDelegate
- (void)YTFiltrateControllerCompleteWithMax_weight:(NSInteger)max_weight min_weight:(NSInteger)min_weight max_age:(NSInteger)max_age min_age:(NSInteger)min_age max_height:(NSInteger)max_height min_height:(NSInteger)min_height isVip:(BOOL)isVip auth_status:(BOOL)auth_status sort:(BOOL)sort work:(NSString *)work education:(NSInteger)education show:(NSString *)show gender:(NSInteger)gender max_reward:(NSInteger)max_reward min_reward:(NSInteger)min_reward {
    
    [self.view showIndeterminateHudWithText:nil];
    [SquareInterface filtrateSquareListWithMax_weight:max_weight min_weight:min_weight max_age:max_age min_age:min_age max_height:max_height min_height:min_height isVip:isVip auth_status:auth_status sort:sort work:work education:education show:show page:1 gender:gender max_reward:max_reward min_reward:min_reward andBlock:^(ResponseMessage *rspStatusAndMessage, NSArray *array) {
        [self.view hideHud];
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            
            for (YTSquareChildController *vc in self.childViewControllers) {
                [vc reloadFiltrateData:array];
            }
        }
    }];
}

#pragma mark - lazy init
- (UIScrollView *)contentScroll {
    if (!_contentScroll) {
        _contentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight)];
        _contentScroll.backgroundColor = kWhiteBackgroundColor;
        _contentScroll.pagingEnabled = YES;
        _contentScroll.contentSize = CGSizeMake(kScreenWidth*2, 0);
        _contentScroll.bounces = NO;
        [self.view addSubview:_contentScroll];
    }
    return _contentScroll;
}

















@end
