//
//  YTVipPackageView.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/21.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTVipPackageView.h"

@implementation YTVipPackageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [UILabel labelWithName:@"会员" Font:kSystemFont14 textColor:kBlackTextColor textAlignment:NSTextAlignmentCenter];
        self.titleLabel.frame = CGRectMake(0, kRealValue(20), kRealValue(100), kRealValue(15));
        [self addSubview:self.titleLabel];
        
        self.timeLabel = [UILabel labelWithName:@"15天" Font:kSystemFontBold18 textColor:kBlackTextColor textAlignment:NSTextAlignmentCenter];
        self.timeLabel.frame = CGRectMake(0, self.titleLabel.maxY + kRealValue(20), self.titleLabel.width, kRealValue(20));
        [self addSubview:self.timeLabel];
        
        self.moneyLabel = [UILabel labelWithName:@"120元/月" Font:kSystemFont14 textColor:kBlackTextColor textAlignment:NSTextAlignmentCenter];
        self.moneyLabel.frame = CGRectMake(0, self.timeLabel.maxY + kRealValue(20), self.titleLabel.width, kRealValue(15));
        [self addSubview:self.moneyLabel];
        
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 1;
        self.layer.borderColor = kGrayBorderColor.CGColor;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tap {
    if (self.vipPackageViewClickBlock) {
        self.vipPackageViewClickBlock(self);
    }
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    
    if (isSelected) {
        self.layer.borderColor = kBorderPurpleBorderColor.CGColor;
        self.backgroundColor = kLightPurpleColor;
    } else {
        self.layer.borderColor = kGrayBorderColor.CGColor;
        self.backgroundColor = kWhiteBackgroundColor;
    }
}

@end
