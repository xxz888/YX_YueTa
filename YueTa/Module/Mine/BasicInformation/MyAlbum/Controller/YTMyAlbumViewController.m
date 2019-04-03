//
//  YTMyAlbumViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/7.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTMyAlbumViewController.h"
#import "YTMyAlbumFlowLayout.h"
#import "YTMyAlbumCell.h"
#import "YTSelectPictureHelper.h"
#import "MineInterface.h"
#import "YTAlbumScrollView.h"

@interface YTMyAlbumViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) UIView *bottomView;

@end

static NSString *reuseIdentifier = @"YTMyAlbumCell";

@implementation YTMyAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"个人相册"];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kRealValue(15));
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
//        if (kDevice_Is_iPhoneX) {
//            make.bottom.equalTo(self.view).offset(-(kRealValue(100) + SafeArea_Bottom));
//        } else {
//            make.bottom.equalTo(self.view).offset(-(kRealValue(100)));
//        }
    }];
    
//    [self.view addSubview:self.bottomView];
//    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.collectionView.mas_bottom);
//        make.left.and.right.and.bottom.equalTo(self.view);
//    }];
    
    [self requestData];
}

- (void)requestData {
    
    NSInteger userID = 0;
    if (self.isMineAlbum) {
        userID = [UserInfoManager sharedInstance].ID;
    } else {
        userID = self.ID;
    }
    
    [MineInterface getUserPhotoListByUserId:userID andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage, NSArray * _Nonnull picList) {
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            [self.imageArray removeAllObjects];
            [self.imageArray addObjectsFromArray:picList];
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark - **************** Event Response
- (void)addPicImage {
    [[YTSelectPictureHelper sharedHelper] showVideoPictureSelectActionSheetWithMaxPicCount:1 isNeedVideo:NO pictureCompleteBlock:^(NSArray * _Nonnull selectImageArray) {
        //上传图片
        [YTUploadHelper uploadImageArrayToQiniu:selectImageArray isSelectOriginalPhoto:NO progressHandler:^(NSString * _Nonnull progressShowValue, float percent) {
        } andComplete:^(NSMutableArray * _Nullable fileNameArray) {
            //刷新列表
            [MineInterface uploadPhotoByUrl:fileNameArray[0] andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage) {
                if (rspStatusAndMessage.code == kResponseSuccessCode) {
                    [self requestData];
                }
            }];
        }];
    } videoCompleteBlock:nil];
}

- (void)deleteImage:(UIImage *)image {
    [self.imageArray removeObject:image];
    [self.collectionView reloadData];
}

- (void)saveButtonClicked {
    
}

#pragma mark - **************** UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.isMineAlbum) {
        return self.imageArray.count + 1;
    } else {
        return self.imageArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YTMyAlbumCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.addImageBlock = ^{
        [self addPicImage];
    };
    
    if (self.imageArray.count) {
        cell.albumURL = indexPath.item <= self.imageArray.count - 1 ? self.imageArray[indexPath.item] : nil;
    } else {
        cell.albumURL = nil;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [YTAlbumScrollView showAlbumByDataArray:self.imageArray selectedIndex:indexPath.row];
}


#pragma mark - **************** Setter Getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[YTMyAlbumFlowLayout alloc] init]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[YTMyAlbumCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    return _collectionView;
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UILabel *tipsLabel = [UILabel labelWithName:@"请勿上传低俗照片，违规者将作封号处理" Font:kSystemFont14 textColor:kGrayTextColor textAlignment:NSTextAlignmentCenter];
        tipsLabel.frame = CGRectMake(0, 0, kScreenWidth, kRealValue(20));
        [_bottomView addSubview:tipsLabel];
        
        UIButton *saveButton = [UIButton buttonWithTitle:@"保存" taget:self action:@selector(saveButtonClicked) font:kSystemFont16 titleColor:[UIColor whiteColor]];
        saveButton.backgroundColor = kPurpleTextColor;
        saveButton.layer.cornerRadius = 5;
        saveButton.frame = CGRectMake(kRealValue(10), tipsLabel.maxY + kRealValue(10), kScreenWidth - kRealValue(20), kRealValue(40));
        [_bottomView addSubview:saveButton];
        
    }
    return _bottomView;
}

@end
