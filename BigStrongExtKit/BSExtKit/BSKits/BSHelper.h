//
//  BSHelper.h
//  BigStrongExtKit
//
//  Created by 董富强 on 15/8/19.
//  Copyright (c) 2015年 董富强. All rights reserved.
//

/** 常用的辅助方法 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BSHelper : NSObject
/**
 *  保存关键数据 如：设备唯一标识到钥匙串里
 *
 *  @param NSString* <#NSString* description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)saveKeyString;
+ (NSString *)getKeyChainUID;

/**
 *	随机生成UUID
 *	@return 生成的uuid字符串
 */
+ (NSString*)getUUID_Ext;

/**
 *	生成随机数
 *	@param length 随机数的位数
 *	@return 随机数的字符串
 */
+ (NSString *)getRandomNumberwithLength_Ext:(int)length;

/**
 *	生成随机字符串，区分大小写
 *	@param  字符长度
 *	@return 字符串
 */
+ (NSString *)getRandomStringwithLength_Ext:(int)length;

/**
 *	生成随机字符和数字字符串
 *	@param length 字符串的长度
 *	@return 字符串
 */
+ (NSString *)getRandomNumberAndStringWithLength_Ext:(int)length;


/**
    检验手机号
 */
+ (BOOL)simpleCheckMobilePhoneWith:(NSString *)mobiePhoneStr;
+ (BOOL)advancedCheckMobilePhoneWith:(NSString *)mobiePhoneStr;
/**
 *  检验邮箱
 */
+ (BOOL)simpleCheckMailWith:(NSString *)mailStr;
+ (BOOL)advacedCheckMailWith:(NSString *)mailStr;


/** 保存图片 并生成 图片名称 以及 全路径 */
- (NSString *)saveImage:(UIImage *)img;
/** 获取对应图片名称的图片 */
- (UIImage *)getImageWithImageName:(NSString *)imageName;
/** 删除对应名称的图片 */
- (BOOL)deleteImageWithName:(NSString *)imageName;
- (void)deleteAllImageWithNames:(NSArray *)imageNames;



@end
