//
//  YTAboutusViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/29.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTAboutusViewController.h"
#import "MineInterface.h"

@interface YTAboutusViewController ()

@end

@implementation YTAboutusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"关于我们"];
    
    [MineInterface getAboutusDetailAndBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage, NSString * _Nonnull describe, NSString * _Nonnull pic) {
        
        if (rspStatusAndMessage.code == kResponseSuccessCode
            && pic
            && describe) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.backgroundColor = kGrayBackgroundColor;
            imageView.layer.cornerRadius = kRealValue(25);
            imageView.layer.masksToBounds = YES;
            [self.view addSubview:imageView];
            imageView.frame = CGRectMake(kScreenWidth/2 - kRealValue(25), kRealValue(30), kRealValue(50), kRealValue(50));
            [imageView sd_setImageWithURL:[NSURL URLWithString:pic]];
            
            UILabel *label = [UILabel labelWithName:describe Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentCenter];
            label.frame = CGRectMake(kRealValue(15), imageView.maxY + kRealValue(20), kScreenWidth - kRealValue(30), 0);
            [label sizeToFit];
            [self.view addSubview:label];
        }
    }];
}

@end
