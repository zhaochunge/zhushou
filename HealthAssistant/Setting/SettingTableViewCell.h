//
//  SettingTableViewCell.h
//  HealthAssistant
//
//  Created by zhezhewl on 16/11/23.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

@interface ExplainTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

@interface SwitchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *upLable;

@property (weak, nonatomic) IBOutlet UILabel *downLable;

@property (weak, nonatomic) IBOutlet UISwitch *cellSwitch;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

@interface BloodGlucoseTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *data1;

@property (weak, nonatomic) IBOutlet UILabel *data2;

@property (weak, nonatomic) IBOutlet UILabel *data3;

@property (weak, nonatomic) IBOutlet UILabel *data4;

@property (weak, nonatomic) IBOutlet UILabel *data5;

@property (weak, nonatomic) IBOutlet UILabel *data6;

@property (weak, nonatomic) IBOutlet UILabel *data7;

@property (weak, nonatomic) IBOutlet UILabel *data8;


+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
