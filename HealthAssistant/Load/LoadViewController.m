//
//  LoadViewController.m
//  HealthAssistant
//
//  Created by Mac on 16/11/18.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import "LoadViewController.h"
#import "RegisterViewController.h"
#import "HomeViewController.h"
#import "InputViewController.h"
#import "HomeViewController1.h"

@interface LoadViewController ()<UITextFieldDelegate>
- (IBAction)resignBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *loadName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
- (IBAction)load:(id)sender;
@property (nonatomic,assign)BOOL doSomeThing;
@end

@implementation LoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    _loadName.delegate = self;
    _passWord.delegate = self;

    UIImageView *userimage=[[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 25, 25)];
    userimage.image = [UIImage imageNamed:@"用户"];
    _loadName.leftView = userimage;
    _loadName.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *passWordimage=[[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 25, 25)];
    passWordimage.image = [UIImage imageNamed:@"密码"];
    _passWord.leftView=passWordimage;
    _passWord.leftViewMode = UITextFieldViewModeAlways;
    _loadName.keyboardType = UIKeyboardTypeNumberPad;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 回收键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_loadName resignFirstResponder];
    [_passWord resignFirstResponder];
}

#pragma mark 注册
- (IBAction)resignBtn:(id)sender {
    
    RegisterViewController *regVC = [[RegisterViewController alloc] init];
    

    
    PRESENT_VIEWCONTROLLER(regVC, YES);
    
    
}
#pragma mark 登录
- (IBAction)load:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGED object:@YES];

    
    if (_doSomeThing) return;

    _doSomeThing = YES;

    if (_loadName.text.length>0 && _passWord.text.length>0) {
       
        
        
        
        [XHNetworking GET:[UrlString loginWith:_loadName.text loginPwd:_passWord.text] parameters:nil success:^(id responseObject) {
            
            _doSomeThing = NO;
            if ([responseObject[@"status"] integerValue] == 1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGED object:@YES];
            }
            else{
            
                [self alertViewWith:@"提示" message:responseObject[@"msg"]];
            }
            
        } failure:^(NSError *error) {
            
            
        }];
        
        
     
        
        
        
        
    }else{
        
        
        [self alertViewWith:@"提示" message:@"请输入手机号或者密码"];
        
        _doSomeThing = NO;
    }
    
    
    
}
@end
