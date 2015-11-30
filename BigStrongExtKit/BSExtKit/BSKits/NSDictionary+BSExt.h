//
//  NSDictionary+BSExt.h
//  BigStrongExtKit
//
//  Created by 董富强 on 15/8/19.
//  Copyright (c) 2015年 董富强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (BSExt)
/**
 * @brief 字典转换成json的Data类型
 *
 * @return 返回数据对象，失败时返回nil
 */
- (NSData *)JSONData_Ext NS_AVAILABLE(10_7, 5_0);

/**
 * @brief 字典对象转换成json字符串
 *
 * @return 返回字符串，失败时返回nil
 */
- (NSString *)JSONString_Ext NS_AVAILABLE(10_7, 5_0);


@end
