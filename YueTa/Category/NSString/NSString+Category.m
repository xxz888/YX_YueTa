//
//  NSString+Category.m
//  CJYP
//
//  Created by 蓝海 on 2018/8/17.
//  Copyright © 2018年 林森. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

+ (NSString *)encodeBase64String:(NSString *)text{
    if (text.length < 1) {
        return nil;
    }
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    
    return base64String;
}

+ (NSString *)deCodeBase64String:(NSString *)base64{
    if (base64.length <1) {
        return nil;
    }
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (text.length == 0) {
        text = base64;
    }
    return text;

}

+ (CGSize)getStringSizeWithText:(NSString *)text size:(CGSize)size font:(UIFont *)font{
    
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size;
}




@end
