//
//  BaseViewController.h
//  HealthAssistant
//
//  Created by zhezhewl on 16/11/22.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
- (void)takePhotos;
- (void)alertViewWith:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles;
- (void)alertViewWith:(NSString *)title message:(NSString *)message;

@end
