//
//  UIColor+BSExt.h
//  BigStrongExtKit
//
//  Created by 董富强 on 15/8/19.
//  Copyright (c) 2015年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BSExt)

/**
 * @brief 字符串中得到颜色值
 *
 * @param stringToConvert 字符串的值 e.g:@"#FF4500"
 *
 * @return 返回颜色对象
 */
+ (UIColor *)colorFromString_Ext:(NSString *)stringToConvert;


/**
 * @brief RGBA风格获取颜色，
 * UIColor *solidColor = [UIColor colorWithRGBA_Ext:0xFF0000FF];
 *
 * @param hex 是16进止rgba值
 *
 * @return 颜色对象
 */
+ (UIColor *) colorWithRGBA_Ext:(uint) hex;


/**
 * @brief ARGB风格获取颜色
 * UIColor *alphaColor = [UIColor colorWithHex:0x99FF0000];
 *
 * @param hex argb的值
 *
 * @return 颜色对象
 */
+ (UIColor *) colorWithARGB_Ext:(uint) hex;


/**
 * @brief RGB风格获取颜色值
 *UIColor *solidColor = [UIColor colorWithHex:0xFF0000];
 *
 * @param hex rgb的值
 *
 * @return 颜色对象
 */
+ (UIColor *) colorWithRGB_Ext:(uint) hex;

/*usage
 safe to omit # sign as well
 UIColor *solidColor = [UIColor colorWithWeb:@"FF0000"];
 */

/**
 * @brief 根据字符串返回颜色值
 * UIColor *solidColor = [UIColor colorWithWeb:@"#FF0000"];
 * UIColor *solidColor = [UIColor colorWithWeb:@"FF0000"];
 *
 * @param hexString 字符串的值，e.g:@"#FF0000" @"FF0000"
 *
 * @return 颜色对象
 */
+ (UIColor *)colorWithHexString_Ext:(NSString *)hexString;

/**
 * @brief 颜色对象返回字符串
 *
 * @return 颜色字符串
 */
- (NSString *) hexString_Ext;

/**
 * @brief 得到颜色R值
 *
 * @return 返回R值
 */
- (CGFloat)r_Ext;

/**
 * @brief 得到颜色的G值
 *
 * @return 返回颜色的G值
 */
- (CGFloat)g_Ext;

/**
 * @brief 得到颜色的B值
 *
 * @return 返回颜色的B值
 */
- (CGFloat)b_Ext;

/**
 * @brief 得到颜色的A值
 *
 * @return 返回颜色的A值
 */
- (CGFloat)a_Ext;
@end
