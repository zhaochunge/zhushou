//
//  UIBarButtonItem+KM.h
//  ElectricCompany
//
//  Created by 松宇 on 15/9/6.
//  Copyright (c) 2015年 songyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (KM)
/**
 *  通过图片创建item
 *
 *  @param image     图片
 *  @param highImage 高亮图片
 *  @param action    点击后调用的方法
 */
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
+ (instancetype)itemWithImages:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

/**
 *  通过文字创建item
 *
 *  @param title  名称
 *  @param target self
 *  @param action 监听方法
 *
 *  @return navigationItem
 */
+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
 *  创建图片和文字按钮
 *
 *  @param image  图片
 *  @param title  文字
 *  @param target self
 *  @param action 监听方法
 *
 *  @return navigationItem
 */
+ (instancetype)itemWithImage:(NSString *)image title:(NSString *)title target:(id)target action:(SEL)action;
@end
