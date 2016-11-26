//
//  SettingViewController.m
//  HealthAssistant
//
//  Created by zhezhewl on 16/11/23.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"设置";
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 3;
    }else{
    
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            
            SettingTableViewCell *cell = [SettingTableViewCell cellWithTableView:tableView];
            
            cell.textLabel.text = @"手动同步";
            
            return cell;
        }
        
        if (indexPath.row == 1){
        
            SwitchTableViewCell *cell = [SwitchTableViewCell cellWithTableView:tableView];
            
            cell.upLable.text = @"手动同步";
            
            cell.downLable.text = @"上次同步时间";
            
            [cell.cellSwitch setOn:YES];
            cell.upLable.hidden = NO;
            cell.downLable.hidden = NO;
            return cell;

        }
        
        if (indexPath.row == 2) {
            ExplainTableViewCell *cell = [ExplainTableViewCell cellWithTableView:tableView];
            return cell;

        }
        
    }else{
        
        if (indexPath.row == 0) {
            SwitchTableViewCell *cell = [SwitchTableViewCell cellWithTableView:tableView];

            cell.textLabel.text = @"在通知栏显示步数";
            return cell;

        }
        if (indexPath.row == 1) {
            SwitchTableViewCell *cell = [SwitchTableViewCell cellWithTableView:tableView];

            cell.textLabel.text = @"语音播报";
            return cell;


        }
        else{
        
            SettingTableViewCell *cell = [SettingTableViewCell cellWithTableView:tableView];

            
            NSArray *arr = @[@"在通知栏显示步数",@"语音播报",@"离线地图",@"检测更新",@"关于"];
            
            cell.textLabel.text = arr[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            return cell;
            
        }
      
    }
    
    
    
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                return 44;
                break;
            case 1:
                return 60;
            break;
            case 2:
                return 90;
                break;
            default:
                break;
                return 0;
        }
    }else{
    
        return 44;
    }
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return @"数据同步";
    }else{
        return @"其他";
        }
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
