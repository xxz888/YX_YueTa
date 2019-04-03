//
//  YTAppointmentContentViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/3.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTAppointmentContentViewController.h"

#define kSearchHistorySubViewHeight 30

@interface YTAppointmentContentViewController ()

@property (nonatomic, strong) NSMutableArray *contentLabelArray;
@property (nonatomic, strong) UILabel *selectedLabel;

@end

@implementation YTAppointmentContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *contentList = self.engagementArr;
    // 计算位置
    CGFloat leftSpace = 15.0f;  // 左右空隙
    CGFloat topSpace = 10.f; // 上下空隙
    CGFloat margin = 15.0f;  // 两边的间距
    CGFloat currentX = margin; // X
    CGFloat currentY = 0; // Y
    NSInteger countRow = 0; // 第几行数
    CGFloat lastLabelWidth = 0; // 记录上一个宽度
    
    for (int i = 0; i < contentList.count; i++) {
        // 最多显示10个
        if (i > 20) {
            break;
        }
        /** 计算Frame */
        CGFloat nowWidth = [self textWidth:contentList[i]];
        if (i == 0) {
            currentX = currentX + lastLabelWidth;
        }
        else {
            currentX = currentX + leftSpace + lastLabelWidth;
        }
        currentY = countRow * kSearchHistorySubViewHeight + (countRow + 1) * topSpace;
        // 换行
        if (currentX + leftSpace + margin + nowWidth >= kScreenWidth) {
            countRow++;
            currentY = currentY + kSearchHistorySubViewHeight + topSpace;
            currentX = margin;
        }
        lastLabelWidth = nowWidth;
        // 文字内容
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(currentX, currentY, nowWidth, kSearchHistorySubViewHeight)];
        /** Label 具体显示 */
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.text = contentList[i];
        contentLabel.layer.cornerRadius = 15;
        contentLabel.layer.borderWidth = 1;
        contentLabel.layer.borderColor = kSepLineGrayBackgroundColor.CGColor;
        contentLabel.font = [UIFont systemFontOfSize:17];
        contentLabel.textColor = kBlackTextColor;
        contentLabel.userInteractionEnabled = YES;
        contentLabel.layer.masksToBounds = YES;
        [contentLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidClick:)]];
        [self.view addSubview:contentLabel];
        [self.contentLabelArray addObject:contentLabel];
    }
}

- (void)setupRightBarButtonItem {
    if (self.navigationItem.rightBarButtonItem) {
        return;
    }
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" titleColor:[UIColor whiteColor] target:self action:@selector(rightBarItemClicked)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (CGFloat)textWidth:(NSString *)text {
    CGFloat width = [text boundingRectWithSize:CGSizeMake(kScreenWidth, kSearchHistorySubViewHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.width + 30;
    // 防止 宽度过大
    if (width > kScreenWidth - 40) {
        width = kScreenWidth - 40;
    }
    return width;
}

- (void)rightBarItemClicked {
    if (self.contentSelectedBlock) {
        self.contentSelectedBlock(self.selectedLabel.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tagDidClick:(UITapGestureRecognizer *)tapGesture {
    UILabel *clickLabel = (UILabel *)tapGesture.view;
    self.selectedLabel = clickLabel;
    
    for (UILabel *label in self.contentLabelArray) {
        if (label == clickLabel) {
            label.layer.borderWidth = 0;
            label.backgroundColor = kPurpleTextColor;
            label.textColor = kWhiteTextColor;
        } else {
            label.layer.borderWidth = 1;
            label.backgroundColor = kWhiteBackgroundColor;
            label.textColor = kBlackTextColor;
        }
    }
    
    [self setupRightBarButtonItem];
}

- (NSMutableArray *)contentLabelArray {
    if (!_contentLabelArray) {
        _contentLabelArray = [NSMutableArray array];
    }
    return _contentLabelArray;
}

@end
