//
//  SettingTableViewCell.m
//  HealthAssistant
//
//  Created by zhezhewl on 16/11/23.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *Identifier = @"SettingTableViewCell";
    
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SettingTableViewCell" owner:self options:nil] firstObject];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


@implementation ExplainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *Identifier = @"ExplainTableViewCell";
    
    ExplainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"SettingTableViewCell" owner:self options:nil][1];
    }
    return cell;

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


@implementation SwitchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *Identifier = @"SwitchTableViewCell";
    
    SwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"SettingTableViewCell" owner:self options:nil][2];
    }
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
