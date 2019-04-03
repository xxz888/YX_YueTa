//
//  UIStandardMacro.h
//  ychat
//
//  Created by 孙俊 on 2017/12/3.
//  Copyright © 2017年 Sun. All rights reserved.
//

#ifndef UIStandardMacro_h
#define UIStandardMacro_h

//整体颜色相关
#define kWhiteTextColor                     [UIColor whiteColor]
#define kWhiteBackgroundColor               [UIColor whiteColor]
#define kBlackTextColor                     [UIColor colorWithHexString:@"#111111"]
#define kDarkBlackTextColor                 [UIColor colorWithHexString:@"#555555"]
#define kGrayTextColor                      [UIColor colorWithHexString:@"#848688"]
#define kGrayBorderColor                    [UIColor colorWithHexString:@"#D8D8D8"]
#define kDarkGrayTextColor                  [UIColor colorWithHexString:@"#949494"]
#define kPlaceholderGrayColor               [UIColor colorWithHexString:@"#CDCDCD"]
#define kGrayBackgroundColor                [UIColor colorWithHexString:@"#EFF0F4"]
#define kSepLineGrayBackgroundColor         [UIColor colorWithHexString:@"#E4E4E4"]
#define kNavBlackBackgroundColor            [UIColor colorWithHexString:@"#3E3C4A"]
#define kNotificationMessageBackgroundColor [UIColor colorWithHexString:@"#CECECE"]
#define kGrayBackgroundViewColor            [UIColor colorWithHexString:@"#EFF0F4"]
#define kRedBackgroundColor                 [UIColor colorWithHexString:@"#E15043"]
#define kRedDisableBackgroundColor          [UIColor colorWithHexString:@"#E15043" alpha:0.5]
//钱包相关金色
#define kGoldColor                          [UIColor colorWithHexString:@"#FEEC9C"]
#define kLightGoldColor                     [UIColor colorWithHexString:@"#FFB709"]
//时间相关灰色
#define kTimeGrayColor                      [UIColor colorWithHexString:@"#ABABAB"]
//欢迎页面选择按钮灰色
#define kWelcomeRegistButtonGrayColor       [UIColor colorWithHexString:@"434345"]
//首页＋视图黑色
#define kAddMenuBlackColor                  [UIColor colorWithHexString:@"474752"]
#define kAddMenuSepLineColor                [UIColor colorWithHexString:@"62626C"]
//扫码黑色背景
#define kScannerBackgroundBlackColor        [UIColor colorWithWhite:0 alpha:0.6]

#define SAFE_SEND_MESSAGE(obj, msg) if ((obj) && [(obj) respondsToSelector:@selector(msg)])


#define kPurpleTextColor         [UIColor colorWithHexString:@"#8A76E4"]
#define kMineBackgroundColor     [UIColor colorWithHexString:@"#F2F1F6"]
#define kMineGrayBackgroundColor [UIColor colorWithHexString:@"#EEEEEE"]
#define kYellowTextColor         [UIColor colorWithHexString:@"#F3A478"]
#define kYellowBackgroundColor   [UIColor colorWithHexString:@"#F6BC4D"]
#define kBorderPurpleBorderColor [UIColor colorWithHexString:@"#8B47C5"]
#define kLightPurpleColor        [UIColor colorWithHexString:@"#C6A0EF"]

//高度
#define kLoginRegistInputViewHeight kRealValue(40)      //登录注册输入框高度
#define kSystemCellDefaultHeight kRealValue(44)         //定制系统cell的默认高度
#define kSystemCellSectionHeight kRealValue(15)         //定制系统cell的sectionView默认高度
#define kTableCellHeightZero 0.000001f                  //tableViewSection的view高度为0的设置

//用到的字体
#define kSystemFont10    [UIFont systemFontOfSize:kRealValue(10)]
#define kSystemFont12    [UIFont systemFontOfSize:kRealValue(12)]
#define kSystemFont13    [UIFont systemFontOfSize:kRealValue(13)]
#define kSystemFont14    [UIFont systemFontOfSize:kRealValue(14)]
#define kSystemFont15    [UIFont systemFontOfSize:kRealValue(15)]
#define kSystemFont16    [UIFont systemFontOfSize:kRealValue(16)]
#define kSystemFont17    [UIFont systemFontOfSize:kRealValue(17)]
#define kSystemFont18    [UIFont systemFontOfSize:kRealValue(18)]
#define kSystemFont20    [UIFont systemFontOfSize:kRealValue(20)]
#define kSystemFont25    [UIFont systemFontOfSize:kRealValue(25)]
#define kSystemFont40    [UIFont systemFontOfSize:kRealValue(40)]

#define kSystemFontBold15    [UIFont boldSystemFontOfSize:kRealValue(15)]
#define kSystemFontBold18    [UIFont boldSystemFontOfSize:kRealValue(18)]
#define kSystemFontBold35    [UIFont boldSystemFontOfSize:kRealValue(35)]

#endif /* UIStandardMacro_h */
