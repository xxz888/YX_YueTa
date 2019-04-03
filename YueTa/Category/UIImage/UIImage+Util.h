//
//  UIImage+Util.h
//  ychat
//
//  Created by 孙俊 on 2017/12/3.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)

/**
 * @brief 生成一个frame大小color颜色的图片
 *
 * @param frame 图片frame
 * @param color 图片颜色
 * @return 生成的图片
 */
+ (UIImage *)imageWithFrame:(CGRect)frame color:(UIColor *)color;

/**
 * @brief 根据字符串 生成对应的二维码
 * @param string 需要生成二维码的字符串
 * @param size   宽高
 */
+ (void)createQRCodeImageForString:(NSString *)string
                              size:(CGFloat)size
                               ans:(void (^)(UIImage *image))ans;

/**
 * @brief 根据字符串 生成对应有logo的二维码
 * @param codeStr 需要生成二维码的字符串
 * @param image   中间的logo
 */
+ (void)createCoreImage:(NSString *)codeStr
            centerImage:(UIImage *)image
                    ans:(void (^)(UIImage *image))ans;

- (UIImage *)cornerImageWithSize:(CGSize)size cornerRadii:(CGSize)cornerRadii;

+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 position:(CGPoint)position;

+ (UIImage *)addTextToImage:(UIImage *)tImage text:(NSString *)text font:(CGFloat)font  position:(CGPoint)position;

- (NSData *)compressWithMaxLength:(NSUInteger)maxLength;

// ------这种方法对图片既进行压缩，又进行裁剪
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;

/**
 view视图 转 image图片
 
 @param view 视图
 @return image
 */
+ (UIImage*)convertViewToImage:(UIView*)view;





@end
