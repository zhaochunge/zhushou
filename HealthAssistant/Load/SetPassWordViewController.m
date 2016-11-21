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
    if ([_password.text isEqualToString:_repectPaswd.text]) {
        
        HomeViewController *homeVC = [[HomeViewController alloc] init];
        [self presentViewController:homeVC animated:YES completion:^{
            
        }];
        
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"两次密码输入不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [self.view addSubview:alert];
        [alert show];
    }
    
    
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
