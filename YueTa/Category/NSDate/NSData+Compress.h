//
//  NSData+Compress.h
//  ychat
//
//  Created by 孙俊 on 2017/12/3.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Compress)

/**
 * @brief 图片压缩处理
 * @param sourceImage 原图片
 */
+ (NSData *)compressImageDataWithImage:(UIImage *)sourceImage;

@end
