//
//  YTFiltrateSquareController.h
//  YueTa
//
//  Created by Awin on 2019/1/31.
//  Copyright © 2019年 姚兜兜. All rights reserved.
//

#import "BaseViewController.h"

@protocol YTFiltrateSquareControllerDelegate <NSObject>

- (void)YTFiltrateControllerCompleteWithMax_weight:(NSInteger)max_weight
                                        min_weight:(NSInteger)min_weight
                                           max_age:(NSInteger)max_age
                                           min_age:(NSInteger)min_age
                                        max_height:(NSInteger)max_height
                                        min_height:(NSInteger)min_height
                                             isVip:(BOOL)isVip
                                       auth_status:(BOOL)auth_status
                                              sort:(BOOL)sort
                                              work:(NSString *)work
                                         education:(NSInteger)education
                                              show:(NSString *)show
                                            gender:(NSInteger)gender
                                        max_reward:(NSInteger)max_reward
                                        min_reward:(NSInteger)min_reward;
@end

@interface YTFiltrateSquareController : BaseViewController

@property (nonatomic, assign) id<YTFiltrateSquareControllerDelegate> delegate;

@end
