//
//  InputViewController.h
//  HealthAssistant
//
//  Created by zhezhewl on 16/11/21.
//  Copyright © 2016年 zcg. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "BaseViewController.h"
typedef void (^ReturnBlock)(NSString *date,NSString *high,NSString *low);

typedef enum inputState{
    HeartRate =0,
    BloodGlucose,
    BloodPressure
    
}InputState;


@interface InputViewController : BaseViewController

@property (nonatomic,strong)ReturnBlock returnBlock;
@property (nonatomic,assign)InputState ViewState;

- (void)returnData:(ReturnBlock)block;
@end
