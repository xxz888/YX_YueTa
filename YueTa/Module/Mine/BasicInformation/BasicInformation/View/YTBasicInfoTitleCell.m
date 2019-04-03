//
//  YTBasicInfoTitleCell.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/7.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTBasicInfoTitleCell.h"

@interface YTBasicInfoTitleCell ()

@property (nonatomic,strong) UILabel *leftTitleLabel;

@end

@implementation YTBasicInfoTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.leftTitleLabel];
        
        [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(kRealValue(15));
            make.width.lessThanOrEqualTo(@(kScreenWidth/2));
        }];
    }
    return self;
}

- (void)configureCellBySettingItem:(YTSettingItem *)item {
    _item = item;
    self.leftTitleLabel.text = item.leftTitle;
}

#pragma mark - **************** Setter Getter
- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [UILabel labelWithName:@"个人资料" Font:kSystemFont15 textColor:kGrayTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _leftTitleLabel;
}

@end
