//
//  YTReportViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/30.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTReportViewController.h"

#import "YTCustomerServiceFlowLayout.h"
#import "YTCustomerServicePhoteCell.h"
#import "YTSelectPictureHelper.h"
#import "MineInterface.h"

@interface YTReportViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIImageView *reason1SelectImageView;
@property (nonatomic, strong) UIImageView *reason2SelectImageView;
@property (nonatomic, strong) UIImageView *reason3SelectImageView;
@property (nonatomic, copy) NSString *selectReason;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) YYTextView *textView;

@end

static NSString *reuseIdentifier = @"YTCustomerServicePhoteCell";

@implementation YTReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationBarTitle:@"举报"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" titleColor:kWhiteTextColor target:self action:@selector(submit)];
    
    _imageArray = [NSMutableArray array];

    //举报理由
    UILabel *reasonLabel = [UILabel labelWithName:@"   请选择举报该用户的理由" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    reasonLabel.frame = CGRectMake(0, 0, kScreenWidth, kRealValue(40));
    reasonLabel.backgroundColor = kSepLineGrayBackgroundColor;
    [self.view addSubview:reasonLabel];
    
    //理由1
    UILabel *reason1Label = [UILabel labelWithName:@"  频繁发布骚扰信息、广告等" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    reason1Label.frame = CGRectMake(0, reasonLabel.maxY, kScreenWidth, kRealValue(40));
    [self.view addSubview:reason1Label];
    
    UIImageView *reason1SelectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - kRealValue(26), reason1Label.y + kRealValue(5), kRealValue(16), kRealValue(16))];
    reason1SelectImageView.image = [UIImage imageNamed:@"ic_un_check"];
    [self.view addSubview:reason1SelectImageView];
    reason1SelectImageView.centerY = reason1Label.centerY;
    _reason1SelectImageView = reason1SelectImageView;
    
    UIButton *reason1Button = [[UIButton alloc] initWithFrame:reason1Label.frame];
    [reason1Button addTarget:self action:@selector(reason1ButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reason1Button];
    
    //理由2
    UILabel *reason2Label = [UILabel labelWithName:@"  存在欺诈骗行为" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    reason2Label.frame = CGRectMake(0, reason1Label.maxY, kScreenWidth, kRealValue(40));
    [self.view addSubview:reason2Label];
    
    UIImageView *reason2SelectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - kRealValue(26), reason2Label.y + kRealValue(5), kRealValue(16), kRealValue(16))];
    reason2SelectImageView.image = [UIImage imageNamed:@"ic_un_check"];
    reason2SelectImageView.centerY = reason2Label.centerY;
    [self.view addSubview:reason2SelectImageView];
    _reason2SelectImageView = reason2SelectImageView;
    
    UIButton *reason2Button = [[UIButton alloc] initWithFrame:reason2Label.frame];
    [reason2Button addTarget:self action:@selector(reason2ButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reason2Button];

    //理由3
    UILabel *reason3Label = [UILabel labelWithName:@"  发布不适当内容" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    reason3Label.frame = CGRectMake(0, reason2Label.maxY, kScreenWidth, kRealValue(40));
    [self.view addSubview:reason3Label];
    
    UIImageView *reason3SelectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - kRealValue(26), reason3Label.y + kRealValue(5), kRealValue(16), kRealValue(16))];
    reason3SelectImageView.image = [UIImage imageNamed:@"ic_un_check"];
    [self.view addSubview:reason3SelectImageView];
    reason3SelectImageView.centerY = reason3Label.centerY;
    _reason3SelectImageView = reason3SelectImageView;
    
    UIButton *reason3Button = [[UIButton alloc] initWithFrame:reason3Label.frame];
    [reason3Button addTarget:self action:@selector(reason3ButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reason3Button];

    //提供图片
    UILabel *reasonPicLabel = [UILabel labelWithName:@"   请提供相关图片，方便我们进一步核实" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    reasonPicLabel.frame = CGRectMake(0, reason3Label.maxY + kRealValue(10), kScreenWidth, kRealValue(40));
    reasonPicLabel.backgroundColor = kSepLineGrayBackgroundColor;
    [self.view addSubview:reasonPicLabel];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, reasonPicLabel.maxY + kRealValue(20), kScreenWidth, kRealValue(70)) collectionViewLayout:[[YTCustomerServiceFlowLayout alloc] init]];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[YTCustomerServicePhoteCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_collectionView];
    
    //补充选项
    UILabel *additionReasonLabel = [UILabel labelWithName:@"   补充选项（选填）" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    additionReasonLabel.frame = CGRectMake(0, _collectionView.maxY + kRealValue(20), kScreenWidth, kRealValue(40));
    additionReasonLabel.backgroundColor = kSepLineGrayBackgroundColor;
    [self.view addSubview:additionReasonLabel];
    
    _textView = [[YYTextView alloc] initWithFrame:CGRectMake(10, additionReasonLabel.maxY + kRealValue(10), kScreenWidth-20, kRealValue(100))];
    _textView.font = kSystemFont15;
    [self.view addSubview:_textView];
}

#pragma mark - **************** Event Response
- (void)reason1ButtonClick {
    self.reason1SelectImageView.image = [UIImage imageNamed:@"ic_check"];
    self.reason2SelectImageView.image = [UIImage imageNamed:@"ic_un_check"];
    self.reason3SelectImageView.image = [UIImage imageNamed:@"ic_un_check"];
    self.selectReason = @"频繁发布骚扰信息、广告等";
}

- (void)reason2ButtonClick {
    self.reason1SelectImageView.image = [UIImage imageNamed:@"ic_un_check"];
    self.reason2SelectImageView.image = [UIImage imageNamed:@"ic_check"];
    self.reason3SelectImageView.image = [UIImage imageNamed:@"ic_un_check"];
    self.selectReason = @"存在欺诈骗行为";

}

- (void)reason3ButtonClick {
    self.reason1SelectImageView.image = [UIImage imageNamed:@"ic_un_check"];
    self.reason2SelectImageView.image = [UIImage imageNamed:@"ic_un_check"];
    self.reason3SelectImageView.image = [UIImage imageNamed:@"ic_check"];
    self.selectReason = @"发布不适当内容";
}

- (void)submit {
    if (!self.selectReason.length) {
        [kAppWindow showAutoHideHudWithText:@"请选择举报原因"];
        return;
    }
    __block NSString *pic1 = @"0";
    __block NSString *pic2 = @"0";
    __block NSString *pic3 = @"0";
    __block NSString *pic4 = @"0";
    __block NSString *pic5 = @"0";
    __block NSString *desc = self.textView.text.length ? self.textView.text : @"0";
    
    [YTUploadHelper uploadImageArrayToQiniu:self.imageArray isSelectOriginalPhoto:NO progressHandler:^(NSString * _Nonnull progressShowValue, float percent) {
        
    } andComplete:^(NSMutableArray * _Nullable fileNameArray) {
        if (fileNameArray.count == self.imageArray.count) {
            if (fileNameArray.count > 0) {
                pic1 = fileNameArray[0];
            }
            if (fileNameArray.count > 1) {
                pic2 = fileNameArray[1];
            }
            if (fileNameArray.count > 2) {
                pic3 = fileNameArray[2];
            }
            if (fileNameArray.count > 3) {
                pic4 = fileNameArray[3];
            }
            if (fileNameArray.count > 4) {
                pic5 = fileNameArray[4];
            }
            [MineInterface reportUser:self.userId reason:self.selectReason pic1:pic1 pic2:pic2 pic3:pic3 pic4:pic4 pic5:pic5 describe:desc andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage) {
                if ([rspStatusAndMessage.message isEqualToString:@"操作成功"]) {
                    [UIViewController showAlertViewWithTitle:@"举报已成功提交，我们会尽快做处理，感谢您对平台的监督" message:nil confirmTitle:@"确定" confirmAction:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                }
            }];
        } else {
            [kAppWindow showAutoHideHudWithText:@"图片上传失败,请重试"];
        }
    }];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)addPicImage {
    [self.view endEditing:YES];
    
    if (self.imageArray.count >= 4) {
        return;
    }
    
    [[YTSelectPictureHelper sharedHelper] showVideoPictureSelectActionSheetWithMaxPicCount:4 - self.imageArray.count isNeedVideo:NO pictureCompleteBlock:^(NSArray * _Nonnull selectImageArray) {
        [self.imageArray addObjectsFromArray:selectImageArray];
        [self.collectionView reloadData];
    } videoCompleteBlock:^(UIImage * _Nonnull thumbnailImage, NSURL * _Nonnull inputURL) {
        
    }];
}

- (void)deleteImage:(UIImage *)image {
    [self.imageArray removeObject:image];
    [self.collectionView reloadData];
}

#pragma mark - **************** UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.imageArray.count < 5){
        return self.imageArray.count + 1;
    }
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YTCustomerServicePhoteCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
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



@end
