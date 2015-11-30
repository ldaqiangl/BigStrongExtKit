//
//  BSLanguage.m
//  BigStrongExtKit
//
//  Created by 董富强 on 15/8/19.
//  Copyright (c) 2015年 董富强. All rights reserved.
//

#import "BSLanguage.h"

NSString *ESLocalFileName_Language=@"Localization";
NSString * const ESLocalLanguageDidChangeNotification = @"ESLocalLanguageDidChangeNotification";

@implementation BSLanguage

static  NSBundle *bundle = nil;
static  NSString * labguageString=nil;

+ (void)initialize {
    if (ESLocalFileName_Language.length==0) {
        ESLocalFileName_Language=@"Localization";
    }
    NSArray* languages = [NSLocale preferredLanguages];
    __strong  NSString *current = [languages objectAtIndex:0];
    [self setLanguage:current];
    
}

/*
 example calls:
 [Language setLanguage:@"it"];
 [Language setLanguage:@"de"];
 */
+ (void)setLanguage:(NSString *)l {
    
    BOOL isHave=NO;
    
    NSFileManager * manager=[NSFileManager defaultManager];
    
    if (l.length>0) {
        NSString *path = [[ NSBundle mainBundle ] pathForResource:l ofType:@"lproj" ];
        if ([manager fileExistsAtPath:path]) {
            isHave=YES;
            labguageString=nil;
            bundle=nil;
            labguageString=[[NSString  alloc]initWithFormat:@"%@",l];
            bundle=[[NSBundle alloc]initWithPath:path];
        }
    }
    
    
    if (isHave==NO) {
        
        NSArray* languages = [NSLocale preferredLanguages];
        NSString *current = [languages objectAtIndex:0];
        NSString * testPath=[[ NSBundle mainBundle ] pathForResource:current ofType:@"lproj" ];
        if ([manager fileExistsAtPath:testPath]==NO) {
            current=@"en";
            testPath=[[NSBundle mainBundle] pathForResource:current ofType:@"lproj"];
        }
        labguageString=nil;
        bundle=nil;
        labguageString=[[NSString alloc]initWithFormat:@"%@",current];
        bundle=[[NSBundle alloc]initWithPath:testPath];
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ESLocalLanguageDidChangeNotification object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"CurrentLanguage",labguageString, nil]];
    
}
+ (NSString *)getCurrentLanguageStringWithLocal {
    if (labguageString==nil||labguageString.length==0 ) {
        [self initialize];
    }
    return labguageString;
}
+ (NSString *)getLocalizedString:(NSString *)key alter:(NSString *)alternate {
    if (bundle==nil) {
        [self initialize];
    }
    if (ESLocalFileName_Language.length==0) {
        ESLocalFileName_Language=@"Localization";
    }
    return  NSLocalizedStringFromTableInBundle(key, ESLocalFileName_Language, bundle, alternate);
}

+ (NSString *)localizedStringWithKey:(NSString *)key withAlter:(NSString *)alternate {
    if (bundle==nil) {
        [self initialize];
    }
    return NSLocalizedStringFromTableInBundle(key, @"Localization", bundle, alternate);
}


@end
