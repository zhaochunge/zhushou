//
//  BaseViewController.h
//  HealthAssistant
//
//  Created by zhezhewl on 16/11/22.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum inputState{
    HeartRate =0,
    BloodGlucose,
    BloodPressure
    
}InputState;

@interface BaseViewController : UIViewController
- (void)takePhotos;
- (void)alertViewWith:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles;
- (void)alertViewWith:(NSString *)title message:(NSString *)message;
- (BOOL) isMobile:(NSString *)mobileNumbel;

- (void)showHUDtoView:(nullable UIView *)view msg:(nullable NSString *)msg animated:(BOOL)animated;
- (void)hideHUD;

@property (nonatomic, assign)InputState upStates;

@end
