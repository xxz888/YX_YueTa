//
//  YTMineEntryView.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YTMineEntryType) {
    /** 基础资料 */
    YTMineEntryTypeBasicInfo,
    /** 我的钱包 */
    YTMineEntryTypeWallet,
    /** 商店 */
    YTMineEntryTypeStore,
    /** 认证中心 */
    YTMineEntryTypeCertificationCenter,
    /** 客服中心 */
    YTMineEntryTypeServiceCenter,
    /** 设置 */
    YTMineEntryTypeSetting,
    /** 黑名单 */
    YTMineEntryTypeBlackList,
    /** 关于我们 */
    YTMineEntryTypeAboutus,
};

typedef void(^EntryClickedBlock)(YTMineEntryType type);

@interface YTMineEntryView : UIView

@property (nonatomic, copy) EntryClickedBlock entryClickedBlock;

@end

NS_ASSUME_NONNULL_END
