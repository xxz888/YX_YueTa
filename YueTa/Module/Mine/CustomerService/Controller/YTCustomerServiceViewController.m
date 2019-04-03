//
//  YTCustomerServiceViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/21.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTCustomerServiceViewController.h"
#import "YTCommonQuestionViewController.h"
#import "YTMyQuestionViewController.h"

#import "YTCustomerServiceFlowLayout.h"
#import "YTCustomerServicePhoteCell.h"
#import "YTSelectPictureHelper.h"
#import "MineInterface.h"

@interface YTCustomerServiceViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) YYTextView *textView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UIButton *myQuestionButton;
@property (nonatomic, strong) UIButton *commonQuestionButton;

@property (nonatomic, strong) NSMutableArray *imageArray;

@end

static NSString *reuseIdentifier = @"YTCustomerServicePhoteCell";

@implementation YTCustomerServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"客服中心"];
    _imageArray = [NSMutableArray array];
    
    _textView = [[YYTextView alloc] initWithFrame:CGRectMake(kRealValue(20), kRealValue(15), kScreenWidth - kRealValue(40), kRealValue(200))];
    _textView.backgroundColor = kMineGrayBackgroundColor;
    _textView.placeholderText = @"问题描述";
    _textView.placeholderFont = kSystemFont15;
    _textView.font = kSystemFont15;
    _textView.placeholderTextColor = kGrayTextColor;
    _textView.textColor = kBlackTextColor;
    [self.view addSubview:_textView];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _textView.maxY + kRealValue(30), kScreenWidth, kRealValue(70)) collectionViewLayout:[[YTCustomerServiceFlowLayout alloc] init]];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[YTCustomerServicePhoteCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_collectionView];
    
    _submitButton = [UIButton buttonWithTitle:@"提交" taget:self action:@selector(submitButtonClicked) font:kSystemFont15 titleColor:kBlackTextColor];
    _submitButton.frame = CGRectMake(kRealValue(30), _collectionView.maxY + kRealValue(20), kScreenWidth - kRealValue(40), kRealValue(45));
    _submitButton.backgroundColor = kMineGrayBackgroundColor;
    [self.view addSubview:_submitButton];
    
    _myQuestionButton = [UIButton buttonWithTitle:@"我的提问" taget:self action:@selector(myQuestionButtonClicked) font:kSystemFont13 titleColor:kGrayTextColor];
    _myQuestionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _myQuestionButton.frame = CGRectMake(_submitButton.x, _submitButton.maxY + kRealValue(20), kRealValue(80), kRealValue(20));
    [self.view addSubview:_myQuestionButton];

    _commonQuestionButton = [UIButton buttonWithTitle:@"常见问题" taget:self action:@selector(commonQuestionButtonClicked) font:kSystemFont13 titleColor:kGrayTextColor];
    _commonQuestionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _commonQuestionButton.frame = CGRectMake(_submitButton.maxX - kRealValue(80), _submitButton.maxY + kRealValue(20), kRealValue(80), kRealValue(20));
    [self.view addSubview:_commonQuestionButton];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - **************** Event Response
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

- (void)submitButtonClicked {
    NSLog(@"提交");
    
    if (!self.textView.text.length) {
        [kAppWindow showAutoHideHudWithText:@"请填写问题描述"];
        return;
    }
    
    [YTUploadHelper uploadImageArrayToQiniu:self.imageArray isSelectOriginalPhoto:NO progressHandler:^(NSString * _Nonnull progressShowValue, float percent) {
        
    } andComplete:^(NSMutableArray * _Nullable fileNameArray) {
        
        NSString *pic1 = @"0";
        NSString *pic2 = @"0";
        NSString *pic3 = @"0";
        if (fileNameArray.count > 0) {
            pic1 = fileNameArray[0];
        }
        if (fileNameArray.count > 1) {
            pic2 = fileNameArray[1];
        }
        if (fileNameArray.count > 2) {
            pic3 = fileNameArray[2];
        }
        [MineInterface submitProblem:self.textView.text pic1:pic1 pic2:pic2 pic3:pic3 andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage) {
            if ([rspStatusAndMessage.message isEqualToString:@"操作成功"]) {
                [UIViewController showAlertViewWithTitle:@"您的提问已经提交成功，我们会尽快处理您答复，感谢您对我们的支持" message:nil confirmTitle:@"确定" confirmAction:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
        }];
    }];
}

- (void)myQuestionButtonClicked {
    NSLog(@"我的问题");
    YTMyQuestionViewController *myQuestion = [[YTMyQuestionViewController alloc] init];
    [self.navigationController pushViewController:myQuestion animated:YES];
}

- (void)commonQuestionButtonClicked {
    NSLog(@"常见问题");
    YTCommonQuestionViewController *commonQuestion = [[YTCommonQuestionViewController alloc] init];
    [self.navigationController pushViewController:commonQuestion animated:YES];
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
