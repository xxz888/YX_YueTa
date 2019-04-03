//
//  YTSquareListCell.m
//  YueTa
//
//  Created by Awin on 2019/1/29.
//  Copyright © 2019年 姚兜兜. All rights reserved.
//

#import "YTSquareListCell.h"
#import "YTMyDateModel.h"

@interface YTSquareListCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *header;
@property (nonatomic, strong) UIImageView *VIPImg;

@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIImageView *genderImg;
@property (nonatomic, strong) UILabel *workRound;//职位认证

@property (nonatomic, strong) UIImageView *thumbnail;//右上角 缩略图

@property (nonatomic, strong) UILabel *publishTime;
@property (nonatomic, strong) UIImageView *locationImg;
@property (nonatomic, strong) UILabel *distanceLab;

@property (nonatomic, strong) UIView *showBg;
@property (nonatomic, strong) UILabel *timeLab;//约会时间
@property (nonatomic, strong) UILabel *showLocation;//约会地点
@property (nonatomic, strong) UILabel *showLab;//约会节目

@property (nonatomic, strong) UILabel *moneyLab;//打赏金额

@property (nonatomic, strong) UIButton *operationBtn;
@property (nonatomic, strong) CAGradientLayer *btnLayer;

@end

@implementation YTSquareListCell

- (void)loadContentViews {
    
    [self.contentView addSubview:self.bgView];
    
    [self.bgView addSubview:self.header];
    [self.bgView addSubview:self.VIPImg];
    
    [self.bgView addSubview:self.nameLab];
    [self.bgView addSubview:self.genderImg];
    [self.bgView addSubview:self.workRound];
    [self.bgView addSubview:self.thumbnail];
    
    [self.bgView addSubview:self.publishTime];
    [self.bgView addSubview:self.locationImg];
    [self.bgView addSubview:self.distanceLab];
    
    [self.bgView addSubview:self.showBg];
    [self.showBg addSubview:self.timeLab];
    [self.showBg addSubview:self.showLocation];
    [self.showBg addSubview:self.showLab];
    
    [self.bgView addSubview:self.moneyLab];
    [self.bgView addSubview:self.operationBtn];
    
    // 登录按钮渐变色
    _btnLayer = [CAGradientLayer layer];
    _btnLayer.masksToBounds = YES;
    _btnLayer.colors = @[(__bridge id)RGB(134, 177, 230).CGColor,(__bridge id)RGB(192, 164, 234).CGColor,];
    _btnLayer.masksToBounds = YES;
    [self.bgView.layer addSublayer:_btnLayer];
    [self.bgView addSubview:self.operationBtn];
    
}


- (void)layoutContentViews {
    
    self.bgView.frame = CGRectMake(kRealValue(10), kRealValue(10), kScreenWidth-kRealValue(20), squareListCellH-kRealValue(20));
    self.bgView.layer.cornerRadius = kRealValue(10);
    
    self.header.frame = CGRectMake(kRealValue(10), kRealValue(20), kRealValue(60), kRealValue(60));
    
    self.VIPImg.frame = CGRectMake(0, kRealValue(15), kRealValue(20), kRealValue(20));
    self.VIPImg.centerX = self.header.centerX;
    
    self.nameLab.frame = CGRectMake(self.header.right+kRealValue(10), self.header.y+kRealValue(5), kScreenWidth-kRealValue(90), kRealValue(18));
    
    self.genderImg.frame = CGRectMake(self.nameLab.x, 0, kRealValue(15), kRealValue(15));
    self.genderImg.centerY = self.nameLab.centerY;
    
    self.workRound.frame = CGRectMake(_genderImg.right+kRealValue(10), 0, kRealValue(18), kRealValue(18));
    self.workRound.centerY = self.nameLab.centerY;
    self.workRound.layer.cornerRadius = self.workRound.height/2;

    self.thumbnail.frame = CGRectMake(self.bgView.width-kRealValue(70), kRealValue(20), kRealValue(60), kRealValue(60));
    
    self.publishTime.frame = CGRectMake(_nameLab.x, _nameLab.bottom+kRealValue(10), kRealValue(100), kRealValue(20));
    
    self.locationImg.frame = CGRectMake(self.publishTime.right, 0, kRealValue(15), kRealValue(15));
    self.locationImg.centerY = self.publishTime.centerY;
    
    self.distanceLab.frame = CGRectMake(self.locationImg.right, 0, kRealValue(60), kRealValue(18));
    self.distanceLab.centerY = self.locationImg.centerY;
    
    
    self.showBg.frame = CGRectMake(kRealValue(10), self.header.bottom+kRealValue(10), self.bgView.width-kRealValue(20), kRealValue(70));
    
    self.timeLab.frame = CGRectMake(kRealValue(10), kRealValue(10), kRealValue(150), kRealValue(25));
    
    self.showLocation.frame = CGRectMake(self.showBg.width-kRealValue(100), kRealValue(10), kRealValue(90), kRealValue(25));
    
    self.showLab.frame = CGRectMake(kRealValue(10), kRealValue(35), self.bgView.width-kRealValue(20), kRealValue(25));
    
    self.moneyLab.frame = CGRectMake(kRealValue(10), self.showBg.bottom+kRealValue(15), self.bgView.width-kRealValue(95), kRealValue(30));
    
    self.operationBtn.frame = CGRectMake(self.bgView.width-kRealValue(75), 0, kRealValue(65), kRealValue(32));
    self.operationBtn.centerY = self.moneyLab.centerY;
    
    _btnLayer.locations = @[@0.5];
    _btnLayer.startPoint = CGPointMake(0, 0);
    _btnLayer.endPoint = CGPointMake(1.0, 0.0);
    _btnLayer.frame = self.operationBtn.frame;
    _btnLayer.cornerRadius = kRealValue(8);
    
}


- (void)loadDataWithModel:(id)model withIndexPath:(NSIndexPath *)indexPath {
    
    YTMyDateModel *myModel = (YTMyDateModel *)model;
    
    if (myModel.photo.length) {
        [self.header sd_setImageWithURL:[NSURL URLWithString:myModel.photo] placeholderImage:KimageName(@"ic_head_pink")];
    }
    
    self.nameLab.text = myModel.name;
    [self.nameLab sizeToFit];
    self.genderImg.x = self.nameLab.right + kRealValue(10);
    self.workRound.x = self.genderImg.right + kRealValue(10);
    
    if (myModel.gender == 0) {
        self.genderImg.image = KimageName(@"ic_male");
    } else {
        self.genderImg.image = KimageName(@"ic_female");
    }
    
    if (myModel.VIP) {
        self.VIPImg.hidden = NO;
    } else {
        self.VIPImg.hidden = YES;
    }
    
    if (myModel.auth_job) {
        self.workRound.hidden = NO;
    } else {
        self.workRound.hidden = YES;
    }
    
    self.publishTime.text = [myModel.publish_time timeForSpeciallFormatter:@"yyyy.MM.dd"];
    [self.publishTime sizeToFit];
    self.locationImg.x = self.publishTime.right+kRealValue(5);
    self.locationImg.centerY = self.publishTime.centerY;
    
    
    self.distanceLab.text = [NSString stringWithFormat:@"%.2ld",myModel.distance/1000];
    [self.distanceLab sizeToFit];
    self.distanceLab.x = self.locationImg.right+kRealValue(5);
    self.distanceLab.centerY = self.publishTime.centerY;
    
    
    self.thumbnail.backgroundColor = kGrayBorderColor;
    
    self.timeLab.text = [NSString stringWithFormat:@"%@ %@",[myModel.date_time timeForSpeciallFormatter:@"yyyy.MM.dd"],myModel.duration];
    
    self.showLocation.text = myModel.area;
    
    self.showLab.text = myModel.program_str;
    
    if (myModel.reward_type == 1) { //求打赏
        self.moneyLab.text = [NSString stringWithFormat:@"求打赏赏金:¥%@(打赏约Ta)",myModel.reward];
        [self.operationBtn setTitle:@"约Ta" forState:UIControlStateNormal];
    } else {
        self.moneyLab.text = [NSString stringWithFormat:@"打赏赏金:¥%@(求打赏报名)",myModel.reward];
        [self.operationBtn setTitle:@"报名" forState:UIControlStateNormal];
    }
    
    self.operationBtn.tag = indexPath.row;
    
    if (myModel.show1.length > 10) {
        self.thumbnail.hidden = NO;
        if ([myModel.show1 containsString:@"mp4"]) {
            self.thumbnail.image = KimageName(@"ic_video");
        } else {
            [self.thumbnail sd_setImageWithURL:[NSURL URLWithString:myModel.show1]];
        }
    } else {
        self.thumbnail.hidden = YES;
    }
    
}

#pragma mark - events
- (void)operationButton:(UIButton *)button {
    if (self.block) {
        self.block(button.tag);
    }
}

#pragma mark - lazy init
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = kWhiteBackgroundColor;
//        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 10;
        _bgView.layer.shadowColor = kDarkBlackTextColor.CGColor;
        _bgView.layer.shadowOffset = CGSizeMake(0, 0);
        _bgView.layer.shadowOpacity = 0.5;
        _bgView.layer.shadowRadius = 5;
    }
    return _bgView;
}

- (UIImageView *)header {
    if (!_header) {
        _header = [[UIImageView alloc] init];
        _header.layer.masksToBounds = YES;
        _header.contentMode = UIViewContentModeScaleAspectFill;
        _header.clipsToBounds = YES;
        _header.image = KimageName(@"ic_head_pink");
    }
    return _header;
}

- (UIImageView *)VIPImg {
    if (!_VIPImg) {
        _VIPImg = [[UIImageView alloc] init];
        _VIPImg.image = KimageName(@"ic_vip");
    }
    return _VIPImg;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [UILabel labelWithName:@"" Font:kSystemFont14 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _nameLab;
}

- (UILabel *)workRound {
    if (!_workRound) {
        _workRound = [UILabel labelWithName:@"职" Font:kSystemFont10 textColor:kWhiteTextColor textAlignment:NSTextAlignmentCenter];
        _workRound.backgroundColor = RGB(254, 200, 47);
        _workRound.layer.masksToBounds = YES;
    }
    return _workRound;
}

- (UIImageView *)genderImg {
    if (!_genderImg) {
        _genderImg = [[UIImageView alloc] init];
        _genderImg.image = KimageName(@"ic_male"); // ic_female
    }
    return _genderImg;
}

- (UIImageView *)thumbnail {
    if (!_thumbnail) {
        _thumbnail = [[UIImageView alloc] init];
        _thumbnail.contentMode = UIViewContentModeScaleAspectFill;
        _thumbnail.clipsToBounds = YES;
        _thumbnail.layer.cornerRadius = kRealValue(8);
        _thumbnail.layer.masksToBounds = YES;
    }
    return _thumbnail;
}


- (UIImageView *)locationImg {
    if (!_locationImg) {
        _locationImg = [[UIImageView alloc] init];
        _locationImg.image = KimageName(@"ic_location");
    }
    return _locationImg;
}

- (UILabel *)distanceLab {
    if (!_distanceLab) {
        _distanceLab = [UILabel labelWithName:@"距离" Font:kSystemFont12 textColor:kDarkGrayTextColor textAlignment:NSTextAlignmentCenter];
    }
    return _distanceLab;
}

- (UILabel *)publishTime {
    if (!_publishTime) {
        _publishTime = [UILabel labelWithName:@"时间" Font:kSystemFont12 textColor:RGB(225, 163, 135) textAlignment:NSTextAlignmentLeft];
    }
    return _publishTime;
}

- (UIView *)showBg {
    if (!_showBg) {
        _showBg = [[UIView alloc] init];
        _showBg.layer.borderColor = kGrayBorderColor.CGColor;
        _showBg.layer.borderWidth = 0.8f;
        _showBg.layer.masksToBounds = YES;
        _showBg.layer.cornerRadius = kRealValue(5);
    }
    return _showBg;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [UILabel labelWithName:@"" Font:kSystemFont14 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _timeLab;
}

- (UILabel *)showLocation {
    if (!_showLocation) {
        _showLocation = [UILabel labelWithName:@"" Font:kSystemFont14 textColor:kBlackTextColor textAlignment:NSTextAlignmentRight];
    }
    return _showLocation;
}

- (UILabel *)showLab {
    if (!_showLab) {
        _showLab = [UILabel labelWithName:@"" Font:kSystemFont14 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _showLab;
}

- (UIButton *)operationBtn {
    if (!_operationBtn) {
        _operationBtn = [UIButton buttonWithTitle:@"约TA" taget:self action:@selector(operationButton:) font:kSystemFont14 titleColor:kWhiteTextColor];
    }
    return _operationBtn;
}

- (UILabel *)moneyLab {
    if (!_moneyLab) {
        _moneyLab = [UILabel labelWithName:@"" Font:kSystemFont14 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _moneyLab;
}

@end
