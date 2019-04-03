//
//  YTSelectPictureHelper.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PictureCompleteBlock)(NSArray *selectImageArray);
typedef void(^VideoCompleteBlock)(UIImage *thumbnailImage, NSURL *inputURL);

@interface YTSelectPictureHelper : NSObject

/**
 * @brief 弹出选图拍照拍视频的actionSheet
 *
 * @param maxPicCount 最大选择张数
 * @param pictureCompleteBlock 和videoCompleteBlock只会一次回调一个
 */
- (void)showVideoPictureSelectActionSheetWithMaxPicCount:(NSInteger)maxPicCount
                                             isNeedVideo:(BOOL)isNeedVideo
                                    pictureCompleteBlock:(PictureCompleteBlock _Nullable)pictureCompleteBlock
                                      videoCompleteBlock:(VideoCompleteBlock _Nullable)videoCompleteBlock;

/** 压缩视频 */
- (void)convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                        completeHandler:(void (^)(AVAssetExportSession * _Nullable session))handler;

/** 上传视频成功后删除本地目录的视频 */
- (void)removeVideoAtPath:(NSURL *)URL;

/** 压缩目标文件夹 */
- (NSURL *)outputURL;

+ (instancetype)sharedHelper;

@end

NS_ASSUME_NONNULL_END
