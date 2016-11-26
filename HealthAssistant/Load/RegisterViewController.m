//
//  RegisterViewController.m
//  HealthAssistant
//
//  Created by Mac on 16/11/18.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import "RegisterViewController.h"
#import "SetPassWordViewController.h"


@interface RegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *verify;

@property (weak, nonatomic) IBOutlet UIButton *getVerify;
@property (weak, nonatomic) IBOutlet UIButton *NextButon;

@property (nonatomic,assign)BOOL doingSomeThing;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    _phone.delegate = self;
    _verify.delegate = self;
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(verifyChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    [self.verify addTarget:self action:@selector(verifyChange) forControlEvents:UIControlEventEditingChanged	];
    
}

#pragma mark 回收键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];

    return true;
}




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_verify resignFirstResponder];
    [_phone resignFirstResponder];
    

}

- (void)verifyChange{
   

    
    if (self.verify.text.length == 6){
        
        self.NextButon.backgroundColor = RGBA(19, 80, 255, 1);
        self.NextButon.enabled = YES;
        
    }else{
        self.NextButon.backgroundColor = [UIColor lightGrayColor];

        self.NextButon.enabled = YES;

    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 下一步/获取验证码


- (IBAction)getVerify:(id)sender {
    
    BOOL phoneTrue = [self isMobile:_phone.text];

    
    if (phoneTrue) {
        
        
        USERDEFAULTS_SET(_phone.text, USER_PHONENUM);
        
        [XHNetworking GET:[UrlString getVerifyCodeWith:_phone.text] parameters:nil success:^(id responseObject) {
            
            
            if ([responseObject[@"status"] integerValue] != 1) {
                
                
                [self alertViewWith:@"提示" message:responseObject[@"msg"]];
            }
            
            
        } failure:^(NSError *error) {
            
            
        }];
        
        
            __block int time = 60;
            __block UIButton *verifybutton = _getVerify;
            verifybutton.enabled = NO;
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(time<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        [verifybutton setTitle:@"获取验证码" forState:UIControlStateNormal];
                        verifybutton.enabled = YES;
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        NSString *strTime = [NSString stringWithFormat:@"重新获取验证码(%d)",time];
                        [verifybutton setTitle:strTime forState:UIControlStateNormal];
                    });
                    time--;
                }
            });
            dispatch_resume(_timer);
            [self.verify becomeFirstResponder];

        
    }else{
    

        
        [self alertViewWith:@"提示" message:@"您输入的号码有误"];

    
    }
    
}




- (IBAction)nextClick:(id)sender {
    
    if (_doingSomeThing) return;

    _doingSomeThing = YES;
    [XHNetworking GET:[UrlString VerifyCode:_verify.text phoneNum:_phone.text] parameters:nil success:^(id responseObject) {
        
        _doingSomeThing = NO;

        
        if ([responseObject[@"status"] integerValue] == 1) {
            SetPassWordViewController *setVC = [SetPassWordViewController new];

            PRESENT_VIEWCONTROLLER(setVC, YES);


        }else{
        
            [self alertViewWith:@"提示" message:responseObject[@"msg"]];

        }
        

        
    } failure:^(NSError *error) {
        
        
    }];
    
    
    
}


- (IBAction)back:(id)sender {
    
    DISMISS_VIEWCONTROLLER;
    
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
