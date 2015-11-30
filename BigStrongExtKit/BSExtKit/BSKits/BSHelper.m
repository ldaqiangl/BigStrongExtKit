//
//  BSHelper.m
//  BigStrongExtKit
//
//  Created by 董富强 on 15/8/19.
//  Copyright (c) 2015年 董富强. All rights reserved.
//

#import "BSHelper.h"
#import "UIImage+BSExt.h"

#import "KeychainItemWrapper.h"
#import "AppDelegate.h"
@implementation BSHelper
+ (NSString *)saveKeyString {
    
    
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc]
                                         
                                         initWithIdentifier:@"UUID"
                                         
                                         accessGroup:@"dfqtest.com.dfqtest.keychain"];
    
    NSString *strUUID = [keychainItem objectForKey:(id)CFBridgingRelease(kSecValueData)];
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@"dfqtest.com.dfqtest.keychain"]) {
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        [keychainItem setObject:strUUID forKey:(id)CFBridgingRelease(kSecValueData)];
        NSLog(@"---%@",strUUID);
    }
    return strUUID;
}

+ (NSString*)getUUID_Ext {
    CFUUIDRef puuid = CFUUIDCreate( kCFAllocatorDefault );
    CFStringRef uuidString = CFUUIDCreateString( kCFAllocatorDefault, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( kCFAllocatorDefault, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

+ (NSString *)getKeyChainUID {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return [delegate.wrapper objectForKey:(__bridge id)kSecValueData];


}


+ (NSString *)getRandomNumberwithLength_Ext:(int)length {
    if (length==0 ||length<0)
    {
        return nil;
    }
    NSMutableString * result=[NSMutableString string];
    
    for (int i=0; i<length; i++)
    {
        if (i==0)
        {
            [result appendFormat:@"%d",arc4random()%9+1];
        }
        else{
            [result appendFormat:@"%d",arc4random()%10];
        }
    }
    
    return result;
}

+ (NSString *)getRandomStringwithLength_Ext:(int)length {
    
    if (length==0 ||length<0)
    {
        return nil;
    }
    NSMutableString * result=[NSMutableString string];
    
    for (int i=0; i<length; i++)
    {
        if ((arc4random()%2+1)%2==0)
        {
            [result appendFormat:@"%c",arc4random()%26+97];
        }
        else{
            [result appendFormat:@"%c",arc4random()%26+65];
        }
    }
    
    return result;
}

+ (NSString *)getRandomNumberAndStringWithLength_Ext:(int)length {
    if (length==0 ||length<0)
    {
        return nil;
    }
    NSMutableString * result=[NSMutableString string];
    
    for (int i=0; i<length; i++)
    {
        if ((arc4random()%3+1)==1)
        {
            [result appendFormat:@"%c",arc4random()%26+97];
        }
        else if ((arc4random()%3+1)==1)
        {
            [result appendFormat:@"%c",arc4random()%26+65];
        }
        else{
            [result appendFormat:@"%d",arc4random()%10];
        }
    }
    
    return result;
}





/**
 检验手机号
 */
+ (BOOL)simpleCheckMobilePhoneWith:(NSString *)mobiePhoneStr {
    
    return YES;
}
+ (BOOL)advancedCheckMobilePhoneWith:(NSString *)mobiePhoneStr {
    return YES;
}
/**
 检验邮箱
 */
+ (BOOL)simpleCheckMailWith:(NSString *)mailStr {
    return YES;
}
+ (BOOL)advacedCheckMailWith:(NSString *)mailStr {
    return NO;
}




/** 保存图片 并生成 图片名称 返回图片名称 */
- (NSString *)saveImage:(UIImage *)img {
    NSString *picName = [NSString stringWithFormat:@"%@%@",[[self class] getUUID_Ext],@".png"];
    [self saveImage:img WithName:picName];
    return picName;
}
/** 把选中的图片 保存到本地 并更改其全局路径 */
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName {
    
    NSData *imageData = UIImagePNGRepresentation(tempImage);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths lastObject];
    
    //获取全路径
    NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    //    NSLog(@"---图片保存路径:%@",fullPathToFile);
    [imageData writeToFile:fullPathToFile atomically:NO];
}

/** 得到图片名称对应的图片 */
- (UIImage *)getImageWithImageName:(NSString *)imageName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths lastObject];
    //获取全路径
    NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    return [UIImage imageWithContentsOfFile_Ext:fullPathToFile];
}

- (BOOL)deleteImageWithName:(NSString *)imageName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths lastObject];
    //获取全路径
    NSString *imageDir = [documentsDirectory stringByAppendingPathComponent:imageName];
    
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    bool isDeleted = false;
    if (existed) {
        isDeleted = [fileManager removeItemAtPath:imageDir error:nil];
    }
    
    return isDeleted;
}
- (void)deleteAllImageWithNames:(NSArray *)imageNames {
    for (NSString *imageName in imageNames) {
        [self deleteImageWithName:imageName];
    }
}

@end
