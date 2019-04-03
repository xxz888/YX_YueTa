//
//  UILabel+Utils.m
//  ychat
//
//  Created by 孙俊 on 2017/12/3.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import "UILabel+Utils.h"

@implementation UILabel (Utils)

+ (UILabel *)labelWithName:(NSString *)labelName Font:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment{
    UILabel * label = [[UILabel alloc] init];
    if (labelName) {
        label.text = labelName;
    }
    label.textAlignment = textAlignment;
    label.font = font;
    label.textColor = color;
    return label;
}



- (void)textAlignmentLeftAndRight{
    
    [self  textAlignmentLeftAndRightWith:CGRectGetWidth(self.frame)];
    
}



- (void)textAlignmentLeftAndRightWith:(CGFloat)labelWidth{
    
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(labelWidth,MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName :self.font}  context:nil].size;
    
    CGFloat margin = (labelWidth - size.width)/(self.text.length - 1);
    
    NSNumber *number = [NSNumber numberWithFloat:margin];
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString  alloc]  initWithString:self.text];
    [attribute addAttribute:NSKernAttributeName value:number range:NSMakeRange(0,self.text.length -1 )];
    
    self.attributedText = attribute;
}

- (void)changeLineSpaceWithSpace:(CGFloat)space textAlignment:(NSTextAlignment)textAlignment{
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    if (textAlignment) {
        [paragraphStyle setAlignment:textAlignment];
    }
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}

@end
