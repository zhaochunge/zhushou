//
//  UIView+KM.h
//  ElectricCompany
//
//  Created by 松宇 on 15/9/6.
//  Copyright (c) 2015年 songyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KM)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

/**
 *  视图出现
 */
- (void)viewDidAppearsFadeIn;

/**
 *  视图消失
 */
- (void)viewDidDisAppearsFadeOut;

/**
 *  视图从底部出现
 */
- (void)viewDidAppearsFromBottom;

/**
 *  视图从底部消失
 */
- (void)viewDidDisAppearsFromBottom;

/**
 *  约束动画
 */
- (void)constrantAnimate;

/**
 *  写圆角
 */
- (void)roundedCornersRadius:(CGFloat)radius;


@end
