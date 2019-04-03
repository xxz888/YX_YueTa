//
//  YTSquareChildController.h
//  YueTa
//
//  Created by Awin on 2019/1/28.
//  Copyright © 2019年 姚兜兜. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, YTSquareVCType) {
    YTSquareVCReward = 0,       // 打赏
    YTSquareVCPleaseReward = 1, // 求打赏
};

@interface YTSquareChildController : BaseViewController

@property (nonatomic, assign) YTSquareVCType type;

- (void)reloadFiltrateData:(NSArray *)array;

@end
