//
//  CollectionViewCell.m
//  HealthAssistant
//
//  Created by zhezhewl on 16/11/30.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end


@implementation BloodGucoseCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"BloodGucoseCollectionCell";
    
    UINib *nib = [UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle mainBundle]];
    
    [collectionView registerNib:nib forCellWithReuseIdentifier:Identifier];
    
    

    BloodGucoseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    

    return cell;
}


@end



