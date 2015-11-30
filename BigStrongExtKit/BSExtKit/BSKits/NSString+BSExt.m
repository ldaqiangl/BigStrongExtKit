//
//  NSString+BSExt.m
//  BigStrongExtKit
//
//  Created by 董富强 on 15/8/19.
//  Copyright (c) 2015年 董富强. All rights reserved.
//

#import "NSString+BSExt.h"

#import "NSData+BSExt.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (BSExt)

/**
 * @brief 使用MD5算法进行签名（16位）
 *
 * @return 签名后字符串
 */
- (NSString *)md5HexDigestString_Ext
{
    if (self==nil) {
        return nil;
    }
    return [[self md5DHexDigestString_Ext] substringWithRange:NSMakeRange(8, 16)];
}

/**
 * @brief 使用MD5算法进行签名（32位）
 *
 * @return 签名后字符串
 */
- (NSString *)md5DHexDigestString_Ext
{
    if (self==nil) {
        return nil;
    }
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result ); // This is the md5 call
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


/**
 * @brief 使用SHA1算法进行签名
 *
 * @return 签名后字符串
 */
- (NSString *)sha1String_Ext
{
    if (self==nil) {
        return self;
    }
    const char *cStr = [self UTF8String];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}

/**
 *	@brief	使用HMac-SHA1进行签名
 *
 *	@param 	key 	密钥
 *
 *	@return	签名后字符串
 */
- (NSString *)hmacsha1StringWithKey_Ext:(NSString *)key
{
    if (self==nil) {
        return nil;
    }
    const char * ckey=[key UTF8String];
    const char * cdata=[self UTF8String];
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, ckey, strlen(ckey), cdata, strlen(cdata), cHMAC);
    
    __autoreleasing NSString * string=[[NSString alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH encoding:NSUTF8StringEncoding];
    return string;
}


/**
 *	@brief	使用HMac-SHA1进行签名
 *
 *	@param 	key 	密钥
 *
 *	@return	签名后的数据
 */
- (NSData *)dataUsinghmacsha1StringWithKey_Ext:(NSString *)key
{
    if (self==nil) {
        return nil;
    }
    const char * ckey=[key UTF8String];
    const char * cdata=[self UTF8String];
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, ckey, strlen(ckey), cdata, strlen(cdata), cHMAC);
    NSData * data=[NSData dataWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    return data;
}


- (NSString *)urlEncodeAllRecode:(CFStringEncoding)encodeing
{
    
    //kCFStringEncodingUTF8
    // Encode all the reserved characters, per RFC 3986
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,%#[]",
                                                              encodeing));
    return outputStr;
    
}

/**
 * @brief  URL字符串编码
 *
 * @param encodeing 编码格式
 *
 * @return 编码后的字符串
 */
- (NSString *)urlEncode_Ext:(CFStringEncoding)encodeing
{
    return [self stringByAddingPercentEscapesUsingEncoding:encodeing];
    /*
     //kCFStringEncodingUTF8
     // Encode all the reserved characters, per RFC 3986
     // (<http://www.ietf.org/rfc/rfc3986.txt>)
     NSString *outputStr = (NSString *)
     CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
     (CFStringRef)self,
     NULL,
     (CFStringRef)@"!*'();:@&=+$,%#[]",
     encodeing);
     return [outputStr autorelease];
     */
}



- (NSString *)urlEncodeUTF8_Ext
{
    return [self urlEncode_Ext:NSUTF8StringEncoding];
}

- (NSString *)urlDecodeUTF8_Ext
{
    return [self urlDecode_Ext:NSUTF8StringEncoding];
}
/**
 * @brief URL字符串解码
 *
 * @param decodeing 编码格式
 *
 * @return 解码后的字符串
 */
- (NSString *)urlDecode_Ext:(NSStringEncoding)decodeing
{
    if (self==nil) {
        return nil;
    }
    NSMutableString *outputStr = [NSMutableString stringWithString:self];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:decodeing];
}


- (NSString *)hexEncode_Ext
{
    if (!self) {
        return nil;
    }
    NSData * data=[self dataUsingEncoding:NSUTF8StringEncoding];
    NSData * eData=[data hexEncode_Ext];
    
    __autoreleasing NSString *result=[[NSString alloc] initWithData:eData encoding:NSUTF8StringEncoding];
    return result;
    
}

- (NSString *)hexDecode_Ext
{
    if (!self) {
        return nil;
    }
    NSData * data=[self dataUsingEncoding:NSUTF8StringEncoding];
    NSData * eData=[data hexDecode_Ext];
    
    __autoreleasing NSString *result=[[NSString alloc] initWithData:eData encoding:NSUTF8StringEncoding];
    return result;
}

/**
 * @brief 字符串base64编码
 *
 * @param encoding 需要编码的字符串格式以及返回字符串的格式(UTF-8,GB2313...)
 *
 * @return 编码后的字符串
 */
- (NSString *)base64EncodedStringEncoding_Ext:(NSStringEncoding)encoding
{
    if (self==nil ) {
        return nil;
    }
    NSData * data=[self dataUsingEncoding:encoding];
    return [data base64EncodedStringEncoding_Ext:encoding];
}

/**
 * @brief 字符串base64解码
 *
 * @param encoding 解码的字符串格式以及返回字符串的格式(UTF-8.GB2313...)
 *
 * @return 解码后的字符串
 */
- (NSString *)base64DecodedStringEncoding_Ext:(NSStringEncoding)encoding
{
    if (self==nil) {
        return nil;
    }
    NSData * data=[NSData dataFromBase64String_Ext:self encoding:encoding];
    __autoreleasing NSString * result=[[NSString alloc] initWithData:data encoding:encoding];
    return result;
}

/**
 * @brief 字符串base64编码，默认编码格式时候UTF8
 *
 * @return 编码后的字符串
 */
- (NSString *)base64Encoded_Ext
{
    return [self base64EncodedStringEncoding_Ext:NSUTF8StringEncoding];
}

/**
 * @brief 字符串base64解码，默认编码格式时候UTF8
 *
 * @return 解码后的字符串
 */
- (NSString *)base64Decoded_Ext
{
    return [self base64DecodedStringEncoding_Ext:NSUTF8StringEncoding];
}

/**
 * @brief 字符串base64编码,utf8
 *
 * @return 编码后的数据data
 */
- (NSData *)base64DataFromString_Ext
{
    NSData * data=[self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64Encoded_Ext];
}

/**
 * @brief 字符串解码，使用UTF8
 *
 * @return 返回解码后的数据data
 */
- (NSData *)dataFromBase64String_Ext
{
    if (self==nil) {
        return nil;
    }
    return [NSData dataFromBase64String_Ext:self encoding:NSUTF8StringEncoding];
}

/**
 *	@brief	汉字转拼音字符串
 *
 *	@return	拼音字符串(小写)
 */
- (NSString *)pinyinString_Ext
{
    if (self==nil) {
        return nil;
    }
    
    CFMutableStringRef string =CFStringCreateMutableCopy(NULL, 0, (CFStringRef)self);
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    // CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    
    CFAutorelease(string);
    
    return (__bridge NSString *)string;
}


- (NSString *)pinyinNoTone_Ext
{
    if (self==nil) {
        return nil;
    }
    
    CFMutableStringRef string =CFStringCreateMutableCopy(NULL, 0, (CFStringRef)self);
    ///转换成拼音
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    ///去掉声调
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    CFAutorelease(string);    //
    
    return (__bridge NSString *)string;
}

- (NSString *)pinyinNoToneAndSpace_Ext
{
    if (self==nil) {
        return nil;
    }
    NSString * string=[self pinyinNoTone_Ext];
    string=[string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return string;
}


/**
 *	@brief	取得汉字的拼音首字母
 *
 *	@return	拼音首字母字符串(大写)
 */
- (NSString *)pinyinFirstLetter_Ext
{
    if (self==nil) {
        return nil;
    }
    NSMutableString * string=[NSMutableString string];
    
    @try {
        NSString *noToneString=[self pinyinNoTone_Ext];
        NSArray *spaceList=[noToneString componentsSeparatedByString:@" "];
        for (int i=0; i<[spaceList count]; i++) {
            [string appendFormat:@"%c",[spaceList[i] UTF8String][0]];
        }
        
        /*
         for (int i=0; i<[self length]; i++) {
         [string appendFormat:@"%c",ESPinyinFirstLetter_Ext([string characterAtIndex:i])];
         }*/
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
    return [string uppercaseString];
}


- (NSString *)stringUsingAES128EncryptWithkey_Ext:(NSString *)key usingEncoding:(NSStringEncoding)encoding withIV:(void *)iv_
{
    
    NSData * data=[self dataUsingEncoding:encoding];
    
    NSData * enData=[data dataUsingAES128EncryptWithkey_Ext:[key dataUsingEncoding:encoding] withIV:iv_];
    
    return [enData base64EncodedStringEncoding_Ext:encoding];
    
}
- (NSString *)stringUsingAES128DencryptWithkey_Ext:(NSString *)key usingEncoding:(NSStringEncoding)encoding withIV:(void *)iv_
{
    
    NSData * data=[NSData dataFromBase64String_Ext:self encoding:encoding];
    
    NSData * deData=[data dataUsingAES128DecryptWithkey_Ext:[key dataUsingEncoding:encoding] withIV:iv_];
    __autoreleasing NSString * result=[[NSString alloc] initWithData:deData encoding:encoding];
    return  result;
}


- (NSString *)stringUsingDESEncryWithkey_Ext:(NSString *)key usingEncoding:(NSStringEncoding)encoding withIV:(void *)iv_
{
    
    NSData * data=[self dataUsingEncoding:encoding];
    
    NSData * enData=[data dataUsingDESEncryWithkey_Ext:[key dataUsingEncoding:encoding] withIV:iv_];
    
    return [enData base64EncodedStringEncoding_Ext:encoding];
}

- (NSString *)stringUsingDESDencryWithkey_Ext:(NSString *)key usingEncoding:(NSStringEncoding)encoding withIV:(void *)iv_
{
    NSData * data=[NSData dataFromBase64String_Ext:self encoding:encoding];
    NSData * deData=[data dataUsingDESDencryWithkey_Ext:[key dataUsingEncoding:encoding] withIV:iv_];
    __autoreleasing NSString * result=[[NSString alloc] initWithData:deData encoding:NSUTF8StringEncoding];
    return result;
}


/**
 * @brief json字符串转换成字符串,使用UTF8编码
 *
 * @return 数组或者字典对象
 */
- (id)objectFromJSONString_Ext
{
    NSData * data=[self dataUsingEncoding:NSUTF8StringEncoding];
    return [data objectFromJSONData_Ext];
}




- (BOOL)isEqualToString_BSExt:(NSString *)other {
    NSRange range = [self rangeOfString:other];
    return range.length != 0;
}

+ (NSString *)stringWithDouble_BSExt:(double)value fractionCount:(int)fractionCount
{
    if (fractionCount < 0) return nil;
    
    // 1.fmt ---> %.2f
    NSString *fmt = [NSString stringWithFormat:@"%%.%df", fractionCount];
    
    // 2.生成保留fractionCount位小数的字符串
    NSString *str = [NSString stringWithFormat:fmt, value];
    
    // 3.如果没有小数，直接返回
    if ([str rangeOfString:@"."].length == 0) {
        return str;
    }
    
    // 4.不断删除最后一个0 和 最后一个'.'
    NSInteger index = str.length - 1;
    unichar currentChar = [str characterAtIndex:index];
    
    while (currentChar == '0' ||  currentChar == '.') {
        if (currentChar == '.') {
            return [str substringToIndex:index];
        }
        
        index--;
        currentChar = [str characterAtIndex:index];
    }
    return [str substringToIndex:index + 1];
    //    unichar last = 0;
    //    while ( (last = [str characterAtIndex:str.length - 1]) == '0' ||
    //            last == '.') {
    //        str = [str substringToIndex:str.length - 1];
    //
    //        // 裁剪到'.'，直接返回
    //        if (last == '.') return str;
    //    }
}

- (NSComparisonResult)compareDate_BSExt:(NSString *)other {
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    dateFormat.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *selfDate = [dateFormat dateFromString:self];
    NSDate *otherDate =[dateFormat dateFromString:other];
    
    return [selfDate compare:otherDate];
}

- (CGSize)sizeWithFont_BSExt:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName:font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

//获得到指定时间的时间差字符串,传入目标时间字符串和格式
+ (NSString*)stringNowToDate_BSExt:(NSString*)toDate formater:(NSString*)formatStr
{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    if (formatStr) {
        [formater setDateFormat:formatStr];
    }
    else{
        [formater setDateFormat:[NSString stringWithFormat:@"yyyy-MM-dd HH:mm:ss"]];
    }
    NSDate *date=[formater dateFromString:toDate];
    
    return [self stringNowToDate_BSExt:date];
    
}
//获得到指定时间的时间差字符串,格式在此方法内返回前自己根据需要格式化
+ (NSString*)stringNowToDate_BSExt:(NSDate*)toDate
{
    //创建日期 NSCalendar对象
    NSCalendar *cal = [NSCalendar currentCalendar];
    //初始化目标时间,可以随意设置时间
    //    NSDateComponents *dc = [[NSDateComponents alloc] init];
    //    [dc setYear:2014];
    //    [dc setMonth:4];
    //    [dc setDay:23];
    //    [dc setHour:9];
    //    [dc setMinute:0];
    //    [dc setSecond:0];
    //把目标时间装载入date
    //NSDate *todate //= [cal dc];
    //得到当前时间
    NSDate *today = [NSDate date];
    //用来得到具体的时差,位运算
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    if (toDate && today) {
        NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:toDate options:0 ];
        
        //NSString *dateStr=[NSString stringWithFormat:@"%d年%d月%d日%d时%d分%d秒",[d year],[d month], [d day], [d hour], [d minute], [d second]];
        NSString *dateStr = [NSString stringWithFormat:@"%.2d:%.2d:%.2d",(int)[d hour],(int)[d minute],(int)[d second]];
        return dateStr;
    }
    return @"";
}

@end
