//
//  YTMessageController.m
//  YueTa
//
//  Created by 姚兜兜 on 2018/12/20.
//  Copyright © 2018 姚兜兜. All rights reserved.
//

#import "YTMessageController.h"
//#import "YTTempChatController.h"
#import "YTMessageDetailViewController.h"

@interface YTMessageController ()<EaseConversationListViewControllerDelegate>

@end

@implementation YTMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate  = self;
//    [self setNavigationBarTitle:@"消息"];
    
//    UIButton *button = [UIButton buttonWithTitle:@"啦啦啦" taget:self action:@selector(buttonClick) font:kSystemFont15 titleColor:kRedBackgroundColor];
//    button.frame = CGRectMake(100, 100, 100, 100);
//    [self.view addSubview:button];
    
}

//- (void)buttonClick {
//    YTTempChatController *vc =[[YTTempChatController alloc] initWithConversationChatter:@"222" conversationType:EMConversationTypeChat];
//    [self.navigationController pushViewController:vc animated:YES];
//}

- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
            didSelectConversationModel:(id<IConversationModel>)conversationModel {
    YTMessageDetailViewController *viewController = [[YTMessageDetailViewController alloc] initWithConversationChatter:conversationModel.conversation.conversationId conversationType:conversationModel.conversation.type];
    viewController.title = conversationModel.title;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
