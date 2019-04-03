//
//  NSString+YCUtil.m
//  ychat
//
//  Created by 孙俊 on 2017/12/9.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import "NSString+YCUtil.h"

@implementation NSString (YCUtil)

- (BOOL)checkTelNumber {
    NSString *newString = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (self.length != 11) {
        return NO;
    } else {
        NSString *phoneRegex = @"^1\\d{10}$";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
        return [phoneTest evaluateWithObject:newString];
    }
}

-(BOOL)validateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (NSMutableAttributedString *)stringByBigText:(NSString *)bigText font:(UIFont *)font color:(UIColor *)color {
    NSMutableAttributedString *attStr =  [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = [self rangeOfString:bigText];
    [attStr addAttribute:NSFontAttributeName
                   value:font
                   range:range];
    [attStr addAttribute:NSForegroundColorAttributeName
                   value:color
                   range:range];
    return attStr;
}

- (NSMutableAttributedString *)stringByColorText:(NSString *)text color:(UIColor *)color font:(UIFont *)font {
    NSMutableAttributedString *attStr =  [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = [self rangeOfString:text];
    [attStr yy_setFont:font range:NSMakeRange(0, self.length)];
    [attStr yy_setColor:color range:range];
    return attStr;
}

- (CGFloat)calculateMaxWidthWithFont:(UIFont *)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    /** 行高 */
    // NSKernAttributeName字体间距
    // NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle
                          };

    CGSize textSize = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, font.lineHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return textSize.width;
}

- (CGSize)sizeWithSpace:(CGFloat)lineSpace font:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    /** 行高 */
    paraStyle.lineSpacing = lineSpace;
    // NSKernAttributeName字体间距
    // NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle
                          };
    CGRect rect = [self boundingRectWithSize:CGSizeMake(maxWidth,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil];
    //文本的高度减去字体高度小于等于行间距，判断为当前只有1行
    if ((rect.size.height - font.lineHeight) <= paraStyle.lineSpacing) {
        if ([self containChinese:self]) {  //如果包含中文
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height-paraStyle.lineSpacing);
        }
    }
    return rect.size;
}

//判断如果包含中文
- (BOOL)containChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){ int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

- (NSInteger)fenValue {
    if (self.doubleValue > 0) {
        return [NSString stringWithFormat:@"%f",self.doubleValue * 100].integerValue;
    }
    return 0;
}

- (NSString *)yuanValue {
    if (self.integerValue > 0) {
        return [NSString stringWithFormat:@"%.2f",self.doubleValue/100];
    }
    return @"0.00";
}

- (NSString *)centerSecretStringValue {
    if (self.length == 11) {
        NSString *newString = [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return newString;
    } else {
        return self;
    }
}

- (NSString *)timeForSpeciallFormatter:(NSString *)formatterString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat=formatterString;
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]/ 1000.0];
    NSString* dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSString *)cancelSpotZeroWith:(CGFloat)price{
    NSString *str = [NSString stringWithFormat:@"%.2f",price];
    NSString *last = [str componentsSeparatedByString:@"."][1];
    if ([last integerValue] >0) {
        return [NSString stringWithFormat:@"%.2f",price];
    }else{
        return [NSString stringWithFormat:@"%.0f",price];
    }
    return [NSString stringWithFormat:@"%.2f",price];
}

- (BOOL) isEmpty{
    if (self.length == 0) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}



+ (NSString *)transformChinese:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
//    NSLog(@"%@", pinyin);
    return [pinyin uppercaseString];
}

+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        if (0x278b <= hs && hs <= 0x2792) {
                                            //自带九宫格拼音键盘
                                            returnValue = NO;;
                                        }else if (0x263b == hs) {
                                            returnValue = NO;;
                                        }else {
                                            returnValue = YES;
                                        }
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
    
}


@end
