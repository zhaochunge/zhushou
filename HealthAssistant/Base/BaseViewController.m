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
