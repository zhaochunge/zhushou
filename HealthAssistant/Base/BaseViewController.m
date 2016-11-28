//
//  BaseViewController.m
//  HealthAssistant
//
//  Created by zhezhewl on 16/11/22.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIImagePickerControllerDelegate>

@property (nonatomic,strong)UIImagePickerController *pickerController;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)takePhotos{
    
    _pickerController = [UIImagePickerController new];
    
    _pickerController.delegate = self;
    _pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    PRESENT_VIEWCONTROLLER(_pickerController, YES);


}


- (void)alertViewWith:(NSString *)title
              message:(NSString *)message
             delegate:(id)delegate
    cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSString *)otherButtonTitles{

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    
    [alert show];
}

- (void)alertViewWith:(NSString *)title message:(NSString *)message{

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    [alert show];

}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [_pickerController dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];

}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [_pickerController dismissViewControllerAnimated:YES completion:nil];

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



-(void)didReceiveMemoryWarning {
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