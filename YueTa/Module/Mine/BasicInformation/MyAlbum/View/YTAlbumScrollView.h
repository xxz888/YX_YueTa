//
//  YTAlbumScrollwView.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/25.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YTAlbumScrollView : UIView

+ (void)showAlbumByDataArray:(NSArray *)dataArray
                       selectedIndex:(NSInteger)selectedIndex;

@end

NS_ASSUME_NONNULL_END
