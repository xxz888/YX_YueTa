//
//  BaseTableViewCell.h
//  CJYP
//
//  Created by 王吧 on 2018/5/4.
//  Copyright © 2018年 林森. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell


/**
 加载内容子视图
 */
- (void)loadContentViews;

/**
 布局内容子视图
 */
- (void)layoutContentViews;

/**
 当前cell设置数据
 
 @param model 数据模型
 @param indexPath 坐标（section，row）
 */
- (void)loadDataWithModel:(id)model withIndexPath:(NSIndexPath *)indexPath;

@end
