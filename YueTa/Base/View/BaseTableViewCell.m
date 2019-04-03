//
//  BaseTableViewCell.m
//  CJYP
//
//  Created by 王吧 on 2018/5/4.
//  Copyright © 2018年 林森. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self loadContentViews];
        [self layoutContentViews];
    }
    return self;
}

/**
 更新视图
 */
- (void)updateConstraints {
    [self loadContentViews];
    [super updateConstraints];
}


/**
 加载内容子视图
 */
- (void)loadContentViews {
    
}

/**
 布局内容子视图
 */
- (void)layoutContentViews {
    
}

/**
 当前cell设置数据
 */
- (void)loadDataWithModel:(id)model withIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark -
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
