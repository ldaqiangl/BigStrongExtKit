//
//  CONST.h
//  BigStrongExtKit
//
//  Created by 董富强 on 15/8/21.
//  Copyright (c) 2015年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifndef BigStrongExtKit_CONST_h
#define BigStrongExtKit_CONST_h


/** 一、自定义打印log */
#define bsLogEnable 0

#if bsLogEnable
#define bsLog(...) NSLog(__VA_ARGS__)
#else
#define bsLog(...) nil
#endif

#ifdef DEBUG
#define dfqLog(...) NSLog(__VA_ARGS__)
#else
#define dfqLog(...)
#endif


/** 二、沙盒路径 */
#define bsAppDocumentPath [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()]//    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
#define bsAppCachesPath [NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()]//NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)
#define bsAppTmpPath [NSString stringWithFormat:@"%@/tmp",NSHomeDirectory()]//NSTemporaryDirectory()


/** 三、iOS 系统版本判断 */
#define iOS8 [[UIDevice currentDevice].systemVersion doubleValue] >= 8.0
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
#define iOS(version) ([[UIDevice currentDevice].systemVersion doubleValue] >= version)


/** 四、设备屏幕宽高（适配） */
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

#define PX_TO_PT(px) px*kScreenWidth/750.0 //UI坐标图以iPhone 6为标准设计


/** 五、获取app信息 */
#define BS_APP_CURRENT_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


/** 六、颜色调配 */
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)


/** 七、app内通知名称 */


/** 八、三方分享 key和secret参数 */
//Ument KEY
#define UMENG_APPKEY @"555ab61e67e58e4d0a00813f"

//新浪
#define SinaWBAppKey @"2835707887"///sina.555ab61e67e58e4d0a00813f
#define SinaWBAppSecret @"d2804214474bcad43410914e0740babd"
#define SinaWBURI @"http://www.1renbang.com"

//微信
#define WXAppKey @"wx13b88d1ba41d7b5e"
#define WXAppSecret @"f6004ba06851008e4895447bd080cfd4"

//QQ
#define QQAppID @"1104671644"
#define QQAppSecret @"aDSuwg3gpaEvSRqg"
#define QQURI @"http://www.1renbang.com"


/** 九、单例 */
/*
 专门用来保存单例代码
 最后一行不要加 \
 */
// @interface
#define singleton_interface(className) \
+ (className *)shared##className;

// @implementation
#define singleton_implementation(className) \
static className *_instance; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (className *)shared##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}

#endif
