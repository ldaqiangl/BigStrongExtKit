//
//  BSCropImageView.h
//  BigStrongExtKit
//
//  Created by 董富强 on 15/8/22.
//  Copyright (c) 2015年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DFQCoverContainerView;
@interface BSCropImageView : UIView<UIScrollViewDelegate>

@property (nonatomic, weak) UIImageView *imageContainerView;
@property (nonatomic, weak) UIScrollView *imageScrollView;
@property (nonatomic, weak) DFQCoverContainerView *coverView;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) UIEdgeInsets imageInset;
@property (nonatomic, assign) CGSize cropSize;

- (UIImage *)cropImage;

@end


@interface DFQCoverContainerView : UIView

@property (nonatomic, assign) CGRect cropRect;

- (void)setCropSize:(CGSize)size;
- (CGSize)cropSize;

@end