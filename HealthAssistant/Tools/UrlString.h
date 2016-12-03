//
//  UrlString.h
//  HealthAssistant
//
//  Created by zhezhewl on 16/11/21.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UrlString : NSObject
//注册短信接口
+ (NSString *)getVerifyCodeWith:(NSString *)phoneNum;
//注册短信验证接口
+ (NSString *)VerifyCode:(NSString *)mobileCode phoneNum:(NSString *)phoneNum;
//用户注册接口
+ (NSString *)registwith:(NSString *)phoneNum loginPwd:(NSString *)loginPwd;
//登录接口
+ (NSString *)loginWith:(NSString *)loginName loginPwd:(NSString *)loginPwd;
//忘记密码短信验证接口
+ (NSString *)getRestVerifyCodeWith:(NSString *)phoneNum;
//验证找回密码短信接口
+ (NSString *)VerifyRestCode:(NSString *)verifyRestCode phoneNum:(NSString *)phoneNum;
//找回密码接口
+ (NSString *)resetPassWordWithloginName:(NSString *)loginName loginPwd:(NSString *)loginPwd;
//上传血糖信息接口
+ (NSString *)upBloodglucoseWithloginName:(NSString *)loginName bloodglucose:(double)bloodglucose time:(NSString *)time classify:(int)classify;
//获取血糖信息接口
+ (NSString *)getBloodglucoseWithLoginName:(NSString *)loginName;
//上传血压信息接口
+ (NSString *)upBloodPressureWithloginName:(NSString *)loginName highpressure:(int)highpressure lowpressure:(int)lowpressure time:(NSInteger)time;
//获取血压信息接口
+ (NSString *)getBloodPressureWithLoginName:(NSString *)loginName;
//上传心率信息接口
+ (NSString *)upHeartRateWithloginName:(NSString *)loginName HeartRate:(int)HeartRate time:(NSInteger)time;
//获取心率信息接口
+ (NSString *)getHeartRateWithLoginName:(NSString *)loginName;
//上传图片接口
+ (NSString *)upImage;
//图片上传路径
+ (NSString *)upLoadPathWithLoginName:(NSString *)loginName savepath:(NSString *)savepath savethumbname:(NSString *)savethumbname;
@end
