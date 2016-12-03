//
//  heartRateViewController.m
//  HealthAssistant
//
//  Created by zhezhewl on 16/11/22.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import "heartRateViewController.h"

@interface heartRateViewController ()
@property (weak, nonatomic) IBOutlet PNLineChartView *lineChartView;
@property (nonatomic, strong)SHLineGraphView *lineGraph;
@property (nonatomic, strong)NSMutableArray *xAxisValues;
@property (nonatomic, strong)NSMutableArray *plottingValues;
@end

@implementation heartRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"心率图";
    
    [self createData];
}

- (void)createData{

    
    
    _xAxisValues = [NSMutableArray array];
    
    _plottingValues = [NSMutableArray array];
    
    [XHNetworking GET:[UrlString getHeartRateWithLoginName:USERDEFAULTS_GET(USER_LOGINNAME)] parameters:nil success:^(id responseObject) {
       
        
        
        if ([responseObject[@"status"] integerValue] == 1) {
            
            [self hideHUD];
            
            int i = 0;
            
            for (NSDictionary *dic in responseObject[@"content"]) {
                
                i++;
                
                NSDictionary *temp1 = @{[NSString stringWithFormat:@"%d",i] : [dic[@"createtime"] substringWithRange:NSMakeRange(5, 5)]};
                
                NSDictionary *temp2 = @{[NSString stringWithFormat:@"%d",i] : dic[@"heartRate"]};
                
                
                
                [self.xAxisValues addObject:temp1];
                [self.plottingValues addObject:temp2];
            }
            
            [self createView];
            
        }

        
        
        
        
    } failure:^(NSError *error) {
        
        
    }];



}

- (void)createView{
    if (_xAxisValues.count <= 6) {
        _lineGraph = [[SHLineGraphView alloc] initWithFrame:CGRectMake(0, 90, ScreenWidth, 480)];
        
    }else{
        _lineGraph = [[SHLineGraphView alloc] initWithFrame:CGRectMake(0, 90, ScreenWidth/6*[_xAxisValues count], 480)];
        
    }
    _lineGraph.backgroundColor = [UIColor clearColor];
    
    NSDictionary *_themeAttributes = @{
                                       kXAxisLabelColorKey : [UIColor colorWithRed:0 green:0 blue:0 alpha:1],
                                       kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:15],
                                       kYAxisLabelColorKey : [UIColor colorWithRed:0 green:0 blue:0 alpha:1],
                                       kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:15],
                                       kYAxisLabelSideMarginsKey : @20,
                                       kPlotBackgroundLineColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0],
                                       kDotSizeKey : @10
                                       };
    _lineGraph.themeAttributes = _themeAttributes;
    
    
    _lineGraph.yAxisRange = @(100);
    _lineGraph.minY = 0;
    _lineGraph.intervalCount = 10;

    _lineGraph.yAxisSuffix = @"";
    _lineGraph.OnlyOne = YES;

    _lineGraph.xAxisValues = _xAxisValues;

    SHPlot *_plot1 = [[SHPlot alloc] init];
    
    _plot1.plottingValues = _plottingValues;
    
    
    
    
    NSMutableArray *arr = [NSMutableArray array];
    
    int i = 0;
    for (NSDictionary *dic in _plottingValues) {
        
        i++;
        NSString *str = [NSString stringWithFormat:@"%@",dic[[NSString stringWithFormat:@"%d",i]]];
        
        [arr addObject:str];
        
    }
    
    _plot1.plottingPointsLabels = arr;

    //背景色,折线宽度,折线颜色,原点颜色
    NSDictionary *_plotThemeAttributes = @{
                                           kPlotFillColorKey : [UIColor colorWithRed:0.47 green:0.75 blue:0.78 alpha:0.5],
                                           kPlotStrokeWidthKey : @1,
                                           kPlotStrokeColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                           kPlotPointFillColorKey : [UIColor colorWithRed:1 green:1 blue:1 alpha:1],
                                           kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]
                                           };
    
    _plot1.plotThemeAttributes = _plotThemeAttributes;
    [_lineGraph addPlot:_plot1];
    
    //You can as much `SHPlots` as you can in a `SHLineGraphView`
    
    [_lineGraph setupTheView];
    
    [self.view addSubview:_lineGraph];


}

- (IBAction)TakePhoto:(id)sender {
    
    [self takePhotos];
     
    
}

- (IBAction)input:(id)sender {
    
    InputViewController *vc = [InputViewController new];
    
    vc.ViewState = HeartRate;
    
    PRESENT_VIEWCONTROLLER(vc, YES);
    [vc returnData:^(NSString *date, NSString *high, NSString *low) {
        [_lineGraph removeFromSuperview];
        
        [self createData];
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSeg	ue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
