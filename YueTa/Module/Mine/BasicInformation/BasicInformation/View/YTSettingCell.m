//
//  YTSettingCell.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/7.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTSettingCell.h"

@interface YTSettingCell ()

@property (nonatomic,strong) UILabel *leftTitleLabel;
@property (nonatomic,strong) UILabel *rightTitleLabel;
@property (nonatomic,strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIImageView *avartarImageView;

@end

@implementation YTSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.leftTitleLabel];
        [self.contentView addSubview:self.rightTitleLabel];
        [self.contentView addSubview:self.arrowImageView];
        [self.contentView addSubview:self.avartarImageView];

        
        [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(kRealValue(15));
            make.width.lessThanOrEqualTo(@(kScreenWidth/2)).priorityHigh();
        }];
        
        [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftTitleLabel.mas_right).offset(kRealValue(15));
            make.right.equalTo(self.contentView).offset(-kRealValue(15));
            make.centerY.equalTo(self.contentView);
        }];
        
        [self.avartarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.arrowImageView.mas_left).offset(-kRealValue(10));
            make.centerY.equalTo(self.contentView);
            make.width.and.height.equalTo(@kRealValue(64));
        }];
        
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-kRealValue(15));
            make.width.and.height.equalTo(@kRealValue(16));
        }];
    }
    return self;
}

- (void)configureCellBySettingItem:(YTSettingItem *)item {
    _item = item;
    
    //显示
    self.rightTitleLabel.hidden = item.cellType == YTSettingItemTypeAvartar;
    self.avartarImageView.hidden = item.cellType != YTSettingItemTypeAvartar;
    self.arrowImageView.hidden = item.cellType == YTSettingItemTypeLeftRightTitle;
    
    //位置
    if (item.cellType == YTSettingItemTypeLeftRightTitle) {
        [self.rightTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-kRealValue(20));
        }];
    } else {
        [self.rightTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-kRealValue(40));
        }];
    }
    
    //数据
    self.leftTitleLabel.text = item.leftTitle;
    self.rightTitleLabel.text = item.rightTitle;
    if (item.avatarURL) {
        [self.arrowImageView sd_setImageWithURL:[NSURL URLWithString:item.avatarURL]];
    } else {
        self.avartarImageView.image = [UIImage imageNamed:@"ic_head_pink"];
    }
}

#pragma mark - **************** Setter Getter
- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [UILabel labelWithName:nil Font:kSystemFont14 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _leftTitleLabel;
}

- (UILabel *)rightTitleLabel {
    if (!_rightTitleLabel) {
        _rightTitleLabel = [UILabel labelWithName:nil Font:kSystemFont14 textColor:kGrayTextColor textAlignment:NSTextAlignmentRight];
    }
    return _rightTitleLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"ic_arrow_right"];
    }
    return _arrowImageView;
}

- (UIImageView *)avartarImageView {
    if (!_avartarImageView) {
        _avartarImageView = [[UIImageView alloc] init];
        _avartarImageView.layer.cornerRadius = kRealValue(64)/2;
        _avartarImageView.layer.masksToBounds = YES;
    }
    return _avartarImageView;
}

@end
