//
//  YTUploadHelper.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/23.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTUploadHelper.h"
#import "MineInterface.h"

@implementation YTUploadHelper

//上传文件到七牛云
+ (void)uploadDataToQiniu:(NSData *)data withToken:(NSString *)token withKey:(NSString *)key progressHandler:(void(^)(NSString *key, float percent))progressBlock andComplete:(void(^)(QNResponseInfo *info, NSString *key, NSDictionary *resp)) completeBlock{
    
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        progressBlock(key,percent);
        //DLog(@"percent == %.2f", percent);
    }
                                                                 params:nil
                                                               checkCrc:NO
                                                     cancellationSignal:nil];
    
    
    
    [upManager putData:data key:key token:token
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  NSLog(@"info:%@\nkey:%@\nresp:%@",info,key,resp);
                  completeBlock(info,key,resp);
              } option:uploadOption];
}



//批量上传图片文件到七牛云
+ (void)uploadImageArrayToQiniu:(NSArray *)dataArray isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto progressHandler:(void (^)(NSString * _Nonnull, float))progressBlock andComplete:(void (^)(NSMutableArray * _Nullable))completeBlock {
    int arrayCount = 0;
    if (dataArray
        && [dataArray count]) {
        arrayCount = (int)[dataArray count];
        
        NSMutableArray *filenameArray = [[NSMutableArray alloc]  initWithCapacity:0];
        
        for (int i = 0; i < [dataArray count]; i++) {
            NSData *data = nil;
            NSObject *obj = [dataArray objectAtIndex:i];
            NSString *fileName = nil;
            if ([obj isKindOfClass:[UIImage class]]) {
                if (isSelectOriginalPhoto) {
                    data = UIImageJPEGRepresentation((UIImage *)obj,1);
                } else {
                    data = [NSData compressImageDataWithImage:(UIImage *)obj];
                }
                //用户id_image_时间戳.jpg  用户id_video_时间戳.mp4
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                fileName = [NSString stringWithFormat:@"%ld_image_%@.jpg",[UserInfoManager sharedInstance].ID,str];
            } else if ([obj isKindOfClass:[NSURL class]]) {
                data = [NSData dataWithContentsOfURL:(NSURL *)obj];
                //用户id_image_时间戳.jpg  用户id_video_时间戳.mp4
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                fileName = [NSString stringWithFormat:@"%ld_video_%@.mp4",[UserInfoManager sharedInstance].ID,str];
            }
            
            [MineInterface getQiniuUploadTokenByFileName:fileName andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage, NSString * _Nonnull uploadToken, NSString * _Nonnull url) {
                if(rspStatusAndMessage && rspStatusAndMessage.code == kResponseSuccessCode && uploadToken){
                    
                    [YTUploadHelper uploadDataToQiniu:data withToken:uploadToken withKey:fileName progressHandler:^(NSString *key, float percent) {
                        NSString *tips = [NSString stringWithFormat:@"(%i/%i) %i%%",i+1,arrayCount, (int)(percent*100)];
                        if (progressBlock) {
                            progressBlock(tips,percent);
                        }
                    } andComplete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                        if(info.statusCode == 200 && resp){
                            [filenameArray addObject:url];
                        }
                        if (i == arrayCount - 1) {
                            completeBlock(filenameArray);
                        }
                    }];
                } else {
                    completeBlock(nil);
                }
            }];
        }
    } else {
        completeBlock(nil);
    }
}

+ (void)uploadVideoToQiniu:(NSURL *)videoURL progressHandler:(void (^)(NSString * _Nonnull, float))progressBlock andComplete:(nonnull void (^)(NSMutableArray * _Nullable))completeBlock {
    if (!videoURL) {
        completeBlock(nil);
        return;
    }
    [self uploadImageArrayToQiniu:@[videoURL] isSelectOriginalPhoto:NO progressHandler:progressBlock andComplete:completeBlock];
}

@end
