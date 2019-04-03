//
//  YTUserInfoHeader.h
//  YueTa
//
//  Created by Awin on 2019/1/30.
//  Copyright © 2019年 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YTUserInfoHeaderBlock)(UIButton *button);

@interface YTUserInfoHeader : UIView

@property (nonatomic, copy) YTUserInfoHeaderBlock block;

- (void)loadDataWithModel:(id)model;

@end
