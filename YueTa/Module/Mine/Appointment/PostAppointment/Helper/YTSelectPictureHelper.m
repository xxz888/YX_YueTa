//
//  YTSelectPictureHelper.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTSelectPictureHelper.h"
#import <TZImagePickerController.h>

@interface YTSelectPictureHelper ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, copy) PictureCompleteBlock pictureCompleteBlock;
@property (nonatomic, copy) VideoCompleteBlock videoCompleteBlock;

@end

@implementation YTSelectPictureHelper

+ (instancetype)sharedHelper {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)showVideoPictureSelectActionSheetWithMaxPicCount:(NSInteger)maxPicCount
                                             isNeedVideo:(BOOL)isNeedVideo
                                    pictureCompleteBlock:(PictureCompleteBlock)pictureCompleteBlock
                                      videoCompleteBlock:(VideoCompleteBlock)videoCompleteBlock {
    _pictureCompleteBlock = pictureCompleteBlock;
    _videoCompleteBlock = videoCompleteBlock;
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *video = [UIAlertAction actionWithTitle:@"拍视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie];//设定相机为视频
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
        imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;//设置相机后摄像头
        imagePicker.videoMaximumDuration = 10;//最长拍摄时间
        imagePicker.videoQuality = UIImagePickerControllerQualityTypeHigh;//拍摄质量
        imagePicker.allowsEditing = YES;//是否可编辑
        imagePicker.delegate = self;
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *photeLibrary = [UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:maxPicCount delegate:nil];
        imagePicker.allowPickingVideo = NO;
        
        [imagePicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            if (pictureCompleteBlock) {
                pictureCompleteBlock(photos);
            }
        }];
        
        [imagePicker setImagePickerControllerDidCancelHandle:^{

        }];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:camera];
    [ac addAction:photeLibrary];
    if (isNeedVideo) {
        [ac addAction:video];
    }
    [ac addAction:cancel];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {
        UIImage * image;
        // 判断，图片是否允许修改
        if ([picker allowsEditing]) {
            //获取用户编辑之后的图像
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            // 照片的元数据参数
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        if (self.pictureCompleteBlock
            &&image) {
            self.pictureCompleteBlock(@[image]);
        }
    } else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){//如果是录制视频
        NSLog(@"video...");
        NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];//视频路径
//        NSString * urlStr = [url path];
//        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
//            //保存视频到相簿，注意也可以使用ALAssetsLibrary来保存
//            UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
//        }
        UIImage *thumbnailImage = [self thumbnailImageForVideo:url atTime:1];
        if (self.videoCompleteBlock) {
            self.videoCompleteBlock(thumbnailImage, url);
        }
    }
    
    [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 自定义方法
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    } else {
        NSLog(@"视频保存成功");
    }
}

#pragma mark - 压缩视频
- (void)convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                         completeHandler:(nonnull void (^)(AVAssetExportSession * _Nullable))handler
{
    NSURL *outputURL = self.outputURL;
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    exportSession.outputURL = outputURL;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse = YES;
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
     {
         if (exportSession.status == AVAssetExportSessionStatusCompleted) {
                 NSLog(@"AVAssetExportSessionStatusCompleted");
                 NSLog(@"%@",[NSString stringWithFormat:@"%f s", [self getVideoLength:outputURL]]);
                 NSLog(@"%@", [NSString stringWithFormat:@"%.2f kb", [self getFileSize:[outputURL path]]]);
                 //UISaveVideoAtPathToSavedPhotosAlbum([outputURL path], self, nil, NULL);//这个是保存到手机相册
                 if (handler) {
                     handler(exportSession);
                 }
         } else {
             if (handler) {
                 handler(nil);
             }
         }
     }];
}

- (NSURL *)outputURL {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSURL *outputURL = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Library/Caches/output-%@.mp4", [formater stringFromDate:[NSDate date]]]] ;//这个是保存在app自己的沙盒路径里，后面可以选择是否在上传后删除掉。我建议删除掉，免得占空间。
    return outputURL;
}

- (void)removeVideoAtPath:(NSURL *)URL {
    [[NSFileManager defaultManager] removeItemAtPath:[URL path] error:nil];//取消之后就删除，以免占用手机硬盘空间（沙盒）
}

- (UIImage *)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode =AVAssetImageGeneratorApertureModeEncodedPixels;
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    if(!thumbnailImageRef){
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    }
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage:thumbnailImageRef] : nil;
    return thumbnailImage;
}

//此方法可以获取文件的大小，返回的是单位是KB。
- (CGFloat) getFileSize:(NSString *)path
{
    NSLog(@"%@",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }else{
        NSLog(@"找不到文件");
    }
    return filesize;
}

//此方法可以获取视频文件的时长。
- (CGFloat) getVideoLength:(NSURL *)URL
{
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:URL];
    CMTime time = [avUrl duration];
    int second = ceil(time.value/time.timescale);
    return second;
}

@end
