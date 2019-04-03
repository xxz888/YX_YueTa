//
//  YTPayStyleCell.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/21.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTPayStyleCell.h"

@interface YTPayStyleCell ()

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *selectImageView;

@end

@implementation YTPayStyleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.leftImageView];
        [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(kRealValue(20));
            make.width.and.height.equalTo(@(kRealValue(24)));
        }];
        
        self.titleLabel = [UILabel labelWithName:nil Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.leftImageView.mas_right).offset(kRealValue(15));
            make.width.equalTo(@kRealValue(100));
        }];
        
        self.selectImageView = [[UIImageView alloc] init];
        self.selectImageView.image = [UIImage imageNamed:@"ic_un_check"];
        [self.contentView addSubview:self.selectImageView];
        [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-kRealValue(20));
            make.width.and.height.equalTo(@(kRealValue(16)));
        }];
    }
    return self;
}

- (void)setPayStyleModel:(YTPayStyleModel *)payStyleModel {
    _payStyleModel = payStyleModel;
    
    self.leftImageView.image = [UIImage imageNamed:payStyleModel.leftImageName];
    
    self.titleLabel.text = payStyleModel.titleName;
    
    if (payStyleModel.isSelected) {
        self.selectImageView.image = [UIImage imageNamed:@"ic_check"];
    } else {
        self.selectImageView.image = [UIImage imageNamed:@"ic_un_check"];
    }
}

@end
