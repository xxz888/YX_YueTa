//
//  YTAllInfoCell.m
//  YueTa
//
//  Created by 姚兜兜 on 2019/1/15.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTAllInfoCell.h"
#import "BaseConfigModel.h"

@interface YTAllInfoCell ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *arrowImg;

@end


@implementation YTAllInfoCell


- (void)loadContentViews {
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.infoLab];
    [self.contentView addSubview:self.arrowImg];
}


- (void)layoutContentViews {
    
    self.titleLab.frame = CGRectMake(kRealValue(10), 0, kRealValue(80), allInfoCellH);
    
    self.arrowImg.frame = CGRectMake(kScreenWidth-kRealValue(10)-kRealValue(15), 0, kRealValue(15), kRealValue(15));
    self.arrowImg.centerY = allInfoCellH/2;
    
    self.infoLab.frame = CGRectMake(self.titleLab.right+kRealValue(10), 0, kScreenWidth-self.titleLab.width-self.arrowImg.width-kRealValue(40), allInfoCellH);
}


- (void)loadDataWithModel:(id)model withIndexPath:(NSIndexPath *)indexPath {
    BaseConfigModel *myModel = (BaseConfigModel *)model;
    self.titleLab.text = myModel.title;
    if (myModel.subTitle.length) {
        self.infoLab.text = myModel.subTitle;
    }
}

#pragma mark - lazy init
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel labelWithName:@"" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _titleLab;
}

- (UILabel *)infoLab {
    if (!_infoLab) {
        _infoLab = [UILabel labelWithName:@"" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentRight];
    }
    return _infoLab;
}

- (UIImageView *)arrowImg {
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc] init];
        _arrowImg.image = KimageName(@"login_arrow");
    }
    return _arrowImg;
}

#pragma mark --
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
