//
//  UIColor+XMColor.h
//  多巴兔
//
//  Created by 郭建斌 on 15/9/21.
//  Copyright © 2015年 郭建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XMColor)

/**
 *  将16进制字符串转换成UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alph;
/**
 *  返回随机颜色
 */
+(instancetype)randColor;

@end
