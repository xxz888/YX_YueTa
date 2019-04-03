//
//  YTImgAlignmentButton.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTImgAlignmentButton.h"

@implementation YTImgAlignmentButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    switch (self.imageViewAlignment)
    {
        case ImageViewAlignmentLeft:return;
            break;
        case ImageViewAlignmentRight:
        {
            //设置文字位置
            CGRect frame = self.titleLabel.frame ;
            frame.origin.x = self.imageView.frame.origin.x ;
            //如果发生二次布局 则退出
            if (frame.origin.x > self.frame.size.width/2.0)
            {
                return;
            }
            self.titleLabel.frame = frame;
            //设置图片位置
            frame = self.imageView.frame ;
            frame.origin.x = self.titleLabel.frame.size.width + self.titleLabel.frame.origin.x + self.intervalImgToTitle;
            self.imageView.frame = frame;
        }
            break;
        case ImageViewAlignmentTop:
        {
            CGFloat heightImgView = self.imageView.frame.size.height ;
            CGFloat heightTitle = self.titleLabel.frame.size.height;
            if (heightTitle <= 0 && self.titleLabel.text.length)
            {
                heightTitle = self.titleLabel.font.pointSize + 2;
            }
            
            //把图片居中
            CGPoint center = self.imageView.center;
            center.x       = self.frame.size.width/2;
            center.y       = heightImgView/(heightImgView + heightTitle) * self.frame.size.height/2;
            self.imageView.center = center;
            
            //把文字居中
            CGRect textFrame     = [self titleLabel].frame;
            textFrame.origin.x   = 0;
            textFrame.origin.y   = self.imageView.frame.origin.y + heightImgView + self.intervalImgToTitle;
            textFrame.size.width = self.frame.size.width;
            textFrame.size.height = heightTitle;
            self.titleLabel.frame = textFrame;
        }
            break;
            
        case ImageViewAlignmentBottom:
        {
            CGFloat heightImgView = self.imageView.frame.size.height ;
            CGFloat heightTitle = self.titleLabel.frame.size.height ;
            CGFloat newTitleHeight = (heightTitle/(heightImgView + heightTitle) * self.frame.size.height  < heightTitle ) ? heightTitle : heightTitle/(heightImgView + heightTitle) * self.frame.size.height;
            CGFloat newImageHeight = self.frame.size.height - newTitleHeight;
            //把文字居中
            CGPoint point = self.titleLabel.center;
            point.x = self.center.x ;
            point.y = newTitleHeight/2;
            self.titleLabel.center = point ;
            //把图片居中
            CGPoint center = self.imageView.center;
            center.x       = self.frame.size.width/2;
            center.y       = newTitleHeight + newImageHeight / 2;
            self.imageView.center = center ;
        }
            break;
            
        default:
            break;
    }
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    if (self.blockLayoutSubViews)
    {
        self.blockLayoutSubViews();
    }
}


- (void)layoutSubviewssssss
{
    [super layoutSubviews];
    
    if (!self.imageView.image)
    {
        if (self.imageView)
        {
            self.imageView.frame = CGRectZero;
        }
    }
    
    if (!self.titleLabel.text || self.titleLabel.text.length == 0)
    {
        if (self.titleLabel)
        {
            self.titleLabel.frame = CGRectZero;
        }
    }
    
    switch (self.imageViewAlignment)
    {
        case ImageViewAlignmentLeft:return;
            break;
        case ImageViewAlignmentRight:
        {
            //设置图片位置
            CGPoint center = self.imageView.center;
            center.x       = self.frame.size.width-self.imageView.frame.size.width/2;
            center.y       = self.frame.size.height/2;
            self.imageView.center = center;
            
            //设置文字位置
            self.titleLabel.frame = CGRectMake(0, 0, self.frame.size.width-self.imageView.frame.size.width, self.frame.size.height);
            
            self.titleLabel.textAlignment = NSTextAlignmentRight;
        }
            break;
        case ImageViewAlignmentTop:
        {
            CGFloat heightImgView = self.imageView.frame.size.height ;
            CGFloat heightTitle = self.titleLabel.frame.size.height ;
            
            //把图片居中
            CGPoint center = self.imageView.center;
            center.x       = self.frame.size.width/2;
            center.y       = heightImgView/(heightImgView + heightTitle) * self.frame.size.height/2;
            self.imageView.center = center;
            
            //把文字居中
            CGRect textFrame     = [self titleLabel].frame;
            textFrame.origin.x   = 0;
            textFrame.origin.y   = self.imageView.frame.origin.y + heightImgView ;
            textFrame.size.width = self.frame.size.width;
            
            self.titleLabel.frame = textFrame;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
            
        case ImageViewAlignmentBottom:
        {
            
        }
            break;
            
        default:
            break;
    }
}

@end
