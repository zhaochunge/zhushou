//
//  ForgetVerifyViewController.m
//  HealthAssistant
//
//  Created by zhezhewl on 16/11/26.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import "ForgetVerifyViewController.h"
#import "ResetPwdViewController.h"


@interface ForgetVerifyViewController ()
@property (weak, nonatomic) IBOutlet UITextField *VerifyCode;
@property (nonatomic, assign) BOOL doSomething;

@end

@implementation ForgetVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark back

- (IBAction)back:(id)sender {
    
    
    DISMISS_VIEWCONTROLLER;
    
}



- (IBAction)next:(id)sender {
    
    
    if (_doSomething) return;
        
    _doSomething = YES;
    if (_VerifyCode.text.length == 6) {
        

    
    [XHNetworking GET:[UrlString VerifyRestCode:_VerifyCode.text phoneNum:_phoneNum] parameters:nil success:^(id responseObject) {
        _doSomething = NO;

        
        if ([responseObject[@"status"] integerValue] == 1) {
            
            ResetPwdViewController *vc = [ResetPwdViewController new];
            
            PRESENT_VIEWCONTROLLER(vc, YES);
            
            vc.phoneNum = self.phoneNum;
        
        }else{
        
            [self alertViewWith:@"提示" message:responseObject[@"msg"]];
        }
        
        
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
    }else{
        _doSomething = NO;

        [self alertViewWith:@"提示" message:@"您输入的验证码有误"];
    }
    
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
