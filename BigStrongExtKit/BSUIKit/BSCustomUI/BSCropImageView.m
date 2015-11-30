//
//  BSCropImageView.m
//  BigStrongExtKit
//
//  Created by 董富强 on 15/8/22.
//  Copyright (c) 2015年 董富强. All rights reserved.
//

#import "BSCropImageView.h"

#import "UIImage+BSExt.h"
@interface BSCropImageView ()
{
    CGFloat offX;
    CGFloat offY;
    CGFloat cropWidth;
    CGFloat cropHeight;
}
@property (nonatomic, assign) CGFloat displayImageRate;
@end
@implementation BSCropImageView

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self.imageScrollView setFrame:self.bounds];
}
- (UIScrollView *)imageScrollView {
    if (_imageScrollView == nil) {
        UIScrollView *imageScrollView = [[UIScrollView alloc] init];
        imageScrollView.backgroundColor = [UIColor blackColor];
        imageScrollView.delegate = self;
        imageScrollView.bounces = NO;
        imageScrollView.showsVerticalScrollIndicator = NO;
        imageScrollView.showsHorizontalScrollIndicator = NO;
        imageScrollView.maximumZoomScale = 5;
        imageScrollView.minimumZoomScale = 1;
        self.imageScrollView = imageScrollView;
        [self addSubview:self.imageScrollView];
    }
    return _imageScrollView;
}

- (DFQCoverContainerView *)coverView {
    if (_coverView == nil) {
        DFQCoverContainerView *coverView = [[DFQCoverContainerView alloc] initWithFrame:self.bounds];
        coverView.userInteractionEnabled = NO;
        coverView.backgroundColor = [UIColor clearColor];
        self.coverView = coverView;
        [self addSubview:self.coverView];
        [self bringSubviewToFront:self.coverView];
    }
    return _coverView;
}

- (UIImageView *)imageContainerView {
    if (_imageContainerView == nil) {
        UIImageView *imageContainerView = [[UIImageView alloc] init];
        _imageContainerView = imageContainerView;
        [self.imageScrollView addSubview:_imageContainerView];
    }
    return _imageContainerView;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    CGFloat rateW = self.cropSize.width / image.size.width;
    CGFloat rateH = self.cropSize.height / image.size.height;
    CGFloat imageRate = (rateW < rateH)?rateH:rateW;
    _displayImageRate = imageRate;
    
    CGFloat imageContainerW = image.size.width * _displayImageRate;
    CGFloat imageContainerH = image.size.height * _displayImageRate;
    self.imageContainerView.frame = (CGRect){0,0,imageContainerW,imageContainerH};
    self.imageContainerView.image = image;
    self.imageScrollView.contentSize = self.imageContainerView.bounds.size;
}

- (void)setCropSize:(CGSize)cropSize {
    _cropSize = cropSize;
    
    [self.coverView setCropSize:cropSize];
    
    [self setImage:self.image];
    
    CGFloat contentInsetX = self.coverView.cropRect.origin.x;//(self.coverView.cropRect.size.width - self.imageContainerView.bounds.size.width) * 0.5;//
    CGFloat contentInsetY = self.coverView.cropRect.origin.y;
    
    self.imageScrollView.contentInset = UIEdgeInsetsMake(contentInsetY, contentInsetX, contentInsetY, contentInsetX);
}

- (UIImage *)cropImage {
    CGFloat currentScale = self.imageScrollView.zoomScale * _displayImageRate;
    CGFloat cropX = offX / currentScale;
    CGFloat cropY = (offY + self.coverView.cropRect.origin.y) / currentScale;
    CGFloat cropW = self.cropSize.width / currentScale;
    CGFloat cropH = self.cropSize.height / currentScale;
    
    UIImage *cropedImage = [_image creatNewImageInRect_Ext:CGRectMake(cropX, cropY, cropW, cropH)];
    
    return  [cropedImage imageScalZoonToSize_Ext:CGSizeMake(self.cropSize.width, self.cropSize.height)];
}


#pragma mark UIScrollViewDelegate
//获取当前滚动视图上的内容视图---进行缩放
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [[scrollView subviews] lastObject];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    offX = scrollView.contentOffset.x;
    offY = scrollView.contentOffset.y;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    offX = scrollView.contentOffset.x;
    offY = scrollView.contentOffset.y;
}
@end



#define kDFQCoverStrokeWidth 2.0f
@implementation DFQCoverContainerView
- (CGSize)cropSize {
    return _cropRect.size;
}
- (void)setCropSize:(CGSize)size {
    CGFloat cropX = (self.bounds.size.width - size.width) * 0.5;
    CGFloat cropY = (self.bounds.size.height - size.height) * 0.5;
    _cropRect = (CGRect){cropX,cropY,size};
    
    [self setNeedsDisplay];
}
- (void)setCropRect:(CGRect)cropRect {
    _cropRect = cropRect;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(ctx, 1, 1, 1, 0);
    CGContextFillRect(ctx, self.bounds);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextStrokeRectWithWidth(ctx, _cropRect, kDFQCoverStrokeWidth);
    
    CGContextClearRect(ctx, _cropRect);
}
@end

