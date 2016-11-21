//
//  RegisterViewController.m
//  HealthAssistant
//
//  Created by Mac on 16/11/18.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import "RegisterViewController.h"
#import "SetPassWordViewController.h"
#import <SMS_SDK/SMSSDK.h>


@interface RegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *verify;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)next:(id)sender;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    _phone.delegate = self;
    _verify.delegate = self;
    _phone.keyboardType = UIKeyboardTypeNumberPad;
    
    
    
}

#pragma mark 回收键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (_verify.text.length == 4 && _phone.text.length > 0) {
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    }
    return true;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_verify resignFirstResponder];
    [_phone resignFirstResponder];
    
    if (_verify.text.length == 4 && _phone.text.length > 0) {
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 下一步/获取验证码
- (IBAction)next:(id)sender {

    BOOL phoneTrue = [self isMobile:_phone.text];
    
    if ([[_nextBtn titleForState:UIControlStateNormal] isEqualToString:@"获取验证码"]) {
        
        if (phoneTrue) {
            
            /**
             *  @from                    v1.1.1
             *  @brief                   获取验证码(Get verification code)
             *
             *  @param method            获取验证码的方法(The method of getting verificationCode)
             *  @param phoneNumber       电话号码(The phone number)
             *  @param zone              区域号，不要加"+"号(Area code)
             *  @param customIdentifier  自定义短信模板标识 该标识需从官网http://www.mob.com上申请，审核通过后获得。(Custom model of SMS.  The identifier can get it  from http://www.mob.com  when the application had approved)
             *  @param result            请求结果回调(Results of the request)
             */
            [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phone.text
                               zone:@"86"
                   customIdentifier:nil
                             result:^(NSError *error){
                                 if (!error) {
                                     NSLog(@"获取验证码成功");
                                 } else {
                                     NSLog(@"错误信息：%@",error);
                                 }
                                 }];
                                 
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [self.view addSubview:alert];
            [alert show];
        }
        
    }else{
        //下一步
        
        [SMSSDK commitVerificationCode:_verify.text phoneNumber:_phone.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
            
            {
                if (!error)
                {
                    
                    NSLog(@"验证成功");
                    SetPassWordViewController *setVC = [SetPassWordViewController new];
                    
                    [self presentViewController:setVC animated:YES completion:^{
                        
                    }];
                }
                else
                {
                    NSLog(@"错误信息:%@",error);
                }
            }
        }];
        
        if (_verify.text.length == 4 && phoneTrue) {
            
            SetPassWordViewController *setVC = [SetPassWordViewController new];
            
            [self presentViewController:setVC animated:YES completion:^{
                
            }];
            
        }
    }
    
    


}



/**
 *  手机号码验证
 *
 *  @param mobileNumbel 传入的手机号码
 *
 *  @return 格式正确返回true  错误 返回fals
 */
- (BOOL) isMobile:(NSString *)mobileNumbel{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181(增加)
     */
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181(增加)
     22         */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumbel]
         || [regextestcm evaluateWithObject:mobileNumbel]
         || [regextestct evaluateWithObject:mobileNumbel]
         || [regextestcu evaluateWithObject:mobileNumbel])) {
        return YES;
    }
    
    return NO;
}

@end
