//
//  NSString+YCUtil.h
//  ychat
//
//  Created by 孙俊 on 2017/12/9.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YCUtil)

/**
 * 正则匹配手机号
 */
- (BOOL)checkTelNumber;

/**
 * 进行邮箱正则表达式判断
 */
- (BOOL)validateEmail;

/**
 *  字符串中不同字体大小的富文本
 */
- (NSMutableAttributedString *)stringByBigText:(NSString *)bigText font:(UIFont *)font color:(UIColor *)color;

/**
 *  字符串中不同颜色的富文本
 */
- (NSMutableAttributedString *)stringByColorText:(NSString *)text color:(UIColor *)color font:(UIFont *)font;

/**
 *  计算文本高度
 */
- (CGSize)sizeWithSpace:(CGFloat)lineSpace font:(UIFont*)font maxWidth:(CGFloat)maxWidth;

/**
 * 计算文本宽度
 */
- (CGFloat)calculateMaxWidthWithFont:(UIFont *)font;

/**
 *  元转为分 
 */
- (NSInteger)fenValue;

/**
 *  分转为元 保留2位小数
 */
- (NSString *)yuanValue;

/**
 *  替换字符串中间的字符为 ****
 */
- (NSString *)centerSecretStringValue;

/**
 把时间戳字符串转成特定的格式字符串
 @param formatterString 是要转的时间格式 例如：yyyy-MM-dd HH-mm
 */
- (NSString *)timeForSpeciallFormatter:(NSString *)formatterString;

/**
 *  价格string去掉小数点后面的0 如果后两位不是0保留后两位 后两位是0不保留
 */
+ (NSString *)cancelSpotZeroWith:(CGFloat)price;

/**是否是空的，全是空格也是空的*/
- (BOOL)isEmpty;

/**汉字转拼音*/
+ (NSString *)transformChinese:(NSString *)chinese;

/**是否包含表情*/
+ (BOOL)stringContainsEmoji:(NSString *)string;

@end
