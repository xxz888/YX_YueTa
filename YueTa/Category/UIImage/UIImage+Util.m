//
//  UIImage+Util.m
//  ychat
//
//  Created by 孙俊 on 2017/12/3.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import "UIImage+Util.h"

@implementation UIImage (Util)

- (UIImage *)cornerImageWithSize:(CGSize)size cornerRadii:(CGSize)cornerRadii {
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:cornerRadii];
    [path addClip];
    [[UIColor clearColor] setFill];
    [self drawInRect:rect];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

+ (UIImage *)imageWithFrame:(CGRect)frame color:(UIColor *)color
{
    frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (void)createQRCodeImageForString:(NSString *)string size:(CGFloat)size ans:(void (^)(UIImage *))ans {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
        CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        [qrFilter setValue:stringData forKey:@"inputMessage"];
        [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
        CIImage *image = qrFilter.outputImage;
        
        CGRect extent = CGRectIntegral(image.extent);
        CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
        
        size_t width = CGRectGetWidth(extent) * scale;
        size_t height = CGRectGetHeight(extent) * scale;
        
        CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
        CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
        CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
        CGContextScaleCTM(bitmapRef, scale, scale);
        CGContextDrawImage(bitmapRef, extent, bitmapImage);
        
        CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
        CGContextRelease(bitmapRef);
        CGImageRelease(bitmapImage);
        
        UIImage *ansImage = [UIImage imageWithCGImage:scaledImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            ans(ansImage);
        });
    });
}

+ (void)createCoreImage:(NSString *)codeStr centerImage:(UIImage *)image ans:(void (^)(UIImage *))ans{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //1.生成coreImage框架中的滤镜来生产二维码
        CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        [filter setDefaults];
        
        [filter setValue:[codeStr dataUsingEncoding:NSUTF8StringEncoding] forKey:@"inputMessage"];
        //4.获取生成的图片
        CIImage *ciImg=filter.outputImage;
        //放大ciImg,默认生产的图片很小
        
        //5.设置二维码的前景色和背景颜色
        CIFilter *colorFilter=[CIFilter filterWithName:@"CIFalseColor"];
        //5.1设置默认值
        [colorFilter setDefaults];
        [colorFilter setValue:ciImg forKey:@"inputImage"];
        [colorFilter setValue:[CIColor colorWithRed:0 green:0 blue:0] forKey:@"inputColor0"];
        [colorFilter setValue:[CIColor colorWithRed:1 green:1 blue:1] forKey:@"inputColor1"];
        //5.3获取生存的图片
        ciImg=colorFilter.outputImage;
        
        CGAffineTransform scale = CGAffineTransformMakeScale(10, 10);
        ciImg = [ciImg imageByApplyingTransform:scale];
        
        //6.在中心增加一张图片
        UIImage *img=[UIImage imageWithCIImage:ciImg];
        //7.生存图片
        //7.1开启图形上下文
        UIGraphicsBeginImageContext(img.size);
        //7.2将二维码的图片画入
        //BSXPCMessage received error for message: Connection interrupted   why??
        //    [img drawInRect:CGRectMake(10, 10, img.size.width-20, img.size.height-20)];
        [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
        //7.3在中心划入其他图片
        CGFloat centerW = 70;
        CGFloat centerH = 70;
        CGFloat centerX=(img.size.width-70)*0.5;
        CGFloat centerY=(img.size.height -70)*0.5;
        
        UIImage * resultImage = [image cornerImageWithSize:CGSizeMake(70, 70) cornerRadii:CGSizeMake(10, 10)];
        [resultImage drawInRect:CGRectMake(centerX, centerY, centerW, centerH)];
        
        //7.4获取绘制好的图片
        UIImage *finalImg=UIGraphicsGetImageFromCurrentImageContext();
        
        //7.5关闭图像上下文
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            ans(finalImg);
        });
    });
}


+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 position:(CGPoint)position {
    if (position.y + image1.size.height >= image2.size.height) {
        UIGraphicsBeginImageContext(CGSizeMake(image2.size.width, position.y + image1.size.height));
    }else{
        UIGraphicsBeginImageContext(CGSizeMake(image2.size.width, image2.size.height));
    }
    // Draw image2
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    // Draw image1
    [image1 drawInRect:CGRectMake(position.x, position.y, image1.size.width, image1.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

+ (UIImage *)addTextToImage:(UIImage *)tImage text:(NSString *)text font:(CGFloat)font position:(CGPoint)position {
    /*
     可能你在添加文字水印之后，显示文字字体并不是你设置的字体大小，这是因为画布的size是图片的size，
     绘制后的图片被添加到ImageView上时可能被压缩或者放大，文字也就会发生变化。
     */
    NSString* mark = text;
    
    float fontSize = font * [UIScreen mainScreen].scale;
    //开启图形上下文
    
    CGSize scaleSize = CGSizeMake(tImage.size.width * [UIScreen mainScreen].scale, tImage.size.height*[UIScreen mainScreen].scale);
    
    UIGraphicsBeginImageContextWithOptions(scaleSize, NO, 0);
    
    NSDictionary *attr = @{
                           NSFontAttributeName: [UIFont systemFontOfSize:fontSize],  //设置字体
                           
                           NSForegroundColorAttributeName : [UIColor whiteColor]   //设置字体颜色
                           };
    
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, fontSize) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attr context:nil].size;
    
    //绘制图片
    [tImage drawInRect:CGRectMake(0, 0, scaleSize.width, scaleSize.height)];
    //绘制文字
    [mark drawInRect:CGRectMake(scaleSize.width/2 - textSize.width/2, position.y, textSize.width, fontSize + 5) withAttributes:attr];
    
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return aimg;
}

- (NSData *)compressWithMaxLength:(NSUInteger)maxLength {
    
//    CGSize size = CGSizeMake(40, 40);
//    UIGraphicsBeginImageContext(size);
//    [self drawInRect:CGRectMake(0, 0, 40, 40)];
//    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    maxLength *= 1024;
    
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        //NSLog(@"Compression = %.1f", compression);
        //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    if (data.length < maxLength) return data;
    UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        //NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
    }
    NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    return data;
}

+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
//    maxLength = maxLength * 1024;
//    // Compress by quality
//    CGFloat compression = 1;
//    NSData *data = UIImageJPEGRepresentation(image, compression);
//    if (data.length < maxLength) return image;
//
//    CGFloat max = 1;
//    CGFloat min = 0;
//    for (int i = 0; i < 6; ++i) {
//        compression = (max + min) / 2;
//        data = UIImageJPEGRepresentation(image, compression);
//        if (data.length < maxLength * 0.9) {
//            min = compression;
//        } else if (data.length > maxLength) {
//            max = compression;
//        } else {
//            break;
//        }
//    }
//    UIImage *resultImage = [UIImage imageWithData:data];
//    if (data.length < maxLength) return resultImage;
//
//    // Compress by size
//    NSUInteger lastDataLength = 0;
//    while (data.length > maxLength && data.length != lastDataLength) {
//        lastDataLength = data.length;
//        CGFloat ratio = (CGFloat)maxLength / data.length;
//        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
//                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
//        UIGraphicsBeginImageContext(size);
//        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
//        resultImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        data = UIImageJPEGRepresentation(resultImage, compression);
//    }
//
//    return resultImage;
    
    maxLength = maxLength * 1024;
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}


+ (UIImage*)convertViewToImage:(UIView*)view {
    CGSize s = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
