//
//  NSString+Category.h
//  CJYP
//
//  Created by 蓝海 on 2018/8/17.
//  Copyright © 2018年 林森. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)
//编码
+ (NSString *)encodeBase64String:(NSString *)text;

/**
 //解码Bse64
 */
+ (NSString *)deCodeBase64String:(NSString *)base64;

+ (CGSize)getStringSizeWithText:(NSString *)text size:(CGSize)size font:(UIFont*)font;


@end
