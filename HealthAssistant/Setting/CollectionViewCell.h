//
//  CollectionViewCell.h
//  HealthAssistant
//
//  Created by zhezhewl on 16/11/30.
//  Copyright © 2016年 zcg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@end

@interface BloodGucoseCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@end
