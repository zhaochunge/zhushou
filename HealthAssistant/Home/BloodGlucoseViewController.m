//
//  BloodGlucoseViewController.m
//  HealthAssistant
//
//  Created by zhezhewl on 16/11/23.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import "BloodGlucoseViewController.h"

@interface BloodGlucoseViewController ()

@property (nonatomic,strong)NSMutableArray *xAxisValues;
@property (nonatomic,strong)NSMutableArray *plottingValues;

@end

@implementation BloodGlucoseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"血糖图";
    
    self.xAxisValues = [NSMutableArray array];
    
    self.plottingValues = [NSMutableArray array];
    
    self.xAxisValues = [NSMutableArray arrayWithObjects:@{@"1":@"11.26"},@{@"2":@"11.27"}, nil];
    
    self.plottingValues = [NSMutableArray arrayWithObjects:@{@"1":@4.36},@{@"2":@5.28}, nil];
    
    
    [self createData];
    [self createView];
    
}


- (void)createData{

    [XHNetworking GET:[UrlString getBloodglucoseWithLoginName:USERDEFAULTS_GET(USER_LOGINNAME)] parameters:nil success:^(id responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 1) {
            
        
        
        int i = 0;
        
        for (NSDictionary *dic in responseObject[@"content"]) {
            
            i++;
            
            NSDictionary *temp1 = @{[NSString stringWithFormat:@"%d",i] : dic[@"createtime"]};
            
            NSDictionary *temp2 = @{[NSString stringWithFormat:@"%d",i] : dic[@"bloodglucose"]};
            
            
            
            [self.xAxisValues addObject:temp1];
            [self.plottingValues addObject:temp2];
        }
        
        
        }
        
    } failure:^(NSError *error) {
        
        
    }];



}





- (void)createView{
    
    SHLineGraphView *_lineGraph = [[SHLineGraphView alloc] initWithFrame:CGRectMake(0, 90, ScreenWidth, 480)];
    _lineGraph.backgroundColor = [UIColor clearColor];
    
    NSDictionary *_themeAttributes = @{
                                       kXAxisLabelColorKey : [UIColor colorWithRed:0 green:0 blue:0 alpha:1],
                                       kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:15],
                                       kYAxisLabelColorKey : [UIColor colorWithRed:0 green:0 blue:0 alpha:1],
                                       kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:15],
                                       kYAxisLabelSideMarginsKey : @20,
                                       kPlotBackgroundLineColorKey : [UIColor colorWithRed:0 green:0 blue:0 alpha:0],
                                       kDotSizeKey : @10
                                       };
    _lineGraph.themeAttributes = _themeAttributes;
    
    
    _lineGraph.yAxisRange = @(10);
    _lineGraph.minY = 1;
    _lineGraph.yAxisSuffix = @"";
    
    _lineGraph.xAxisValues = _xAxisValues;
//    _lineGraph.xAxisValues = @[@{@"1":@"11.26"},@{@"2":@"11.27"}];

    
    SHPlot *_plot1 = [[SHPlot alloc] init];
    
    _plot1.plottingValues = _plottingValues;
//    _plot1.plottingValues = @[@{@"1":@4.36},@{@"2":@5.28}];

    
    
    NSMutableArray *arr = [NSMutableArray array];
    
    int i = 0;
    for (NSDictionary *dic in _plottingValues) {
        
        i++;
        NSNumber *num = dic[[NSString stringWithFormat:@"%d",i]];
        
        NSString *str = [NSString stringWithFormat:@"%@",num];
        
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

- (IBAction)Input:(id)sender {
    
    InputViewController *vc = [InputViewController new];
    
    vc.ViewState = BloodGlucose;
    
    
    PRESENT_VIEWCONTROLLER(vc, YES);
    
    [vc returnData:^(NSString *date, NSString *high, NSString *low) {
        
        
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
