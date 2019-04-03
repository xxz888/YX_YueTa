//
//  YTImgAlignmentButton.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ImageViewAlignment){
    ImageViewAlignmentLeft = 0 ,
    ImageViewAlignmentTop = 1 ,
    ImageViewAlignmentRight = 2,
    ImageViewAlignmentBottom  = 3,
};

@interface YTImgAlignmentButton : UIButton

//文字图片间距
@property (nonatomic, assign) CGFloat intervalImgToTitle;
@property (nonatomic, assign) ImageViewAlignment imageViewAlignment;
//二次布局
@property (nonatomic, copy) void(^blockLayoutSubViews)(void);

@end

NS_ASSUME_NONNULL_END
