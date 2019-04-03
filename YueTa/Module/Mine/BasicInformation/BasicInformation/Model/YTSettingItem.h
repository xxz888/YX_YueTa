//
//  YTSettingItem.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/7.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YTSettingItemType) {
    //系统风格的各种cell类型                       //↓↓↓↓↓样式如下↓↓↓↓↓
    YTSettingItemTypeDefault,                  //文字         >
    YTSettingItemTypeAccessnoryTitle,          //文字       文字>
    YTSettingItemTypeLeftRightTitle,           //文字       文字
    YTSettingItemTypeAvartar,                  //文字       头像>
};

@interface YTSettingItem : BaseModel

/** Item类型 */
@property (nonatomic, assign) YTSettingItemType cellType;

@property (nonatomic, copy) NSString *cellID;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/** 主标题 */
@property (nonatomic, copy) NSString *leftTitle;

/** 右侧标题 */
@property (nonatomic, copy) NSString *rightTitle;

/** 头像 */
@property (nonatomic, copy) NSString *avatarURL;

@end

NS_ASSUME_NONNULL_END
