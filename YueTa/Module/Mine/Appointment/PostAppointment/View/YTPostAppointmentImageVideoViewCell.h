//
//  YTPostAppointmentImageVideoViewCell.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddImageBlock)(void);
typedef void(^DeleteImageBlock)(UIImage *image);

@interface YTPostAppointmentImageVideoViewCell : UICollectionViewCell

@property (nonatomic, copy) AddImageBlock addImageBlock;
@property (nonatomic, copy) DeleteImageBlock deleteImageBlock;

@property (nonatomic, strong, nullable) UIImage *image;

@end

NS_ASSUME_NONNULL_END
