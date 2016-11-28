//
//  SetPassWordViewController.m
//  HealthAssistant
//
//  Created by Mac on 16/11/18.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import "SetPassWordViewController.h"
#import "HomeViewController.h"

@interface SetPassWordViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *repectPaswd;
@property (nonatomic,assign) BOOL doSomeThing;


- (IBAction)finish:(id)sender;

@end

@implementation SetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _password.delegate = self;
    _repectPaswd.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 完成注册
- (IBAction)finish:(id)sender {
    
    if (_doSomeThing) return;
    
    
    _doSomeThing = YES;

    if ([_password.text isEqualToString:_repectPaswd.text]) {
        
        NSString *num = USERDEFAULTS_GET(USER_LOGINNAME);
        
        
        [XHNetworking GET:[UrlString registwith:num loginPwd:_password.text] parameters:nil success:^(id responseObject) {
            
            _doSomeThing = NO;

            
            if (responseObject != nil) {
                
                
                
                if ([responseObject[@"status"] integerValue] == 1) {
                    
                    [_password resignFirstResponder];
                    [_repectPaswd resignFirstResponder];

                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGED object:@YES];

                }else{
                
                    [self alertViewWith:@"提示" message:responseObject[@"msg"]];

                }
               
                
                
            }
            
            
            
        } failure:^(NSError *error) {
            
            
        }];
        

        
      
        
        
    }else{
        
        _doSomeThing = NO;

        [self alertViewWith:@"提示" message:@"密码不一致"];
    }
    
    
}

- (IBAction)back:(id)sender {
    
    DISMISS_VIEWCONTROLLER;
    
}



#pragma mark 回收键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_password resignFirstResponder];
    [_repectPaswd resignFirstResponder];
}


@end
