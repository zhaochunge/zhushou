//
//  UrlString.m
//  HealthAssistant
//
//  Created by zhezhewl on 16/11/21.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import "UrlString.h"
#define BASEURL @"192.168.10.200:8088"
@implementation UrlString
//注册短信接口

+ (NSString *)getVerifyCodeWith:(NSString *)phoneNum{

    return [NSString stringWithFormat:@"http://%@/index.php?m=Home&c=Users&a=getVerifyCode&phone=%@",BASEURL,phoneNum];

}
//注册短信验证接口

+ (NSString *)VerifyCode:(NSString *)mobileCode phoneNum:(NSString *)phoneNum{

    return [NSString stringWithFormat:@"http://%@/index.php?m=Home&c=Users&a=VerifyCode&mobileCode=%@&phone=%@",BASEURL,mobileCode,phoneNum];
}
//用户注册接口

+ (NSString *)registwith:(NSString *)phoneNum loginPwd:(NSString *)loginPwd{

    return [NSString stringWithFormat:@"http://%@/index.php?m=Home&c=Users&a=registUser&loginName=%@&loginPwd=%@",BASEURL,phoneNum,loginPwd];
}
//用户登录借口

+ (NSString *)loginWith:(NSString *)loginName loginPwd:(NSString *)loginPwd{

    return [NSString stringWithFormat:@"http://%@/index.php?m=Home&c=Users&a=checkUserLogin&loginName=%@&loginPwd=%@",BASEURL,loginName,loginPwd];
}
@end
