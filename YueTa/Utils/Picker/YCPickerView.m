//
//  YCPickerView.m
//  ychat
//
//  Created by mc on 2018/1/15.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "YCPickerView.h"

#define TOOLBAR_BUTTON_WIDTH kRealValue(60)
#define redBackgroundColor  [UIColor colorWithHexString:@"#E6534C"]

@implementation YCPickerView

- (instancetype)init {
    if (self = [super init]) {
        
        [self setView];
    }
    return self;
}

- (void)setView {
    
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    UIView *containView = [[UIView alloc] init];
    containView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kRealValue(210));
    [self addSubview:containView];
    self.containView = containView;
    
    UIView *toolBar = [[UIView alloc] init];
    toolBar.frame = CGRectMake(0, 0, kScreenWidth, kRealValue(50));
    toolBar.backgroundColor = kWhiteBackgroundColor;
    [containView addSubview:toolBar];
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, toolBar.bottom-0.5, kScreenWidth, 0.5);
    line.backgroundColor = kGrayBackgroundColor;
    [containView addSubview:line];
    
    UIButton *cancleButton = [UIButton buttonWithTitle:@"取消" taget:self action:@selector(buttonClick:) font:kSystemFont16 titleColor:kGrayTextColor];
    cancleButton.frame = CGRectMake(0, 0, TOOLBAR_BUTTON_WIDTH, toolBar.height);
    cancleButton.tag = YCTypePickerViewButtonTypeCancle;
    [toolBar addSubview:cancleButton];
    
    UIButton *sureButton = [UIButton buttonWithTitle:@"确定" taget:self action:@selector(buttonClick:) font:kSystemFont16 titleColor:kBlackTextColor];
    sureButton.frame = CGRectMake(toolBar.width - TOOLBAR_BUTTON_WIDTH, 0, TOOLBAR_BUTTON_WIDTH, toolBar.height);
    sureButton.tag = YCTypePickerViewButtonTypeSure;
    [toolBar addSubview:sureButton];
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.backgroundColor = kWhiteBackgroundColor;
    pickerView.frame = CGRectMake(0, toolBar.bottom, kScreenWidth, containView.height - toolBar.height);
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [containView addSubview:pickerView];
    self.pickerView = pickerView;
}

- (void)buttonClick:(UIButton *)sender {
    
}

- (void)showView {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        self.containView.bottom = kScreenHeight;
    }];
}

- (void)hideView {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.containView.y = kScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark -- UIPickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    return nil;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return kRealValue(40);
}

#pragma mark - lazy load
- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}

@end
