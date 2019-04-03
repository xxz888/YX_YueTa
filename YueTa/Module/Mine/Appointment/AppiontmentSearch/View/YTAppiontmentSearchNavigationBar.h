//
//  YTAppiontmentSearchNavigationBar.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/7.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YTAppiontmentSearchNavigationBarDelegate <NSObject>

@optional
- (void)searchTextDidChange:(NSString *)searchText;
- (void)searchButtonDidTapped:(NSString *)searchText;
- (void)cancelButtonDidTapped;

@end

@interface YTAppiontmentSearchNavigationBar : UIView

@property (nonatomic,weak) id<YTAppiontmentSearchNavigationBarDelegate> delegate;

@end

NS_ASSUME_NONNULL_END