//
//  BSCropImageViewController.m
//  BigStrongExtKit
//
//  Created by 董富强 on 15/8/22.
//  Copyright (c) 2015年 董富强. All rights reserved.
//

#import "BSCropImageViewController.h"
#import "BSCropImageView.h"
#import "CONST.h"
#import "UIImage+BSExt.h"
@interface BSCropImageViewController ()

@property (nonatomic, weak) BSCropImageView *cropImageView;

@property (nonatomic, weak) UIView *toolView;
@property (nonatomic, strong) UIImage *cropedImage;

@end

@implementation BSCropImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    
    BSCropImageView *cropImageView = [[BSCropImageView alloc] initWithFrame:self.view.bounds];
    cropImageView.image = [UIImage imageFixOrientation:self.image];
    cropImageView.cropSize = CGSizeMake(WIDTH, WIDTH * 0.75);
    self.cropImageView = cropImageView;
    [self.view addSubview:self.cropImageView];
    
    [self createToolView];
}


- (void)createToolView {
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT - 44, WIDTH, 44)];
    self.toolView = toolView;
    [self.view addSubview:self.toolView];
    
    CGFloat btnW = toolView.bounds.size.width * 0.5;
    CGFloat btnH = toolView.bounds.size.height;
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0, btnW, btnH);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelCropImage) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:cancelBtn];
    
    UIButton *cropBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cropBtn.frame = CGRectMake(btnW, 0, btnW, btnH);
    [cropBtn setTitle:@"确定" forState:UIControlStateNormal];
    [cropBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cropBtn addTarget:self action:@selector(sureCropImage) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:cropBtn];
}


- (void)cancelCropImage {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)sureCropImage {
    if ([self.delegate respondsToSelector:@selector(cropImageViewControllerFinishCropImageWith:andCropedImage:)]) {
        [self.delegate cropImageViewControllerFinishCropImageWith:self andCropedImage:[self.cropImageView cropImage]];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.navigationController.navigationBar.hidden = NO;
}

@end
