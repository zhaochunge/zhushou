//
//  ForgetNumViewController.m
//  HealthAssistant
//
//  Created by zhezhewl on 16/11/26.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import "ForgetNumViewController.h"
#import "ForgetVerifyViewController.h"


@interface ForgetNumViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (nonatomic, assign) BOOL doSomething;
@end

@implementation ForgetNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark 返回


- (IBAction)back:(id)sender {
    
    
    DISMISS_VIEWCONTROLLER;
    
}

#pragma mark 获取验证码


- (IBAction)getRestVerifyCode:(id)sender {
    
    if (_doSomething) {
        return;
    }
    _doSomething = YES;
    
    BOOL phoneTrue = [self isMobile:_phoneNum.text];
    
    if (phoneTrue) {
        
    
    
    
    [XHNetworking GET:[UrlString getRestVerifyCodeWith:_phoneNum.text] parameters:nil success:^(id responseObject) {
        
        _doSomething = NO;

        if ([responseObject[@"status"] integerValue] == 1) {
            
            ForgetVerifyViewController *vc = [ForgetVerifyViewController new];
            
            PRESENT_VIEWCONTROLLER(vc, YES);
            
            vc.phoneNum = _phoneNum.text;
            
        }else{
        
        
            [self alertViewWith:@"提示" message:responseObject[@"msg"]];
        }
        
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
    
    }else{
        _doSomething = NO;

    
        [self alertViewWith:@"提示" message:@"您输入的号码有误"];
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
