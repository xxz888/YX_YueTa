//
//  ApiMacro.h
//  ychat
//
//  Created by 孙俊 on 2017/12/3.
//  Copyright © 2017年 Sun. All rights reserved.
//


#ifndef ApiMacro_h
#define ApiMacro_h

//#define kBaseURLString @"http://thegdlife.com:8002"//测试域名
#define kBaseURLString @"http://192.168.0.12:8001"//测试域名


#pragma mark - **************** 接口返回Code相关 ****************
static int const kRequestTimeoutInterval      = 30; //网络请求超时时间
static int const kResponseSuccessCode         = 1;  //本地定义字段，接口返回成功
static int const kResponseFailureCode         = 2;  //本地定义字段，接口返回失败


#pragma mark - **************** 接口 ****************

#pragma mark - 登录相关
static NSString * const kUserLogin = @"/users/auth/"; //登录
static NSString * const kSendCode = @"/users/sms_codes/"; //短信验证码
static NSString * const kUserRegister = @"/users/register/"; //注册
static NSString * const kTagData = @"/users/options/"; //标签数据
static NSString * const kUpdateUserInfo = @"/users/users/"; //完善资料(第一次 必须全部上传)
static NSString * const kResetPassword = @"/users/password/"; //重置密码
static NSString * const kInitHX = @"/users/huanxin/"; //初始化环信
static NSString * const kInitHXID = @"/users/huanxinID/"; //环信ID（aim_id必须拼接在后面）
static NSString * const kModifyUserInfo = @"/users/update_users/";//完善资料(可单独修改字段)

#pragma mark - 附近相关
static NSString * const kNearList = @"/nearby/users/";//附近的人
static NSString * const kNearUserInfo = @"/nearby/detail/";//附近 某一个用户的详情
static NSString * const kUserPhotos = @"/users/photo/";//相册
static NSString * const kPhotosUpload = @"/users/photo_upload/";//相册上传
static NSString * const kUserApply = @"/users/apply/";//报名
static NSString * const kPublishYueTa = @"/users/publish/";//约她
static NSString * const kInformUser = @"/users/inform/";//举报
static NSString * const kOneUserDate = @"/users/dates/";//Ta的约会
static NSString * const kNearFilt = @"/nearby/filt/";//筛选

#pragma mark - 广场相关
static NSString * const kSquareList = @"/plaza/date/";//广场
static NSString * const kSquareFiltrate = @"/plaza/filt/";//广场筛选


#pragma mark - Store相关
static NSString * const kGetQiniuToken = @"/store/qiniu_token/%@/";//完善资料(可单独修改字段)
static NSString * const kLikeUser = @"/nearby/like/";//关注用户
static NSString * const kDisLikeUser = @"/nearby/dislike/";//取消关注用户
static NSString * const kBlackUser = @"/nearby/black/";//拉黑用户
static NSString * const kDisBlackUser = @"/nearby/disblack/";//取消拉黑用户
static NSString * const kAck_apply = @"/store/ack_apply/";//确认邀约
static NSString * const kOver_look = @"/store/over_look/";//忽略
static NSString * const kApply_list = @"/store/apply_list/";//报名列表

#pragma mark - 我的相关
static NSString * const kGetNearbyLike = @"/nearby/like/"; //粉丝喜欢数量
static NSString * const kGetMydate = @"/plaza/mydate/"; //我的发布/我的报名/我的约会
static NSString * const kGetRelation = @"/plaza/relation/"; //fans or like or black列表
static NSString * const kGetAuthenStatus = @"/plaza/authen_status/"; //身份认证
static NSString * const kSubmitAuthen = @"/plaza/submit_authen/"; //提交身份认证
static NSString * const kPersonalData = @"/nearby/personal_data/"; //我的资料
static NSString * const kMyProblem = @"/store/my_problem/"; //我的提问列表/提交提问
static NSString * const kCommonProblem = @"/store/common_problem/"; //常见问列表
static NSString * const kAboutus = @"/store/about_us/"; //关于我们
static NSString * const kAuthen_status = @"/plaza/authen_status/";//身份认证
static NSString * const kSubmit_authen = @"/plaza/submit_authen/";//提交身份认证

#endif /* ApiMacro_h */
