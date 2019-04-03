//
//  YTMyAlbumCell.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/7.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddImageBlock)(void);

@interface YTMyAlbumCell : UICollectionViewCell

@property (nonatomic, copy) AddImageBlock addImageBlock;

@property (nonatomic, copy, nullable) NSString *albumURL;

@end

NS_ASSUME_NONNULL_END
