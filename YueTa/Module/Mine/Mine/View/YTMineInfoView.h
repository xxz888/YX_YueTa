//
//  YTMineInfoView.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTImgAlignmentButton.h"
#import "YTUserModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YTMineInfoType) {
    /** 发布约会 */
    YTMineInfoTypePost = 0,
    /** 我发布的 */
    YTMineInfoTypeMyPost,
    /** 我报名的 */
    YTMineInfoTypeMyRegistration,
    /** 我的约会 */
    YTMineInfoTypeMyDate
};

typedef void(^AvartarClickedBlock)(void);
typedef void(^InfoClickedBlock)(YTMineInfoType type);
typedef void(^ShareClickedBlock)(void);
typedef void(^MyfansClickedBlock)(void);
typedef void(^MyfocusClickedBlock)(void);

@interface YTMineInfoView : UIView

@property (nonatomic, copy) AvartarClickedBlock avartarClickedBlock;
@property (nonatomic, copy) InfoClickedBlock infoClickedBlock;
@property (nonatomic, copy) ShareClickedBlock shareClickedBlock;
@property (nonatomic, copy) MyfansClickedBlock myfansClickedBlock;
@property (nonatomic, copy) MyfocusClickedBlock myfocusClickedBlock;

@property (nonatomic, strong) YTUserModel *userModel;
@property (nonatomic, copy) NSString *fansNumber;
@property (nonatomic, copy) NSString *likedNumber;

@end

NS_ASSUME_NONNULL_END
