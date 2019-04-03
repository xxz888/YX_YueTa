//
//  YTNearListCell.m
//  YueTa
//
//  Created by 姚兜兜 on 2019/1/23.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTNearListCell.h"
#import "NearListModel.h"

@interface YTNearListCell ()

@property (nonatomic, strong) UIImageView *header;
@property (nonatomic, strong) UIImageView *VIPImg;
@property (nonatomic, strong) UILabel *realLab;//实名认证的 才有的label

@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *workRound;//职位认证

@property (nonatomic, strong) UIImageView *genderImg;
@property (nonatomic, strong) UILabel *ageLab;
@property (nonatomic, strong) UILabel *workLab;
@property (nonatomic, strong) UILabel *educationLab;

@property (nonatomic, strong) UIImageView *locationImg;
@property (nonatomic, strong) UILabel *distanceLab;
@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) UILabel *showLab;//约会节目

@property (nonatomic, strong) UIButton *operationBtn;

@property (nonatomic, strong) CAGradientLayer *btnLayer;

@property (nonatomic, strong) NSArray *educationArr;

@end

@implementation YTNearListCell

- (void)loadContentViews {
    [self.contentView addSubview:self.header];
    [self.contentView addSubview:self.VIPImg];
    [self.contentView addSubview:self.realLab];
    
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.workRound];
    
    [self.contentView addSubview:self.genderImg];
    [self.contentView addSubview:self.ageLab];
    [self.contentView addSubview:self.workLab];
    [self.contentView addSubview:self.educationLab];
    
    [self.contentView addSubview:self.locationImg];
    [self.contentView addSubview:self.distanceLab];
    [self.contentView addSubview:self.timeLab];
    
    [self.contentView addSubview:self.showLab];
    
    
    // 登录按钮渐变色
    _btnLayer = [CAGradientLayer layer];
    _btnLayer.masksToBounds = YES;
    _btnLayer.colors = @[(__bridge id)RGB(134, 177, 230).CGColor,(__bridge id)RGB(192, 164, 234).CGColor,];
    _btnLayer.masksToBounds = YES;
    [self.contentView.layer addSublayer:_btnLayer];
    [self.contentView addSubview:self.operationBtn];
    
}


- (void)layoutContentViews {
    
    self.header.frame = CGRectMake(kRealValue(10), kRealValue(20), kRealValue(60), kRealValue(60));
    
    self.VIPImg.frame = CGRectMake(0, kRealValue(15), kRealValue(20), kRealValue(20));
    self.VIPImg.centerX = self.header.centerX;
    
    self.realLab.frame = CGRectMake(0, self.header.bottom-kRealValue(12), kRealValue(35), kRealValue(15));
    self.realLab.centerX = self.header.centerX;
    self.realLab.layer.cornerRadius = self.realLab.height/2;
    
    
    self.nameLab.frame = CGRectMake(self.header.right+kRealValue(10), self.header.y, kScreenWidth-kRealValue(110), kRealValue(18));
    
    self.workRound.frame = CGRectMake(self.nameLab.right, 0, kRealValue(15), kRealValue(15));
    self.workRound.centerY = self.nameLab.centerY;
    self.workRound.layer.cornerRadius = self.workRound.height/2;
    
    self.genderImg.frame = CGRectMake(self.nameLab.x, self.nameLab.bottom+kRealValue(5), kRealValue(15), kRealValue(15));
    
    self.ageLab.frame = CGRectMake(self.genderImg.right+kRealValue(5), 0, kRealValue(40), kRealValue(18));
    self.ageLab.centerY = self.genderImg.centerY;
    
    self.workLab.frame = CGRectMake(self.ageLab.right, 0, kRealValue(40), kRealValue(18));
    self.workLab.centerY = self.genderImg.centerY;
    
    self.educationLab.frame = CGRectMake(self.workLab.right, 0, kRealValue(40), kRealValue(18));
    self.educationLab.centerY = self.genderImg.centerY;
    
    self.locationImg.frame = CGRectMake(self.nameLab.x, self.genderImg.bottom+kRealValue(5), kRealValue(15), kRealValue(15));
    
    self.distanceLab.frame = CGRectMake(self.locationImg.right, 0, kRealValue(60), kRealValue(18));
    self.distanceLab.centerY = self.locationImg.centerY;
    
    self.timeLab.frame = CGRectMake(self.distanceLab.right, 0, kRealValue(100), kRealValue(18));
    self.timeLab.centerY = self.locationImg.centerY;
    
    self.showLab.frame = CGRectMake(self.header.x, self.header.bottom+kRealValue(15), kScreenWidth-kRealValue(20)-kRealValue(65), kRealValue(20));
    
    self.operationBtn.frame = CGRectMake(kScreenWidth-kRealValue(75), 0, kRealValue(65), kRealValue(32));
    self.operationBtn.centerY = self.showLab.centerY;
    
    _btnLayer.locations = @[@0.5];
    _btnLayer.startPoint = CGPointMake(0, 0);
    _btnLayer.endPoint = CGPointMake(1.0, 0.0);
    _btnLayer.frame = self.operationBtn.frame;
    _btnLayer.cornerRadius = kRealValue(8);
    
}


- (void)loadDataWithModel:(id)model withIndexPath:(NSIndexPath *)indexPath {
    
    NearListModel *myModel = (NearListModel *)model;
    
    if (myModel.photo.length) {
        [self.header sd_setImageWithURL:[NSURL URLWithString:myModel.photo] placeholderImage:KimageName(@"ic_head_pink")];
    }
    
    if (myModel.gender == 0) {
        self.genderImg.image = KimageName(@"ic_male");
    } else {
        self.genderImg.image = KimageName(@"ic_female");
    }
    
    self.nameLab.text = myModel.username;
    
    [self.nameLab sizeToFit];
    self.workRound.x = self.nameLab.right + kRealValue(10);
    
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
    
    if (myModel.auth_status) {
        self.realLab.hidden = NO;
    } else {
        self.realLab.hidden = YES;
    }
    
    self.ageLab.text = [NSString stringWithFormat:@"%ld",myModel.age];
    
    self.workLab.text = myModel.job;
    
    self.educationLab.text = self.educationArr[myModel.education];
    
    NSInteger distance = myModel.distance.integerValue / 1000;
    self.distanceLab.text = [NSString stringWithFormat:@"%ldkm",distance];
    
    NSInteger hour = myModel.finally_on_line / 3600;
    if (hour < 1) {
        self.timeLab.text = @"刚刚在线";
    } else {
        self.timeLab.text = [NSString stringWithFormat:@"%ld小时前在线",hour];
    }
    
    self.showLab.text = [NSString stringWithFormat:@"约会节目:%@",myModel.program];
    
    self.operationBtn.tag = indexPath.row;
}

#pragma mark - events
- (void)operationButton:(UIButton *)button {
    if (self.block) {
        self.block(button.tag);
    }
}

#pragma mark - lazy init
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

- (UILabel *)realLab {
    if (!_realLab) {
        _realLab = [UILabel labelWithName:@"真实" Font:kSystemFont10 textColor:kWhiteTextColor textAlignment:NSTextAlignmentCenter];
        _realLab.backgroundColor = RGB(136, 118, 228);
        _realLab.layer.masksToBounds = YES;
    }
    return _realLab;
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

- (UILabel *)ageLab {
    if (!_ageLab) {
        _ageLab = [UILabel labelWithName:@"" Font:kSystemFont13 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _ageLab;
}

- (UILabel *)workLab {
    if (!_workLab) {
        _workLab = [UILabel labelWithName:@"" Font:kSystemFont13 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _workLab;
}

- (UILabel *)educationLab {
    if (!_educationLab) {
        _educationLab = [UILabel labelWithName:@"" Font:kSystemFont13 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _educationLab;
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

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [UILabel labelWithName:@"时间" Font:kSystemFont12 textColor:RGB(225, 163, 135) textAlignment:NSTextAlignmentLeft];
    }
    return _timeLab;
}

- (UILabel *)showLab {
    if (!_showLab) {
        _showLab = [UILabel labelWithName:@"" Font:kSystemFont14 textColor:kGrayTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _showLab;
}

- (UIButton *)operationBtn {
    if (!_operationBtn) {
        _operationBtn = [UIButton buttonWithTitle:@"约TA" taget:self action:@selector(operationButton:) font:kSystemFont14 titleColor:kWhiteTextColor];
    }
    return _operationBtn;
}

- (NSArray *)educationArr {
    if (!_educationArr) {
        _educationArr = @[@"初中",@"高中",@"专科",@"本科",@"研究生",@"硕士",@"博士",@"博士后"];
    }
    return _educationArr;
}

@end
