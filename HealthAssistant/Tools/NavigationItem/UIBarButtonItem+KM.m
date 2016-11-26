//
//  UIBarButtonItem+KM.m
//  ElectricCompany
//
//  Created by 松宇 on 15/9/6.
//  Copyright (c) 2015年 songyu. All rights reserved.
//

#import "UIBarButtonItem+KM.h"
#import "UIImage+KM.h"
#import "UIView+KM.h"

@implementation UIBarButtonItem (KM)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.size = CGSizeMake(26, 26);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (instancetype)itemWithImages:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.size = CGSizeMake(39, 20);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.size = CGSizeMake(30, 45);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (instancetype)itemWithImage:(NSString *)image title:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *btn = [[UIButton alloc] init];
    btn.size = CGSizeMake(50, 44);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, btn.imageView.image.size.width)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.titleLabel.bounds.size.width + 13, 0, -btn.titleLabel.bounds.size.width)];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end

