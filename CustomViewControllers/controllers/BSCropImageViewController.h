//
//  BSCropImageViewController.h
//  BigStrongExtKit
//
//  Created by 董富强 on 15/8/22.
//  Copyright (c) 2015年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSCropImageViewController;
@protocol BSCropImageViewControllerDelegate <NSObject>

- (void)cropImageViewControllerFinishCropImageWith:(BSCropImageViewController *)cropImageController andCropedImage:(UIImage *)cropedImage;

@end


@interface BSCropImageViewController : UIViewController

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, assign) id<BSCropImageViewControllerDelegate> delegate;

@end
