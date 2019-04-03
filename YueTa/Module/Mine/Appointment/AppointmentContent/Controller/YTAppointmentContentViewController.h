//
//  YTAppointmentContentViewController.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/3.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ContentSelectedBlock)(NSString *content);

@interface YTAppointmentContentViewController : BaseViewController

@property (nonatomic, strong) NSArray *engagementArr;
@property (nonatomic, copy) ContentSelectedBlock contentSelectedBlock;

@end

NS_ASSUME_NONNULL_END
