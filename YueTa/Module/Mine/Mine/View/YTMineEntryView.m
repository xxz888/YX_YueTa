//
//  YTMineEntryView.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTMineEntryView.h"
#import "YTImgAlignmentButton.h"

@implementation YTMineEntryView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self p_setupSubViews];
    }
    return self;
}

- (void)p_setupSubViews {
    NSArray *titleArray = @[@"基础资料",
                            @"我的钱包",
                            @"商店",
                            @"认证中心",
                            @"客服中心",
                            @"设置",
                            @"黑名单",
                            @"关于我们"];
    NSArray *itemTypeArray = @[@(YTMineEntryTypeBasicInfo),
                               @(YTMineEntryTypeWallet),
                               @(YTMineEntryTypeStore),
                               @(YTMineEntryTypeCertificationCenter),
                               @(YTMineEntryTypeServiceCenter),
                               @(YTMineEntryTypeSetting),
                               @(YTMineEntryTypeBlackList),
                               @(YTMineEntryTypeAboutus)];
    for (int i = 0; i < titleArray.count; i++) {
        CGFloat buttonW = kScreenWidth/3;
        CGFloat buttonH = kRealValue(90);
        CGFloat buttonX = (i%3) * buttonW;
        CGFloat buttonY = (i/3) * buttonH;
        YTImgAlignmentButton *button = [[YTImgAlignmentButton alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        NSString *imageName = [NSString stringWithFormat:@"ic_grid%d",i + 1];
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        button.imageViewAlignment = ImageViewAlignmentTop;
        button.intervalImgToTitle = kRealValue(6);
        button.titleLabel.font = kSystemFont15;
        [button setTitleColor:kGrayTextColor forState:UIControlStateNormal];
        NSNumber *typeNumber = itemTypeArray[i];
        button.tag = typeNumber.integerValue;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)buttonClicked:(UIButton *)button {
    if (self.entryClickedBlock) {
        self.entryClickedBlock(button.tag);
    }
}

@end
