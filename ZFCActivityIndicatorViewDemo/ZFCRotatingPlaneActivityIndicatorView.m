//
//  ZFCRotatingPlaneActivityIndicatorView.m
//  ZFCActivityIndicatorViewDemo
//
//  Created by 赵 福成 on 14-6-18.
//  Copyright (c) 2014年 ZhaoFucheng. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ZFCRotatingPlaneActivityIndicatorView.h"

@interface ZFCRotatingPlaneActivityIndicatorView ()

@property (readwrite, nonatomic) BOOL isAnimating;

- (void)setupDefaults;

- (void)drawPlane;

- (void)removePlane;

- (void)adjustFrame;

@end

@implementation ZFCRotatingPlaneActivityIndicatorView


#pragma mark - Initializations

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

#pragma mark - Private Methods

- (void)setupDefaults
{
    self.sideLength = 30.0f;
    self.planeColor = [UIColor whiteColor];
    self.duration = 1;
    self.perspectiveValue = 70.0f;
}

- (void)drawPlane
{
    UIView *plane = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.sideLength, self.sideLength)];
    plane.backgroundColor = self.planeColor;
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CATransform3D fromValue = plane.layer.transform;
    CATransform3D transitionValue = CATransform3DRotate(fromValue, M_PI, 0, 1, 0);
    anim.values = [NSArray arrayWithObjects:[NSValue valueWithCATransform3D:CATransform3DPerspect(fromValue,CGPointMake(0, 0),self.perspectiveValue)],
                   [NSValue valueWithCATransform3D:CATransform3DPerspect(transitionValue,CGPointMake(0, 0),self.perspectiveValue)],
                   [NSValue valueWithCATransform3D:CATransform3DPerspect(CATransform3DRotate(transitionValue, M_PI, 1, 0, 0),CGPointMake(0, 0),self.perspectiveValue)], nil];
    anim.duration = self.duration;
    anim.repeatCount = INFINITY;
    anim.removedOnCompletion = NO;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [plane.layer addAnimation:anim forKey:@"plane"];
    [self addSubview:plane];
}

- (void)removePlane
{
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
}

- (void)adjustFrame {
    CGRect frame = self.frame;
    frame.size.width = self.sideLength;
    frame.size.height = self.sideLength;
    self.frame = frame;
}

CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}


#pragma mark - Public Methods

- (void)startAnimating {
    if (!self.isAnimating) {
        [self drawPlane];
        self.hidden = NO;
        self.isAnimating = YES;
    }
}

- (void)stopAnimating {
    if (self.isAnimating) {
        [self removePlane];
        self.hidden = YES;
        self.isAnimating = NO;
    }
}

- (void)setSideLength:(CGFloat)sideLength {
    _sideLength = sideLength;
    [self adjustFrame];
}
@end
