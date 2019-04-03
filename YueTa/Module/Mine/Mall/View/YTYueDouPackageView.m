//
//  YTPayPackageView.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/21.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTYueDouPackageView.h"

@implementation YTYueDouPackageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [UILabel labelWithName:@"300约豆" Font:kSystemFont14 textColor:kBlackTextColor textAlignment:NSTextAlignmentCenter];
        self.titleLabel.frame = CGRectMake(0, kRealValue(10), kRealValue(100), kRealValue(15));
        [self addSubview:self.titleLabel];
        
        self.moneyLabel = [UILabel labelWithName:@"¥6" Font:kSystemFontBold18 textColor:kBlackTextColor textAlignment:NSTextAlignmentCenter];
        self.moneyLabel.frame = CGRectMake(0, self.titleLabel.maxY + kRealValue(10), self.titleLabel.width, kRealValue(20));
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
    if (self.yueDouPackageViewClickBlock) {
        self.yueDouPackageViewClickBlock(self);
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
