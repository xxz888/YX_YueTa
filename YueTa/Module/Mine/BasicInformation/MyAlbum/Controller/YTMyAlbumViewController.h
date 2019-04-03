//
//  YTMyAlbumViewController.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/7.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTMyAlbumViewController : BaseViewController

/**
 是否是自己的个人相册,自己的可以上传,别人的只能看
 */
@property (nonatomic, assign) BOOL isMineAlbum;


/**
 别的用户的id,自己的可以不传
 */
@property (nonatomic, assign) NSInteger ID;

@end

NS_ASSUME_NONNULL_END
