//
//  YTMyAlbumCell.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/7.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTMyAlbumCell.h"

@interface YTMyAlbumCell ()

@property (nonatomic,strong) UIImageView *picImageView;//照片
@property (nonatomic,strong) UIButton *addPhotoBtn;//添加btn
@property (nonatomic,strong) UIButton *deleteBtn;//删除btn

@end

@implementation YTMyAlbumCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createCell];
    }
    return self;
}

- (void)createCell {
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.left.and.right.equalTo(self.contentView);
    }];
    
    [self.addPhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.left.and.right.equalTo(self.contentView);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.equalTo(self.contentView);
        make.width.and.height.equalTo(@kRealValue(18));
    }];
}

- (void)setAlbumURL:(NSString *)albumURL {
    _albumURL = albumURL;
    if (albumURL != nil) {
        [self.picImageView sd_setImageWithURL:[NSURL URLWithString:self.albumURL]];
        self.addPhotoBtn.hidden = true;
        self.addPhotoBtn.userInteractionEnabled = false;
        self.deleteBtn.hidden = false;
    } else {
        self.picImageView.image = nil;
        self.addPhotoBtn.userInteractionEnabled = YES;
        self.deleteBtn.hidden = true;
        self.addPhotoBtn.hidden = false;
    }
}

#pragma mark - **************** Events
- (void)addPics:(UIButton *)button {
    if (self.addImageBlock) {
        self.addImageBlock();
    }
}

#pragma mark - **************** Setter Getter
- (UIImageView *)picImageView {
    if (!_picImageView) {
        _picImageView = [[UIImageView alloc] init];
        _picImageView.contentMode = UIViewContentModeScaleAspectFill;
        _picImageView.userInteractionEnabled = YES;
        _picImageView.layer.masksToBounds = YES;
        _picImageView.layer.cornerRadius = 3;
        [self.contentView addSubview:_picImageView];
    }
    return _picImageView;
}

- (UIButton *)addPhotoBtn {
    if (!_addPhotoBtn) {
        _addPhotoBtn = [[UIButton alloc] init];
        [_addPhotoBtn setImage:[UIImage imageNamed:@"ic_add_big"] forState:UIControlStateNormal];
    [_addPhotoBtn addTarget:self action:@selector(addPics:) forControlEvents:UIControlEventTouchUpInside];
        _addPhotoBtn.backgroundColor = [UIColor colorWithHexString:@"#EAEAF5"];
        [self.contentView addSubview:_addPhotoBtn];
    }
    return _addPhotoBtn;
}


@end
