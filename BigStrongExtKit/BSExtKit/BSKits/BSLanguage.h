//
//  BSLanguage.h
//  BigStrongExtKit
//
//  Created by 董富强 on 15/8/19.
//  Copyright (c) 2015年 董富强. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * @brief 本地化文件的名字，默认文件是"Localization"(Localization.strings);字符串 "myName"="English name";
 */
extern NSString * ESLocalFileName_Language;

/*
 * @brief 语言改变后，发出通知
 */
extern NSString * const ESLocalLanguageDidChangeNotification;

/**
 *
 * @brief 支持对语言的本地化语言的类
 *
 */
@interface BSLanguage : NSObject

/**
 *
 * @brief 初始化本地语言类
 *
 */
+(void)initialize;

/**
 * @brief 动态设置加载的语言
 *
 * @param l 语言的简称(即，本地生成的本地化文件名称),e.g:@"en"
 *
 */
+(void)setLanguage:(NSString *)l;

/**
 * @brief 获得本地化的语言
 *
 * @return 返回语言的字符串简称,e.g:@"en"
 */
+(NSString *)getCurrentLanguageStringWithLocal;

/**
 * @brief 得到本地化的字符串值
 *
 * @param key 本地化中的key值
 *
 * @param alternate 如果没有找到本地化文件要显示的值
 *
 * @return 字符串，既获得相应的本地化文件中key对应的value值
 */
+(NSString *)getLocalizedString:(NSString *)key alter:(NSString *)alternate;


+(NSString *)localizedStringWithKey:(NSString *)key withAlter:(NSString *)alternate;


@end
