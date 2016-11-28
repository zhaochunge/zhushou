//
//  BloodPressureViewController.m
//  HealthAssistant
//
//  Created by zhezhewl on 16/11/23.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import "BloodPressureViewController.h"

@interface BloodPressureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;


@property (nonatomic ,strong)NSMutableArray *xAxisValues;
@property (nonatomic ,strong)NSMutableArray *plottingValues;
@property (nonatomic ,strong)NSMutableArray *SecPlottingValues;

@property (nonatomic ,strong)NSMutableArray *high;
@property (nonatomic ,strong)NSMutableArray *low;

@property (nonatomic, strong)SHLineGraphView *lineGraph;
@property (nonatomic, strong)SHPlot *plot;
@end

@implementation BloodPressureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"血压图";
    
    _xAxisValues = [NSMutableArray array];
    _plottingValues = [NSMutableArray array];
    _SecPlottingValues = [NSMutableArray array];
    _high = [NSMutableArray array];
    _low = [NSMutableArray array];
    [self createData];

}


- (void)createData{
    
    
    
    
    [XHNetworking GET:[UrlString getBloodPressureWithLoginName:USERDEFAULTS_GET(USER_LOGINNAME)] parameters:nil success:^(id responseObject) {
        
        
        if ([responseObject[@"status"] integerValue] == 1) {
            
        
        
        int i = 0;
        
        for (NSDictionary *dic in responseObject[@"content"]) {
            
            i++;
            
            NSDictionary *temp1 = @{[NSString stringWithFormat:@"%d",i] : [dic[@"createtime"] substringToIndex:10]};
            NSDictionary *temp2 = @{[NSString stringWithFormat:@"%d",i] : @([dic[@"highpressure"] integerValue])};
            NSDictionary *temp3 = @{[NSString stringWithFormat:@"%d",i] : @([dic[@"lowpressure"] integerValue])};
            
            
            [self.xAxisValues addObject:temp1];
            [self.plottingValues addObject:temp2];
            [self.SecPlottingValues addObject:temp3];
        }

            [self createView];

        }
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
    
    
//    
//    
//    
//    
//    
//
//    _xAxisValues = [NSMutableArray arrayWithObjects:@{ @"1" : @"11/16" },
//                    @{ @"2" : @"11/17" },
//                    @{ @"3" : @"11/18" },
//                    @{ @"4" : @"11/19" },
//                    @{ @"5" : @"11/20" },
//                    @{ @"6" : @"今天" },
//                    @{ @"7" : @"明天"},
//                    @{ @"8" : @"后天" },
//                    @{ @"9" : @"大后天"},
//                    @{ @"10" : @"阿萨德"}, nil];
//    
//    
//    _plottingValues = [NSMutableArray arrayWithObjects:@{ @"1" : @107 },
//                       @{ @"2" : @95 },
//                       @{ @"3" : @120 },
//                       @{ @"4" : @112 },
//                       @{ @"5" : @164 },
//                       @{ @"6" : @104 },
//                       @{ @"7" : @99},
//                       @{ @"8" : @139},
//                       @{ @"9" : @146},
//                       @{ @"10" : @130}, nil];
//    
//    _SecPlottingValues = [NSMutableArray arrayWithObjects:@{ @"1" : @60 },
//                          @{ @"2" : @85 },
//                          @{ @"3" : @70 },
//                          @{ @"4" : @60 },
//                          @{ @"5" : @83 },
//                          @{ @"6" : @79 },
//                          @{ @"7" : @89},
//                          @{ @"8" : @89},
//                          @{ @"9" : @99},
//                          @{ @"10" : @70}, nil];

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
    
    
    _lineGraph.yAxisRange = @(180);
    _lineGraph.minY = 50;
    _lineGraph.yAxisSuffix = @"";


    _lineGraph.xAxisValues = _xAxisValues;
    

    
    _plot = [[SHPlot alloc] init];

    _plot.plottingValues = _plottingValues;
    
    

    _plot.SecPlottingValues = _SecPlottingValues;
    


    
    int i = 0;
    for (NSDictionary *dic in _plottingValues) {
        
        i++;
        
        NSString *str = [NSString stringWithFormat:@"%@",dic[[NSString stringWithFormat:@"%d",i]]];
        
        [_high addObject:str];
        
    }
    
    int k = 0;
    for (NSDictionary *dic in _SecPlottingValues) {
        
        k++;

        [_low addObject: [NSString stringWithFormat:@"%@",dic[[NSString stringWithFormat:@"%d",k]]]];
        
    }

    
    _plot.plottingPointsLabels = _high;
    
    _plot.SecplottingPointsLabels = _low;
    NSDictionary *_plotThemeAttributes = @{
                                           kPlotFillColorKey : [UIColor colorWithRed:0.47 green:0.75 blue:0.78 alpha:0],
                                           kPlotStrokeWidthKey : @1,
                                           kPlotStrokeColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                           kPlotPointFillColorKey : [UIColor colorWithRed:1 green:1 blue:1 alpha:1],
                                           kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]
                                           };
    
    _plot.plotThemeAttributes = _plotThemeAttributes;
    [_lineGraph addPlot:_plot];
    
    //You can as much `SHPlots` as you can in a `SHLineGraphView`
    
    [_lineGraph setupTheView];
    
    [self.view addSubview:_lineGraph];
    
    
}

- (IBAction)TakePhoto:(id)sender {
    
    [self takePhotos];

}

- (IBAction)Input:(id)sender {
    
    InputViewController *vc = [InputViewController new];
    
    vc.ViewState = BloodPressure;
    
    PRESENT_VIEWCONTROLLER(vc, YES);
    
    [vc returnData:^(NSString *date, NSString *high, NSString *low) {

        
        
        [_xAxisValues addObject:@{@(_xAxisValues.count + 1): date}];
//        _lineGraph.xAxisValues = _xAxisValues;
        
        [_plottingValues addObject:@{@(_plottingValues.count + 1) : high}];
//        _plot.plottingValues = _plottingValues;
        
        [_SecPlottingValues addObject:@{@(_SecPlottingValues.count +1):low}];
        
//        _plot.SecPlottingValues = _SecPlottingValues;
        
        [_high addObject:high];
        [_low addObject:low];
        
        
        
        
        [_lineGraph removeFromSuperview];
        [self createView];
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
