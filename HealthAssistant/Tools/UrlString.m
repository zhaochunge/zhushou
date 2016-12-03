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
//忘记密码短信验证接口
+ (NSString *)getRestVerifyCodeWith:(NSString *)phoneNum{

    return [NSString stringWithFormat:@"http://%@/index.php?m=Home&c=Users&a=getRestVerifyCode&phone=%@",BASEURL,phoneNum];
}
//验证找回密码短信接口
+ (NSString *)VerifyRestCode:(NSString *)verifyRestCode phoneNum:(NSString *)phoneNum{

    return [NSString stringWithFormat:@"http://%@/index.php?m=Home&c=Users&a=VerifyRestCode&mobileCode=%@&phone=%@",BASEURL,verifyRestCode,phoneNum];
}
//找回密码接口
+ (NSString *)resetPassWordWithloginName:(NSString *)loginName loginPwd:(NSString *)loginPwd{

    return [NSString stringWithFormat:@"http://%@/index.php?m=Home&c=Users&a=restPassWord&loginName=%@&loginPwd=%@",BASEURL,loginName,loginPwd];
}
//上传血糖信息接口
+ (NSString *)upBloodglucoseWithloginName:(NSString *)loginName bloodglucose:(double)bloodglucose time:(NSString *)time classify:(int)classify{
    return [NSString stringWithFormat:@"http://%@/index.php?m=Home&c=Api&a=upBloodGlucose&loginName=%@&bloodglucose=%.2f&time=%@&classify=%d",BASEURL,loginName,bloodglucose,time,classify];
}
//获取血糖信息接口
+ (NSString *)getBloodglucoseWithLoginName:(NSString *)loginName{

    return [NSString stringWithFormat:@"http://%@/index.php?m=Home&c=Api&a=getBloodGlucose&loginName=%@",BASEURL,loginName];
}
//上传血压信息接口
+ (NSString *)upBloodPressureWithloginName:(NSString *)loginName highpressure:(int)highpressure lowpressure:(int)lowpressure time:(NSInteger)time{

    return [NSString stringWithFormat:@"http://%@/index.php?m=Home&c=Api&a=upBloodPressure&loginName=%@&highpressure=%d&lowpressure=%d&time=%ld",BASEURL,loginName,highpressure,lowpressure,time];
}
//获取血压信息接口
+ (NSString *)getBloodPressureWithLoginName:(NSString *)loginName{

    return [NSString stringWithFormat:@"http://%@/index.php?m=Home&c=Api&a=getBloodPressure&loginName=%@",BASEURL,loginName];
}
//上传心率信息接口
+ (NSString *)upHeartRateWithloginName:(NSString *)loginName HeartRate:(int)HeartRate time:(NSInteger)time{
    
    return [NSString stringWithFormat:@"http://%@/index.php?m=Home&c=Api&a=upHeartRate&loginName=%@&heartRate=%d&time=%ld",BASEURL,loginName,HeartRate,time];
}
//获取心率信息接口
+ (NSString *)getHeartRateWithLoginName:(NSString *)loginName{
    
    return [NSString stringWithFormat:@"http://%@/index.php?m=Home&c=Api&a=getHeartRate&loginName=%@",BASEURL,loginName];
}
//上传图片
+ (NSString *)upImage{

    return [NSString stringWithFormat:@"http://%@/index.php?m=Home&c=Api&a=uploadImage",BASEURL];
}
//上传图片路径
+ (NSString *)upLoadPathWithLoginName:(NSString *)loginName savepath:(NSString *)savepath savethumbname:(NSString *)savethumbname{


    return [NSString stringWithFormat:@"http://%@/index.php?m=Home&c=Api&a=uploadPath&loginName=%@&imageUrl=%@%@",BASEURL,loginName,savepath,savethumbname];
}



@end
