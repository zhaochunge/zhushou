//
//  UIView+KM.m
//  ElectricCompany
//
//  Created by 松宇 on 15/9/6.
//  Copyright (c) 2015年 songyu. All rights reserved.
//

#import "UIView+KM.h"

#define kBottomAnimation ScreenHeight - 349

@implementation UIView (KM)

#pragma mark -
#pragma mark - 视图出现
- (void)viewDidAppearsFadeIn {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.8f;
    }];
    
}

#pragma mark -
#pragma mark - 视图消失
- (void)viewDidDisAppearsFadeOut {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

#pragma mark -
#pragma mark - 视图从底部出现
- (void)viewDidAppearsFromBottom {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.y -= kBottomAnimation;
    }];
    
}

- (void)viewDidDisAppearsFromBottom {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.y += kBottomAnimation;
    }completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }];
}

#pragma mark -
#pragma mark - 约束动画

- (void)constrantAnimate {
    
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}

#pragma mark -
#pragma mark - 写圆角

- (void)roundedCornersRadius:(CGFloat)radius{
    
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds= YES;
    
}



- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}




@end
