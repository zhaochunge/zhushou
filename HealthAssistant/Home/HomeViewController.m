//
//  HomeViewController.m
//  HealthAssistant
//
//  Created by Mac on 16/11/18.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import "HomeViewController.h"
#import "WLCircleProgressView.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface HomeViewController ()

@property (nonatomic, strong) WLCircleProgressView *progressView;

@property(nonatomic,strong)UILabel *healthLabel;
@property(nonatomic,assign)int i;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _i = 0;
    [self createheadView];
    [self bottomBtn];

}

-(void)createheadView{
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    headLabel.text = @"主页";
    headLabel.font = [UIFont systemFontOfSize:19];
    headLabel.textAlignment = YES;
    headLabel.textColor = [UIColor whiteColor];
    headLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:104/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:headLabel];
    //背景
    UIView *ground = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT/21*14)];
    ground.backgroundColor = [UIColor colorWithRed:0/255.0 green:146/255.0 blue:227/255.0 alpha:1];
    [self.view addSubview:ground];
    //测量
    UIButton *measureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [measureBtn setTitle:@"去测量" forState:UIControlStateNormal];
    measureBtn.font = [UIFont systemFontOfSize:20];
    [measureBtn setTintColor:[UIColor whiteColor]];
    measureBtn.layer.masksToBounds = YES;
    measureBtn.layer.cornerRadius = 20;
    measureBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    measureBtn.layer.borderWidth = 1;
    measureBtn.frame = CGRectMake(WIDTH/2-75, HEIGHT/21*11, 150, 40);
    [ground addSubview:measureBtn];
    
    //圆形加载条
    WLCircleProgressView *circleProgress = [WLCircleProgressView viewWithFrame:CGRectMake(WIDTH/2-100, HEIGHT/5, 200, 200)
                                                                    circlesSize:CGRectMake(100, 10, 100, 10)];
    circleProgress.layer.cornerRadius = 10;
    circleProgress.progressValue = 0.2;
    [self.view addSubview:circleProgress];
    self.progressView = circleProgress;
    self.progressView.progressValue = 0.01;
    
    //健康指数
    self.healthLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 85, 140, 30)];
    self.healthLabel.text = @"今日健康指数";
    _healthLabel.font = [UIFont systemFontOfSize:19];
    _healthLabel.textColor = [UIColor whiteColor];
    _healthLabel.textAlignment = YES;
    [circleProgress addSubview:_healthLabel];
//    [self createData];
    

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _healthLabel.text = @"98%";
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        if (_i<100) {
            _i++;
            self.progressView.progressValue = _i*0.01;
        }
        
    }];
//    for (int i=0; i<98; i++) {
////        [UIView animateWithDuration:100 delay:5 options:1 animations:^{
//            self.progressView.progressValue = i*0.01;
////        } completion:^(BOOL finished) {
//        
////        }];
//        //        self.progressView.progressValue = i*0.01;
//        
//    }

}
#pragma mark 数据解析
-(void)createData{
    _healthLabel.text = @"98%";
    for (int i=0; i<98; i++) {
        [UIView animateWithDuration:3 delay:1 options:1 animations:^{
            self.progressView.progressValue = i*0.01;
        } completion:^(BOOL finished) {
            
        }];
//        self.progressView.progressValue = i*0.01;
        
    }
   
}
#pragma mark 底部button
-(void)bottomBtn{
    UIButton *pressure = [UIButton buttonWithType:UIButtonTypeCustom];
    pressure.frame = CGRectMake(50, HEIGHT/21*14+10+64, WIDTH/6, WIDTH/6);
    pressure.layer.masksToBounds = YES;
    pressure.layer.cornerRadius = WIDTH/12;
    pressure.backgroundColor = [UIColor blueColor];
    [self.view addSubview:pressure];
   
    UIButton *suger = [UIButton buttonWithType:UIButtonTypeCustom];
    suger.frame = CGRectMake(WIDTH/2-WIDTH/12, HEIGHT/21*14+10+64, WIDTH/6, WIDTH/6);
    suger.layer.masksToBounds = YES;
    suger.layer.cornerRadius = WIDTH/12;
    [self.view addSubview:suger];
    suger.backgroundColor = [UIColor blueColor];

    UIButton *rate = [UIButton buttonWithType:UIButtonTypeCustom];
    rate.frame = CGRectMake(WIDTH-50-WIDTH/6, HEIGHT/21*14+10+64, WIDTH/6, WIDTH/6);
    rate.layer.masksToBounds = YES;
    rate.layer.cornerRadius = WIDTH/12;
    [self.view addSubview:rate];
    rate.backgroundColor = [UIColor blueColor];

    
    
    UILabel *pressureLabel = [UILabel new];
    pressureLabel.frame = CGRectMake(50, HEIGHT/21*14+15+WIDTH/6+64, WIDTH/6, 20);
    pressureLabel.text = @"血压";
    pressureLabel.font = [UIFont systemFontOfSize:12];
    pressureLabel.textAlignment = YES;
    [self.view addSubview:pressureLabel];
    
    UILabel *sugerLabel = [UILabel new];
    sugerLabel.frame = CGRectMake(WIDTH/2-30, HEIGHT/21*14+15+WIDTH/6+64, 60, 20);
    sugerLabel.text = @"血糖";
    sugerLabel.font = [UIFont systemFontOfSize:12];
    sugerLabel.textAlignment = YES;
    [self.view addSubview:sugerLabel];
    
    UILabel *rateLabel = [UILabel new];
    rateLabel.frame = CGRectMake(WIDTH-WIDTH/6-50, HEIGHT/21*14+15+WIDTH/6+64, WIDTH/6, 20);
    rateLabel.text = @"心率";
    rateLabel.font = [UIFont systemFontOfSize:12];
    rateLabel.textAlignment = YES;
    [self.view addSubview:rateLabel];

    UILabel *pressureText = [[UILabel alloc] initWithFrame:CGRectMake(50, HEIGHT/21*14+15+WIDTH/6+64+20, WIDTH/6, 20)];
    pressureText.text = @"--";
    pressureText.textAlignment = YES;
    [self.view addSubview:pressureText];
    
    UILabel *sugerText = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2-30, HEIGHT/21*14+15+WIDTH/6+64+20, 60, 20)];
    sugerText.text = @"--";
    sugerText.textAlignment = YES;
    [self.view addSubview:sugerText];

    UILabel *rateText = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH-WIDTH/6-50, HEIGHT/21*14+15+WIDTH/6+64+20, WIDTH/6, 20)];
    rateText.text = @"--";
    rateText.textAlignment = YES;
    [self.view addSubview:rateText];
    
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
