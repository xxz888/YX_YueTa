//
//  YTAlbumScrollwView.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/25.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTAlbumScrollView.h"

@interface YTAlbumScrollView ()

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation YTAlbumScrollView

+ (void)showAlbumByDataArray:(NSArray *)dataArray selectedIndex:(NSInteger)selectedIndex {
    YTAlbumScrollView *scrollView = [[YTAlbumScrollView alloc] initWithFrame:kMainScreen_Bounds];
    scrollView.dataArray = dataArray;
    scrollView.selectedIndex = selectedIndex;
    [kAppWindow addSubview:scrollView];
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:kMainScreen_Bounds];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    
    for (int i = 0; i < dataArray.count; i++) {
        NSString *urlString = dataArray[i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:imageView];
        scrollView.contentSize = CGSizeMake(imageView.maxX, 0);
    }
    
    scrollView.contentOffset = CGPointMake(self.selectedIndex * kScreenWidth, 0);
    
    UIButton *backButton = [UIButton buttonWithImage:@"navigation_back" taget:self action:@selector(back)];
    backButton.frame = CGRectMake(10, kStatusBarHeight, 44, 44);
    [self addSubview:backButton];
}

- (void)back {
    [self removeFromSuperview];
}

@end
