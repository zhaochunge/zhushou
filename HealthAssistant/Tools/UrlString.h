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

@end
