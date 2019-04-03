//
//  YDXTabBar.m
//  ydx-inke
//
//  Created by LIN on 16/10/23.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import "YDXTabBar.h"
#import <SDWebImage/UIButton+WebCache.h>

#define tabbarUnSelectColor RGB(185, 203, 235)
#define tabbarSelectColor RGB(116, 59, 184)

@interface YDXTabBar ()

@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) NSArray *selDataList;
@property (nonatomic, strong) NSArray *titleList;
@property (nonatomic, strong) UIImageView *tabbarView;

@end

@implementation YDXTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        //装载背景
        [self addSubview:self.tabbarView];
        
        //装载item
        for (NSInteger i = 0; i < self.dataList.count; i ++) {
            
            
            UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.dataList[i]]];
            image.tag = YDXBarItemNear + i + 1000;
            [self addSubview:image];
            
            UILabel *titleLab = [UILabel labelWithName:self.titleList[i] Font:[UIFont systemFontOfSize:12] textColor:tabbarUnSelectColor textAlignment:NSTextAlignmentCenter];
            titleLab.tag = YDXBarItemNear + i + 2000;
            [self addSubview:titleLab];
            
            UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
            [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
            item.tag = YDXBarItemNear + i;
            [self addSubview:item];
            
            if (i == 0) {
                item.selected = YES;
                self.lastItem = item;
                image.image = [UIImage imageNamed:self.selDataList[0]];
                titleLab.textColor = tabbarSelectColor;
            }
            
            if (i == 3) {// 消息一栏，单独放置一个小红点
                [self addSubview:self.redPoint];
            }
        }
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tabbarView.frame = self.bounds;
    
    CGFloat width = self.bounds.size.width/self.dataList.count;
    
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        
        UIView *subview = [self subviews][i];
        // 先找到按钮，再找到按钮对应的图片和文字
        if ([subview isKindOfClass:[UIButton class]]) {
            if (subview.tag == YDXBarItemPublish) {//中间 发布的按钮
                subview.frame = CGRectMake((subview.tag-YDXBarItemNear) * width, -13, width, 49+13);
                
                //图片
                UIImageView *image = [self viewWithTag:subview.tag + 1000];
                image.frame = CGRectMake(0, -15, 43, 43);
                image.centerX = subview.centerX;
                
                //文字
                UILabel *titleLab = [self viewWithTag:subview.tag + 2000];
                [titleLab sizeToFit];
                titleLab.frame = CGRectMake(0, image.bottom+2, titleLab.width, titleLab.height);
                titleLab.centerX = subview.centerX;
                
            } else {
                subview.frame = CGRectMake((subview.tag-YDXBarItemNear) * width, 0, width, 49);
                
                //图片
                UIImageView *image = [self viewWithTag:subview.tag + 1000];
                image.frame = CGRectMake(4, 2, 25, 25);
                image.centerX = subview.centerX;
                
                //文字
                UILabel *titleLab = [self viewWithTag:subview.tag + 2000];
                [titleLab sizeToFit];
                titleLab.frame = CGRectMake(0, image.bottom+2, titleLab.width, titleLab.height);
                titleLab.centerX = subview.centerX;
            }
            
            if (subview.tag == YDXBarItemMessage) {// 消息一栏，单独放置一个小红点
                self.redPoint.frame = CGRectMake(0, 0, 8, 8);
                self.redPoint.center = CGPointMake(subview.centerX+13, subview.centerY-15);
                self.redPoint.layer.cornerRadius = self.redPoint.width/2;
            }
        }
    }
}

- (void)clickItem:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(tabBar:clickButton:)]) {
        [self.delegate tabBar:self clickButton:button.tag];
    }
    
    // 如果点击了多媒体的tabbar的按钮，则不做按钮切换
    if (button.tag == YDXBarItemPublish) {
        return;
    }
    
    [self setupNextItemStyle:button];
    
    //设置动画
//    [UIView animateWithDuration:0.2 animations:^{
//        //将button扩大2倍
//        button.transform = CGAffineTransformMakeScale(1.2, 1.2);
//    }completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.2 animations:^{
//            //恢复原始状态
//            button.transform = CGAffineTransformIdentity;
//        }];
//    }];
}


// 设置选择的，对应item的样式
- (void)setupNextItemStyle:(UIButton *)nextBTn {
    
    self.lastItem.selected = NO;
    nextBTn.selected = YES;
    
    // 上一个被选中的
    UIImageView *oldImg = [self viewWithTag:self.lastItem.tag+1000];
    oldImg.image = [UIImage imageNamed:self.dataList[self.lastItem.tag-YDXBarItemNear]];
    UILabel *oldTitle = [self viewWithTag:self.lastItem.tag+2000];
    oldTitle.textColor = tabbarUnSelectColor;
    
    // 将要被选中的
    UIImageView *newImg = [self viewWithTag:nextBTn.tag+1000];
    newImg.image = [UIImage imageNamed:self.selDataList[nextBTn.tag-YDXBarItemNear]];
    UILabel *newTitle = [self viewWithTag:nextBTn.tag+2000];
    newTitle.textColor = tabbarSelectColor;
    
    self.lastItem = nextBTn;
}

#pragma mark - lazt init
- (NSArray *)dataList {
    if (!_dataList) {
        _dataList = @[
                      @"ic_nearby_un",
                      @"ic_square_un",
                      @"ic_add",
                      @"ic_message_un",
                      @"ic_mine_un"
                      ];
    }
    return _dataList;
}

- (NSArray *)selDataList {
    if (!_selDataList) {
        _selDataList = @[
                         @"ic_nearby",
                         @"ic_square",
                         @"ic_add",
                         @"ic_message",
                         @"ic_mine"
                         ];
    }
    return _selDataList;
}

- (NSArray *)titleList {
    if (!_titleList) {
        _titleList = @[@"附近",@"广场",@"发布",@"消息",@"我的"];
    }
    return _titleList;
}

- (UIImageView *)tabbarView {
    if (!_tabbarView) {
        _tabbarView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:kWhiteBackgroundColor size:CGSizeMake(kScreenWidth, kTabBarHeight)]];
    }
    return _tabbarView;
}

- (UIView *)redPoint {
    if (!_redPoint) {
        _redPoint = [[UIView alloc] init];
        _redPoint.backgroundColor = [UIColor redColor];
        _redPoint.layer.masksToBounds = YES;
        _redPoint.hidden = YES;
    }
    return _redPoint;
}


@end
