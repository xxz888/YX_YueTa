//
//  YTSquareListCell.h
//  YueTa
//
//  Created by Awin on 2019/1/29.
//  Copyright © 2019年 姚兜兜. All rights reserved.
//

#import "BaseTableViewCell.h"

#define squareListCellH kRealValue(240)

typedef void(^YTSquareListCellBlock)(NSInteger row);

@interface YTSquareListCell : BaseTableViewCell

@property (nonatomic, copy) YTSquareListCellBlock block;

@end
