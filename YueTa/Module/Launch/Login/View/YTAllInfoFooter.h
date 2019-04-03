//
//  YTAllInfoFooter.h
//  YueTa
//
//  Created by 姚兜兜 on 2019/1/15.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YTAllInfoFooter : UIView

@property (nonatomic, strong) NSString *introduceStr;

@property (nonatomic, strong) NSString *wxStr;

@property (nonatomic, strong) NSString *phoneStr;

// 设置个人介绍的标签
- (void)setupTapLabelWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
