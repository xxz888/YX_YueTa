//
//  YTCustomerServiceDetailViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/29.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTCustomerServiceDetailViewController.h"

@interface YTCustomerServiceDetailViewController ()

@end

@implementation YTCustomerServiceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"问题详细"];
    
    UILabel *quesLabel = [UILabel labelWithName:[NSString stringWithFormat:@"\n问:%@\n",self.model.problem] Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:quesLabel];
    quesLabel.numberOfLines = 0;
    quesLabel.backgroundColor = kSepLineGrayBackgroundColor;
    [quesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kRealValue(10));
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.right.equalTo(self.view).offset(-kRealValue(15));
    }];
    
    UIView *backView1 = [[UIView alloc] init];
    backView1.backgroundColor = kSepLineGrayBackgroundColor;
    [self.view insertSubview:backView1 atIndex:0];
    [backView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.and.bottom.equalTo(quesLabel);
    }];
    
    UIImageView *imageView1 = [[UIImageView alloc] init];
    [self.view addSubview:imageView1];
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(quesLabel.mas_bottom).offset(kRealValue(10));
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.width.and.height.equalTo(@kRealValue(75));
    }];
    if (self.model.pic1) {
        [imageView1 sd_setImageWithURL:[NSURL URLWithString:self.model.pic1]];
    }
    
    UIImageView *imageView2 = [[UIImageView alloc] init];
    [self.view addSubview:imageView2];
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(quesLabel.mas_bottom).offset(kRealValue(10));
        make.left.equalTo(imageView1.mas_right).offset(kRealValue(15));
        make.width.and.height.equalTo(@kRealValue(75));
    }];
    if (self.model.pic2) {
        [imageView2 sd_setImageWithURL:[NSURL URLWithString:self.model.pic2]];
    }
    
    UIImageView *imageView3 = [[UIImageView alloc] init];
    [self.view addSubview:imageView3];
    [imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(quesLabel.mas_bottom).offset(kRealValue(10));
        make.left.equalTo(imageView2.mas_right).offset(kRealValue(15));
        make.width.and.height.equalTo(@kRealValue(75));
    }];
    if (self.model.pic3) {
        [imageView3 sd_setImageWithURL:[NSURL URLWithString:self.model.pic3]];
    }
    
    UILabel *answerLabel = [UILabel labelWithName:[NSString stringWithFormat:@"\n答:%@\n",self.model.answer.length?self.model.answer:@""] Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:answerLabel];
    answerLabel.numberOfLines = 0;
    answerLabel.backgroundColor = kSepLineGrayBackgroundColor;
    [answerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView1.mas_bottom).offset(kRealValue(10));
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.right.equalTo(self.view).offset(-kRealValue(15));
    }];
    
    UIView *backView2 = [[UIView alloc] init];
    backView2.backgroundColor = kSepLineGrayBackgroundColor;
    [self.view insertSubview:backView2 atIndex:0];
    [backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.and.bottom.equalTo(answerLabel);
    }];

}

@end
