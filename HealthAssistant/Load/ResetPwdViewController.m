//
//  ResetPwdViewController.m
//  HealthAssistant
//
//  Created by zhezhewl on 16/11/26.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import "ResetPwdViewController.h"

@interface ResetPwdViewController ()



@property (weak, nonatomic) IBOutlet UITextField *passWord;


@property (weak, nonatomic) IBOutlet UITextField *repassWord;

@property (nonatomic,assign) BOOL doSomething;

@end

@implementation ResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}



- (IBAction)next:(id)sender {
    
    
    if (_doSomething) {
        return;
    }
    
    _doSomething = YES;
    
    
    
    if ([_passWord.text isEqualToString:@""] || [_repassWord.text isEqualToString:@""]){
    
        _doSomething = NO;
        
        
        [self alertViewWith:@"提示" message:@"请填写密码"];
        
        
    }else if ([_passWord.text isEqualToString:_repassWord.text]) {
        
        
        [XHNetworking GET:[UrlString resetPassWordWithloginName:_phoneNum loginPwd:_passWord.text] parameters:nil success:^(id responseObject) {
            
            _doSomething = NO;

            if ([responseObject[@"status"] integerValue] == 1) {
                
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGED object:@YES];
            }
            
            [self alertViewWith:@"提示" message:responseObject[@"msg"]];
            
        } failure:^(NSError *error) {
            
            
        }];
        
        
        
        
    }else{
        _doSomething = NO;

    
        [self alertViewWith:@"提示" message:@"两次输入的密码不一致"];
    }
    
    
    
    
    
}



- (IBAction)back:(id)sender {
    
    
    
    DISMISS_VIEWCONTROLLER;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
