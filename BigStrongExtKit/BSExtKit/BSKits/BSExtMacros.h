//
//  BSExtMacros.h
//  BigStrongExtKit
//
//  Created by 董富强 on 15/8/19.
//  Copyright (c) 2015年 董富强. All rights reserved.
//

#ifndef BigStrongExtKit_BSExtMacros_h
#define BigStrongExtKit_BSExtMacros_h


///是否打印log
#define kLogEnable_Ext 0

#if kLogEnable_Ext
#define kExtLog(...) NSLog(__VA_ARGS__)
#else
#define kExtLog(...) nil
#endif


#ifndef kLibraryCaches_Ext
#define kLibraryCaches_Ext [NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()]
#endif

#ifndef kCachesDocument_Ext
#define kCachesDocument_Ext [NSString stringWithFormat:@"%@/CachesDocument",kLibraryCaches_Ext]
#endif

#ifndef kCrashLogPath_Ext
#define kCrashLogPath_Ext [NSString stringWithFormat:@"/%@/kCrashLog",kCachesDocument_Ext]
#endif


#endif
