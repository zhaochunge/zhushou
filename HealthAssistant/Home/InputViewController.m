//
//  InputViewController.m
//  HealthAssistant
//
//  Created by zhezhewl on 16/11/21.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import "InputViewController.h"
#import "TXHRrettyRuler.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface InputViewController ()<UITableViewDelegate,UITableViewDataSource,TXHRrettyRulerDelegate>

@property (nonatomic,strong)UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic,assign)NSInteger index;
@property (weak, nonatomic) IBOutlet UIView *upView;
@property (weak, nonatomic) IBOutlet UIView *downView;
@property (nonatomic,strong)TXHRrettyRuler *highRuler;
@property (nonatomic,strong)TXHRrettyRuler *lowRuler;
@property (weak, nonatomic) IBOutlet UILabel *highLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowLabel;

@property (weak, nonatomic) IBOutlet UIView *highLabelView;
@property (weak, nonatomic) IBOutlet UIView *lowLabelView;


//种类
@property (weak, nonatomic) IBOutlet UILabel *dataType;
//单位
@property (weak, nonatomic) IBOutlet UILabel *dataUnit;

@property (nonatomic,copy) NSString *highStr;
@property (nonatomic,copy) NSString *LowStr;
@property (nonatomic,copy) NSString *DateStr;
@property (nonatomic,assign) NSInteger timeNum;
@end

@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    self.backView.hidden = YES;
    

    self.DateStr = [self getDateHM];
    
    self.timeNum = [[NSDate date] timeIntervalSince1970];
    
    
    [self createView];
    
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.automaticallyAdjustsScrollViewInsets = YES;
//    self.navigationController.navigationBarHidden = YES;
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
//    self.navigationController.navigationBarHidden = NO;


}
- (void)createView{

    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 144) style:UITableViewStylePlain];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.scrollEnabled = NO;
    [self.view addSubview:self.myTableView];
    
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    self.backView.backgroundColor = RGBA(242, 242, 242, 1);
    
    
    //创建刻度尺
    
    
    
    self.highRuler = [[TXHRrettyRuler alloc] initWithFrame:CGRectMake(20, 0, ScreenWidth - 20 * 2, 60)];
    
    self.highRuler.layer.cornerRadius = 5.f;
    self.highRuler.layer.borderWidth = 1;
    
    self.highRuler.rulerDeletate = self;
    
    
    if (_ViewState == BloodPressure) {
        self.highLabel.text = @"100";
        self.lowLabel.text = @"100";
        self.highStr = @"100";
        self.LowStr = @"100";
        [self.highRuler showRulerScrollViewWithCount:200 average:[NSNumber numberWithFloat:1] currentValue:100.f smallMode:NO];
        [self.upView addSubview:self.highRuler];
    }
    


   
    
    if (_ViewState == BloodGlucose) {
        
        self.highLabel.text = @"5.0";
        self.highStr = @"5.0";
        
        [self.highRuler showRulerScrollViewWithCount:200.0 average:[NSNumber numberWithFloat:0.1] currentValue:5 smallMode:NO];
        [self.upView addSubview:self.highRuler];
        
        _dataType.text = @"血糖";
        _dataUnit.text = @"mmol/L";
        _lowLabelView.hidden = YES;
        
        return;
    }
    
    
    if (_ViewState == HeartRate) {
        [self.highRuler showRulerScrollViewWithCount:200 average:[NSNumber numberWithFloat:1] currentValue:100.f smallMode:NO];
        [self.upView addSubview:self.highRuler];
        _dataType.text = @"心率";
        _dataUnit.text = @"次/分钟";
        
        _lowLabelView.hidden = YES;
        
        
        return;
    }
    
    
    self.lowRuler = [[TXHRrettyRuler alloc] initWithFrame:CGRectMake(20, 0, ScreenWidth - 20 * 2, 60)];
    
    self.lowRuler.layer.cornerRadius = 5.f;
    self.lowRuler.layer.borderWidth = 1;
    
    self.lowRuler.rulerDeletate = self;
    
    [self.lowRuler showRulerScrollViewWithCount:200 average:[NSNumber numberWithFloat:1] currentValue:100.f smallMode:NO];
    
    
    [self.downView addSubview:self.lowRuler];

   
}

#pragma mark tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    
    if (indexPath.row == 2) {
        
        cell.textLabel.text = @"血压";
        cell.backgroundColor = RGBA(242, 242, 242, 1);
    }else{
    
    if (indexPath.row == 0) {
    
        cell.textLabel.text = @"日期";
        cell.detailTextLabel.text = [self getDateYMD];
    }else{
    
        cell.textLabel.text = @"测量时间";
        cell.detailTextLabel.text = [self getDateHM];
    }
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        return 44.f;
    }else{
    return 50.f;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    self.index = indexPath.row;
    
    if (indexPath.row == 0) {
        
        self.backView.hidden = NO;
        self.timePicker.datePickerMode = UIDatePickerModeDate;
        
    }
    
    if (indexPath.row == 1) {
        
        self.backView.hidden = NO;
        self.timePicker.datePickerMode = UIDatePickerModeTime;

        
    }

}

#pragma mark 获取时间

- (NSString *)getDateYMD{

    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    return  [dateFormatter stringFromDate:currentDate];
}

- (NSString *)getDateHM{

    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    return  [dateFormatter stringFromDate:currentDate];
    
    
}
#pragma mark action

- (IBAction)cancel:(id)sender {
    
    
    self.backView.hidden = YES;
}


- (IBAction)done:(id)sender {
    
    self.backView.hidden = YES;
    
    
    NSArray *typeArr = @[@"yyyy-MM-dd",@"HH:mm"];
    
        NSDate *select = [self.timePicker date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:typeArr[self.index]];
    UITableViewCell *cell = [self.myTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.index inSection:0]];
    
    cell.detailTextLabel.text = [dateFormatter stringFromDate:select];
    
    self.DateStr = [dateFormatter stringFromDate:select];
    self.timeNum = [select timeIntervalSince1970];
    
}

- (IBAction)backClick:(id)sender {
    
    
    DISMISS_VIEWCONTROLLER;
    
}


- (IBAction)backDone:(id)sender {
    
//    switch (_ViewState) {
//        case BloodPressure:
//        {
//            NSLog(@"血压");
//            [self upLoadWithfirstParameter:[_highStr integerValue] secParameter:[_LowStr integerValue] time:self.timeNum];
//        }
//            break;
//        case BloodGlucose:
//        {
//            NSLog(@"血糖");
//            
//            
//            [self upLoadWithfirstParameter:[_highStr integerValue] secParameter:0 time:self.timeNum];
//  
//            
//        }
//            break;
//            case HeartRate:
//            
//        {
//            [self upLoadWithfirstParameter:[_highStr integerValue] secParameter:0 time:self.timeNum];
//            NSLog(@"心率");
//        }
//        default:
//            break;
//    }
    
    

    [self upLoadWithfirstParameter:[_highStr integerValue] secParameter:[_LowStr integerValue] time:self.timeNum];


    self.returnBlock(self.DateStr,self.highStr,self.LowStr);
    
    DISMISS_VIEWCONTROLLER;
    
    
}

- (void)returnData:(ReturnBlock)block{

    self.returnBlock = block;
}

#pragma mark 刻度条



- (void)txhRrettyRuler:(TXHRulerScrollView *)rulerScrollView {
    
//    NSLog(@"%f",rulerScrollView.contentOffset.x);
//    
//    if (rulerScrollView.contentOffset.x <= 6 * 40 + 0.5) {
//        
//            rulerScrollView.contentOffset = CGPointMake(6 * 40+0.5, 0);
//
//    }
    
    
    if (rulerScrollView.superview == self.highRuler) {
        

        

        switch (_ViewState) {
            case BloodPressure:
            {
                self.highLabel.text = [NSString stringWithFormat:@"%.f",rulerScrollView.rulerValue];
                self.highStr = [NSString stringWithFormat:@"%.f",rulerScrollView.rulerValue];
            }
                break;
            case BloodGlucose:
            {
                self.highLabel.text = [NSString stringWithFormat:@"%.1f",rulerScrollView.rulerValue];
                self.highStr = [NSString stringWithFormat:@"%.1f",rulerScrollView.rulerValue];
            }
                break;
                
            case HeartRate:
            {
                self.highLabel.text = [NSString stringWithFormat:@"%.f",rulerScrollView.rulerValue];
                self.highStr = [NSString stringWithFormat:@"%.f",rulerScrollView.rulerValue];
            }
                break;
            default:
                break;
        }
    }
    
    if (rulerScrollView.superview == self.lowRuler) {
        
        self.lowLabel.text = [NSString stringWithFormat:@"%.f",rulerScrollView.rulerValue];
        self.LowStr = [NSString stringWithFormat:@"%.f",rulerScrollView.rulerValue];
    }
    
   
    
    
}

- (void)upLoadWithfirstParameter:(double)firstParameter secParameter:(double)secParameter time:(NSInteger)time{

    NSString *urlStr;
    
    switch (_ViewState) {
        case BloodPressure:
        {
            NSLog(@"血压");
            
            urlStr = [UrlString upBloodPressureWithloginName:USERDEFAULTS_GET(USER_LOGINNAME) highpressure:firstParameter lowpressure:secParameter time:time];
            
            
        }
            break;
        case BloodGlucose:
        {
            NSLog(@"血糖");
            
            urlStr = [UrlString upBloodglucoseWithloginName:USERDEFAULTS_GET(USER_LOGINNAME) bloodglucose:firstParameter time:time];
            
        }
            break;
        case HeartRate:
            
        {
            urlStr = [UrlString upHeartRateWithloginName:USERDEFAULTS_GET(USER_LOGINNAME) HeartRate:firstParameter time:time];
            NSLog(@"心率");
        }
        default:
            break;
    }

    
    
    
    
    
    [XHNetworking GET:urlStr parameters:nil success:^(id responseObject) {
        
        
    } failure:^(NSError *error) {
        
        
    }];
    


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
