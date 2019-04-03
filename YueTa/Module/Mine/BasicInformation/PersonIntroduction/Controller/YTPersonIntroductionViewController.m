//
//  YTPersonIntroductionViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/10.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTPersonIntroductionViewController.h"

#define kLabelH kRealValue(30)

@interface YTPersonIntroductionViewController ()

@property (nonatomic, strong) YYTextView *textView;

@end

@implementation YTPersonIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"个人介绍"];
    [self setupRightBarButtonItem];
    [self setupSubViews];
}

- (void)setupRightBarButtonItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" titleColor:[UIColor whiteColor] target:self action:@selector(rightBarButtonItemClicked)];
}

- (void)setupSubViews {
    YYTextView *textView = [[YYTextView alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(15), kScreenWidth - kRealValue(30), kRealValue(300))];
    textView.layer.cornerRadius = 8;
    textView.layer.borderWidth = 1;
    textView.layer.borderColor = kGrayBorderColor.CGColor;
    textView.contentInset = UIEdgeInsetsMake(kRealValue(5), kRealValue(5), kRealValue(5), -kRealValue(5));
    textView.font = kSystemFont15;
    textView.textColor = kBlackTextColor;
    textView.placeholderFont = kSystemFont15;
    textView.placeholderTextColor = kGrayTextColor;
    textView.placeholderText = @"这个人很懒，什么都没留下";
    [self.view addSubview:textView];
    _textView = textView;
    
    NSArray *contentList = self.personalaArr;
    
    // 计算位置
    CGFloat leftSpace = kRealValue(15);  // 左右空隙
    CGFloat topSpace = kRealValue(10); // 上下空隙
    CGFloat margin = kRealValue(15);  // 两边的间距
    CGFloat currentX = margin; // X
    CGFloat currentY = textView.maxY + kRealValue(15); // Y
    NSInteger countRow = 0; // 第几行数
    CGFloat lastLabelWidth = 0; // 记录上一个宽度
    
    for (int i = 0; i < contentList.count; i++) {
        // 最多显示20个
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
//        currentY = countRow * kLabelH + (countRow + 1) * topSpace;
        // 换行
        if (currentX + leftSpace + margin + nowWidth >= kScreenWidth) {
            countRow++;
            currentY = currentY + kLabelH + topSpace;
            currentX = margin;
        }
        lastLabelWidth = nowWidth;
        // 文字内容
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(currentX, currentY, nowWidth, kLabelH)];
        /** Label 具体显示 */
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.text = contentList[i];
        contentLabel.layer.cornerRadius = 12;
        contentLabel.font = kSystemFont15;
        contentLabel.textColor = kWhiteTextColor;
        contentLabel.backgroundColor = kPurpleTextColor;
        contentLabel.userInteractionEnabled = YES;
        contentLabel.layer.masksToBounds = YES;
        [contentLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidClick:)]];
        [self.view addSubview:contentLabel];
    }
}

- (CGFloat)textWidth:(NSString *)text {
    CGFloat width = [text boundingRectWithSize:CGSizeMake(kScreenWidth, kLabelH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kSystemFont15} context:nil].size.width + 30;
    // 防止 宽度过大
    if (width > kScreenWidth - kRealValue(30)) {
        width = kScreenWidth - kRealValue(30);
    }
    return width;
}

- (void)rightBarButtonItemClicked {
    if (!self.textView.text.length) {
        [kAppWindow showAutoHideHudWithText:@"请选择个人标签"];
        return;
    }
    if (self.personIntroductionSaveBlock) {
        self.personIntroductionSaveBlock(self.textView.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tagDidClick:(UITapGestureRecognizer *)tapGesture {
    UILabel *clickLabel = (UILabel *)tapGesture.view;
    self.textView.text = [self.textView.text stringByAppendingString:clickLabel.text];
}

@end
