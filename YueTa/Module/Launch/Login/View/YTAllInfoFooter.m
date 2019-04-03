//
//  YTAllInfoFooter.m
//  YueTa
//
//  Created by 姚兜兜 on 2019/1/15.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTAllInfoFooter.h"
#import "MZYTextField+LoginUtils.h"

@interface YTAllInfoFooter ()<UITextFieldDelegate>

@property (nonatomic, strong) NSArray *textArray;

@property (nonatomic, strong) UIView *grayBar;

@property (nonatomic, strong) UILabel *contactLab;
@property (nonatomic, strong) UILabel *contactTips;
@property (nonatomic, strong) MZYTextField *wxField;
@property (nonatomic, strong) MZYTextField *phoneField;

@property (nonatomic, strong) UILabel *introduceLab;
@property (nonatomic, strong) UILabel *introduceTips;
@property (nonatomic, strong) UITextView *introduceText;

@property (nonatomic, strong) UIView *labelView;//个人介绍标签父视图

@end

@implementation YTAllInfoFooter

- (instancetype)init {
    if (self = [super init]) {
        
        self.textArray = [NSArray array];
        
        [self createContentView];
        
        self.frame = CGRectMake(0, 0, kScreenHeight, self.labelView.bottom+kRealValue(10));
    }
    return self;
}

- (void)createContentView {
    
    CGFloat fieldW = kScreenWidth - kRealValue(10)*3-kRealValue(70);
    
    self.grayBar.frame = CGRectMake(0, 0, kScreenWidth, kRealValue(8));
    [self addSubview:self.grayBar];
    
    self.contactLab.frame = CGRectMake(kRealValue(10), _grayBar.bottom+kRealValue(10), kRealValue(70), kRealValue(20));
    [self addSubview:self.contactLab];
    
    self.contactTips.frame = CGRectMake(_contactLab.right, _grayBar.bottom+kRealValue(10), kRealValue(70), kRealValue(20));
    [self addSubview:self.contactTips];
    
    self.wxField = [MZYTextField MZYTextFieldInitWithFrame:CGRectMake(_contactTips.x, _contactLab.bottom+kRealValue(10), fieldW, kRealValue(35)) imageString:@"" placeholder:@"微信"];
    self.wxField.layer.masksToBounds = YES;
    self.wxField.layer.cornerRadius = self.wxField.height/2;
    self.wxField.delegate = self;
    self.wxField.backgroundColor = kGrayBackgroundColor;
    [self addSubview:_wxField];
    
    self.phoneField = [MZYTextField MZYTextFieldInitWithFrame:CGRectMake(_contactTips.x, _wxField.bottom+kRealValue(10), fieldW, kRealValue(35)) imageString:@"" placeholder:@"手机号"];
    self.phoneField.layer.masksToBounds = YES;
    self.phoneField.layer.cornerRadius = self.phoneField.height/2;
    self.phoneField.delegate = self;
    self.phoneField.backgroundColor = kGrayBackgroundColor;
    [self addSubview:_phoneField];
    
    self.introduceLab.frame = CGRectMake(kRealValue(10), self.phoneField.bottom+kRealValue(15), kRealValue(70), kRealValue(20));
    [self addSubview:self.introduceLab];
    
    self.introduceTips.frame = CGRectMake(_contactLab.right+kRealValue(10), self.introduceLab.top, kRealValue(160), kRealValue(20));
    [self addSubview:self.introduceTips];
    
    self.introduceText.frame = CGRectMake(_contactLab.right, _introduceTips.bottom+kRealValue(10), fieldW, kRealValue(160));
    [self addSubview:self.introduceText];
    
    self.labelView.frame = CGRectMake(_contactLab.right, _introduceText.bottom+kRealValue(10), fieldW, kRealValue(100));
    [self addSubview:self.labelView];
    
}

- (void)setupTapLabelWithArray:(NSArray *)array {

    self.textArray = array;
    
    UIButton *lastBtn;
    for (int i = 0; i < array.count; i++) {
        
        NSString *titleText = array[i];
        CGFloat btnW = self.labelView.width/3-kRealValue(10)*2;
        
        UIButton *button = [UIButton buttonWithTitle:titleText taget:self action:@selector(tagButtonClick:) font:kSystemFont12 titleColor:kBlackTextColor];
        [button setTitleColor:kWhiteTextColor forState:UIControlStateSelected];
        [button setBackgroundImage:KimageName(@"layer_background.jpg") forState:UIControlStateSelected];
        button.frame = CGRectMake((btnW+kRealValue(10))*(i%3), i/3*(kRealValue(30)+kRealValue(10)), btnW, kRealValue(30));
        button.layer.cornerRadius = button.height/2;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1.f;
        button.layer.borderColor = kGrayBorderColor.CGColor;
        button.tag = i;
        [self.labelView addSubview:button];
        
        if (i == array.count-1) {
            lastBtn = button;
        }
    }
    
    self.labelView.height = lastBtn.bottom;
    self.height = self.labelView.bottom+kRealValue(10);
}

#pragma mark - events
- (void)tagButtonClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    NSString *str = self.textArray[sender.tag];
    if (sender.selected == YES) {
        if (!self.introduceStr.length) {
            self.introduceStr = [NSString stringWithFormat:@"%@",str];
        } else {
            self.introduceStr = [NSString stringWithFormat:@"%@、%@",self.introduceStr,str];
        }
    } else {
        NSRange range = [self.introduceStr rangeOfString:str];
        if (range.location >= 1 && [[self.introduceStr substringWithRange:NSMakeRange(range.location-1, 1)] isEqualToString:@"、"]) {
            range.location --;
            range.length ++;
        }
        self.introduceStr = [self.introduceStr stringByReplacingOccurrencesOfString:[self.introduceStr substringWithRange:range] withString:@""];
    }
    self.introduceText.text = self.introduceStr;
}

#pragma mark - get
- (NSString *)wxStr {
    _wxStr = self.wxField.text;
    return _wxStr;
}

- (NSString *)phoneStr {
    _phoneStr = self.phoneField.text;
    return _phoneStr;
}

#pragma mark - lazy init
- (UIView *)grayBar {
    if (!_grayBar) {
        _grayBar = [[UIView alloc] init];
        _grayBar.backgroundColor = kGrayBackgroundColor;
    }
    return _grayBar;
}

- (UILabel *)contactLab {
    if (!_contactLab) {
        _contactLab = [UILabel labelWithName:@"联系方式" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _contactLab;
}

- (UILabel *)contactTips {
    if (!_contactTips) {
        _contactTips = [UILabel labelWithName:@"至少填写1种" Font:kSystemFont12 textColor:kGrayTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _contactTips;
}

- (UILabel *)introduceLab {
    if (!_introduceLab) {
        _introduceLab = [UILabel labelWithName:@"个人介绍" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _introduceLab;
}

- (UILabel *)introduceTips {
    if (!_introduceTips) {
        _introduceTips = [UILabel labelWithName:@"填写个性介绍或选择对应标签" Font:kSystemFont12 textColor:kGrayTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _introduceTips;
}

- (UITextView *)introduceText {
    if (!_introduceText) {
        _introduceText = [[UITextView alloc] init];
        _introduceText.backgroundColor = kGrayBackgroundColor;
        _introduceText.layer.cornerRadius = kRealValue(10);
        _introduceText.layer.masksToBounds = YES;
        _introduceText.font = kSystemFont14;
        _introduceText.editable = NO;
    }
    return _introduceText;
}

- (UIView *)labelView {
    if (!_labelView) {
        _labelView = [[UIView alloc] init];
    }
    return _labelView;
}

- (NSString *)introduceStr {
    if (!_introduceStr) {
        _introduceStr = [NSString string];
    }
    return _introduceStr;
}

@end
