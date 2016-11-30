//
//  BloodGlucoseViewController.m
//  HealthAssistant
//
//  Created by zhezhewl on 16/11/23.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import "BloodGlucoseViewController.h"
#import "SettingTableViewCell.h"
#import "CollectionViewCell.h"
@interface BloodGlucoseViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic, strong)SHLineGraphView *lineGraph;
@property (nonatomic, strong)NSMutableArray *xAxisValues;
@property (nonatomic, strong)NSMutableArray *plottingValues;
@property (nonatomic, strong)NSMutableArray *BloodGlucoseType;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIView *selectView;

@property (weak, nonatomic) IBOutlet UITableView *bloodGlucoseTableView;

@property (weak, nonatomic) IBOutlet UIPageControl *BloodGlucoseIndex;


@end

@implementation BloodGlucoseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"血糖图";
    
    self.xAxisValues = [NSMutableArray array];
    
    self.plottingValues = [NSMutableArray array];
    
    self.BloodGlucoseType = [NSMutableArray arrayWithObjects:@"凌晨",@"早餐前",@"早餐后",@"午餐前",@"午餐后",@"晚餐前",@"晚餐后",@"睡前", nil];
    
    
    
    
    
//    [self createData];
    
    [self createTable];
    
}


- (IBAction)tapHide:(id)sender {
    
    
    self.backView.hidden = YES;
    
    self.selectView.hidden = YES;
    
    
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    NSInteger index = scrollView.contentOffset.x/(ScreenWidth - 30);
    
    _BloodGlucoseIndex.currentPage = index;
}

#pragma mark collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    

        return _BloodGlucoseType.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BloodGucoseCollectionCell *cell = [BloodGucoseCollectionCell cellWithCollectionView:collectionView indexPath:indexPath];
    
    cell.timeLable.text = _BloodGlucoseType[indexPath.row];
    
    
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

        return CGSizeMake(ScreenWidth-30, 200);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    self.backView.hidden = YES;
    
    self.selectView.hidden = YES;
    
    
    InputViewController *vc = [InputViewController new];
    
    vc.ViewState = BloodGlucose;
    
    
    PRESENT_VIEWCONTROLLER(vc, YES);
    
    [vc returnData:^(NSString *date, NSString *high, NSString *low) {
        //        [_lineGraph removeFromSuperview];
        
        //        [self createData];
        
    }];

}

#pragma Mark tableView-delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    BloodGlucoseTableViewCell *cell = [BloodGlucoseTableViewCell cellWithTableView:tableView];
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
    
    
}





- (void)createTable{


    
    
    
}


- (void)createData{
    [self showHUDtoView:self.view msg:@"加载中" animated:YES];

    
    [self.xAxisValues removeAllObjects];
    [self.plottingValues removeAllObjects];
    
    
    
    

    [XHNetworking GET:[UrlString getBloodglucoseWithLoginName:USERDEFAULTS_GET(USER_LOGINNAME)] parameters:nil success:^(id responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 1) {
            
            [self hideHUD];
        
//        int i = 0;
//        
//        for (NSDictionary *dic in responseObject[@"content"]) {
//            
//            i++;
//            
//            NSDictionary *temp1 = @{[NSString stringWithFormat:@"%d",i] : [dic[@"createtime"] substringWithRange:NSMakeRange(5, 5)]};
//            
//            NSDictionary *temp2 = @{[NSString stringWithFormat:@"%d",i] : dic[@"bloodglucose"]};
//            
//            
//            
//            [self.xAxisValues addObject:temp1];
//            [self.plottingValues addObject:temp2];
//        }
        
//            [self createView];

        }
        
        
    } failure:^(NSError *error) {
        
        
    }];

    UILabel *lable = [UILabel new];
    
    
    lable.layer.borderWidth = 1;
    

}




#pragma mark 拍照
- (IBAction)TakePhoto:(id)sender {
    [self takePhotos];

}

#pragma mark 手动输入
- (IBAction)Input:(id)sender {
    
    self.backView.hidden = NO;
    
    self.selectView.hidden = NO;
    
    
    
    
    
    return;
    


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
                                       kPlotBackgroundLineColorKey : [UIColor colorWithRed:0 green:0 blue:0 alpha:0],
                                       kDotSizeKey : @10
                                       };
    _lineGraph.themeAttributes = _themeAttributes;
    
    
    _lineGraph.yAxisRange = @(10);
    _lineGraph.minY = 0;
    _lineGraph.intervalCount = 10;
    _lineGraph.OnlyOne = YES;
    _lineGraph.yAxisSuffix = @"";
    
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
