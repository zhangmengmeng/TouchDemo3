//
//  QYViewController.m
//  TouchDemo3
//
//  Created by qingyun on 15-3-9.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"

#define kCyanViewFrame  CGRectMake(28, 34, 100, 100)
#define kYellowViewFrame  CGRectMake(195, 414, 100, 100)
#define kMagentaViewFrame  CGRectMake(110, 214, 100, 100)

@interface QYViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *cyanView;
@property (weak, nonatomic) IBOutlet UIImageView *magentaView;
@property (weak, nonatomic) IBOutlet UIImageView *yellowView;

@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - touch process
- (void)resetFrames
{
    [UIView animateWithDuration:0.3 animations:^{
        _cyanView.frame = kCyanViewFrame;
        _magentaView.frame = kMagentaViewFrame;
        _yellowView.frame = kYellowViewFrame;
    }];
}

// 触摸开始

- (BOOL)isTouchPointInViews:(CGPoint)location
{
    if (CGRectContainsPoint(_cyanView.frame, location)
        || CGRectContainsPoint(_magentaView.frame, location)
        || CGRectContainsPoint(_yellowView.frame, location)) {
        return YES;
    }
    
    return NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    // 判断触摸发生的位置点是否在三个视图里，如果是，就放大对应的视图
    if ([self isTouchPointInViews:location]) {
        // 放大该触摸发生所在的视图
        [self animateView:touch.view];
    } else {
        if (touch.tapCount == 2) {
            [self resetFrames];
        }
    }
    
}

// 移动过程中
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 判断移动过程中的触摸点是否也在其他视图的区域内，如果是，就将其他视图的center点设置位该触摸点
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];

    if (CGRectContainsPoint(_cyanView.frame, location)) {
        _cyanView.center = location;
    }
    
    if (CGRectContainsPoint(_yellowView.frame, location)) {
        _yellowView.center = location;
    }

    if (CGRectContainsPoint(_magentaView.frame, location)) {
        _magentaView.center = location;
    }

}

// 触摸结束
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    // 恢复触摸开始时放大的图片
    [UIView animateWithDuration:0.3 animations:^{
        touch.view.transform = CGAffineTransformIdentity;
    }];
}

// 触摸开始时，放大图片视图的动画
- (void)animateView:(UIView *)view
{
    [UIView animateWithDuration:0.3 animations:^{
        view.transform = CGAffineTransformScale(view.transform, 1.2, 1.2);
    }];
}

@end
