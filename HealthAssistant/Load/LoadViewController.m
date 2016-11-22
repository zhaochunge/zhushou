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
#import "HomeViewController1.h"

@interface LoadViewController ()<UITextFieldDelegate>
- (IBAction)resignBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *loadName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
- (IBAction)load:(id)sender;

@end

@implementation LoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    _loadName.delegate = self;
    _passWord.delegate = self;
    
    UIImageView *userimage=[[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 25, 25)];
    userimage.image = [UIImage imageNamed:@"用户"];
    _loadName.leftView=userimage;
    _loadName.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *passWordimage=[[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 25, 25)];
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
    [self presentViewController:regVC animated:YES completion:^{
        
    }];
    
    
}
#pragma mark 登录
- (IBAction)load:(id)sender {
    
    if (_loadName.text.length>0 && _passWord.text.length>0) {
        HomeViewController *home = [HomeViewController new];
        [self presentViewController:home animated:YES completion:^{
            
        }];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"账户名或密码不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [self.view addSubview:alert];
        [alert show];
    }
    
    
    
}
@end
