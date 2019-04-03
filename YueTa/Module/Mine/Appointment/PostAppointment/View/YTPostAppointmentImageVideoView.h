//
//  YTPostAppointmentImageVideoView.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YTPostAppointmentImageVideoView : UIView

@property (nonatomic, strong, readonly) NSMutableArray *imageArray;
@property (nonatomic, assign, readonly) BOOL isSelectVideo;
@property (nonatomic, copy, readonly) NSURL *videoURL;

@end

NS_ASSUME_NONNULL_END
