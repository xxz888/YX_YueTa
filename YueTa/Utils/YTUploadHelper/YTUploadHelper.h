//
//  YTUploadHelper.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/23.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QiniuSDK.h>
NS_ASSUME_NONNULL_BEGIN

@interface YTUploadHelper : NSObject

//批量上传图片文件到七牛云
+ (void)uploadImageArrayToQiniu:(NSArray *)dataArray isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto progressHandler:(void(^)(NSString *progressShowValue, float percent))progressBlock andComplete:(void(^)(NSMutableArray * _Nullable fileNameArray)) completeBlock;


//上传视频到七牛云
+ (void)uploadVideoToQiniu:(NSURL *)videoURL progressHandler:(void(^)(NSString *progressShowValue, float percent))progressBlock andComplete:(void(^)(NSMutableArray * _Nullable fileNameArray)) completeBlock;

@end

NS_ASSUME_NONNULL_END
