//
//  UIImage+KM.m
//  QQ音乐DIY版
//
//  Created by 松宇 on 15/9/17.
//  Copyright (c) 2015年 songyu. All rights reserved.
//

#import "UIImage+KM.h"

@implementation UIImage (KM)

+ (UIImage *)imageWithName:(NSString *)name
{
    // 0.需要返回的图片
    UIImage *image = nil;
    
    // 1.加载图片
    NSString *ios7Name = [name stringByAppendingString:@"_os7"];
    image = [self imageNamed:ios7Name];
    
    // 2.图片不存在
    if (image == nil) {
        image = [self imageNamed:name];
    }
    
    return image;
}

+ (UIImage *)resizableImage:(NSString *)name
{
    return [self resizableImage:name leftRatio:0.5 topRatio:0.5];
}

+ (UIImage *)resizableImage:(NSString *)name leftRatio:(CGFloat)leftRatio topRatio:(CGFloat)topRatio
{
    UIImage *image = [self imageWithName:name];
    CGFloat left = image.size.width * leftRatio;
    CGFloat top = image.size.height * topRatio;
    return [image stretchableImageWithLeftCapWidth:left topCapHeight:top];
}

@end
