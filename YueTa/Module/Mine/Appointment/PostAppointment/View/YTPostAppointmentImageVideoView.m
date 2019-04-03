//
//  YTPostAppointmentImageVideoView.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTPostAppointmentImageVideoView.h"
#import "YTPostAppointmentImageVideoViewCell.h"
#import "YTUploadImageFlowLayout.h"
#import "YTSelectPictureHelper.h"

@interface YTPostAppointmentImageVideoView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *tipsLabel;

@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, assign) BOOL isSelectVideo;
@property (nonatomic, copy) NSURL *videoURL;

@end

static NSString * reuseIdentifier = @"YTPictureUploadCell";

@implementation YTPostAppointmentImageVideoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageArray = [NSMutableArray array];
        [self p_setupSubViews];
    }
    return self;
}

- (void)p_setupSubViews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.collectionView];
    [self addSubview:self.tipsLabel];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kRealValue(15));
        make.left.equalTo(self).offset(kRealValue(15));
        make.right.equalTo(self).offset(-kRealValue(15));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRealValue(15));
        make.left.and.right.equalTo(self);
        make.height.equalTo(@kRealValue(70));
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom).offset(kRealValue(15));
        make.left.equalTo(self).offset(kRealValue(15));
        make.right.equalTo(self).offset(-kRealValue(15));
    }];
}

#pragma mark - **************** Event Response
- (void)addPicImage {
    if (self.imageArray.count >= 4) {
        return;
    }

    if (self.isSelectVideo) {
        return;
    }
    
    [[YTSelectPictureHelper sharedHelper] showVideoPictureSelectActionSheetWithMaxPicCount:4 - self.imageArray.count isNeedVideo:!self.isSelectVideo pictureCompleteBlock:^(NSArray * _Nonnull selectImageArray) {
        self.isSelectVideo = NO;
        [self.imageArray addObjectsFromArray:selectImageArray];
        [self.collectionView reloadData];
    } videoCompleteBlock:^(UIImage * _Nonnull thumbnailImage, NSURL * _Nonnull inputURL) {
        self.isSelectVideo = YES;
        self.videoURL = inputURL;
        [self.imageArray addObjectsFromArray:@[thumbnailImage]];
        [self.collectionView reloadData];
    }];
}

- (void)deleteImage:(UIImage *)image {
    [self.imageArray removeObject:image];
    [self.collectionView reloadData];
    
    if (self.imageArray.count == 0) {
        self.isSelectVideo = NO;
    }
}

#pragma mark - **************** UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.isSelectVideo) {
        return self.imageArray.count;
    }
    
    if (self.imageArray.count < 5){
        return self.imageArray.count + 1;
    }
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YTPostAppointmentImageVideoViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.addImageBlock = ^{
        [self addPicImage];
    };
    cell.deleteImageBlock = ^(UIImage *image) {
        [self deleteImage:image];
    };
    
    if (self.imageArray.count) {
        cell.image = indexPath.item <= self.imageArray.count - 1 ? self.imageArray[indexPath.item] : nil;
    } else {
        cell.image = nil;
    }
    
    return cell;
}


#pragma mark - **************** Setter Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithName:@"秀一下(可不传)" Font:kSystemFont16 textColor:kGrayTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[YTUploadImageFlowLayout alloc] init]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[YTPostAppointmentImageVideoViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    return _collectionView;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [UILabel labelWithName:@"请勿上传低俗的照片/视频,严重者将封号处理" Font:kSystemFont13 textColor:kGrayTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _tipsLabel;
}

@end
