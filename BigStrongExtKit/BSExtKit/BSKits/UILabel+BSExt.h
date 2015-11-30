//
//  UILabel+BSExt.h
//  BigStrongExtKit
//
//  Created by 董富强 on 15/8/19.
//  Copyright (c) 2015年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (BSExt)

/**
 * 适应字数高度的大小，宽度固定，高度根据字数得到
 *
 * @return 大小
 */
- (CGSize)fitTextHeight_Ext;

/**
 * 适应字数的宽度的大小，高度不变，宽度根据字数长度
 *
 * @return 大小
 */
- (CGSize)fitTextWidth_Ext;

@end
