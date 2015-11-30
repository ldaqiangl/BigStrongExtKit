//
//  NSArray+BSExt.m
//  BigStrongExtKit
//
//  Created by 董富强 on 15/8/19.
//  Copyright (c) 2015年 董富强. All rights reserved.
//

#import "NSArray+BSExt.h"

@implementation NSArray (BSExt)

- (NSData *)JSONData_Ext {
    
    //    if (![NSJSONSerialization isValidJSONObject:self]) {
    //        return nil;
    //    }
    NSError * error=nil;
    NSData * data=nil;
    NSException * exce=nil;
    @try {
        ///这里的options参数为kNilOptions,转换为json的时候不添加\n格式化换行
        ///当该参数为NSJSONWritingPrettyPrinted时，添加\n格式化换行，方便阅读
        data= [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    }
    @catch (NSException *exception) {
        exce=exception;
    }
    @finally {
        
    }
    
    if (error || exce) {
        //@throw exce;
        return nil;
    }
    
    return data;
    
}

- (NSString *)JSONString_Ext
{
    
    NSData * data=[self JSONData_Ext];
    if (data) {
        __autoreleasing  NSString *  string=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return string;
    }
    return nil;
}


@end
