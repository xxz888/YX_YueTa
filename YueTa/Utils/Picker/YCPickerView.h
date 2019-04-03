//
//  YCPickerView.h
//  ychat
//
//  Created by mc on 2018/1/15.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YCTypePickerViewButtonType) {
    YCTypePickerViewButtonTypeCancle,
    YCTypePickerViewButtonTypeSure
};

@interface YCPickerView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>

/**容器view*/
@property (nonatomic, weak) UIView *containView;
/**选择器*/
@property(nonatomic, strong) UIPickerView * pickerView;
/**数据源*/
@property(nonatomic, strong) NSArray * dataSource;

- (void)showView;

- (void)hideView;

@end
