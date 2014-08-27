//
//  ZFCDoubleBounceActivityIndicatorView.m
//  ZFCActivityIndicatorViewDemo
//
//  Created by 赵 福成 on 14-6-19.
//  Copyright (c) 2014年 ZhaoFucheng. All rights reserved.
//

#import "ZFCDoubleBounceActivityIndicatorView.h"

@interface ZFCDoubleBounceActivityIndicatorView ()

@property (readwrite, nonatomic) BOOL isAnimating;

- (void)setupDefaults;

- (void)drawCircles;

- (void)removeCircles;

- (void)adjustFrame;

- (UIView *)createCircleWithRadius:(CGFloat)radius color:(UIColor *)color;

- (CABasicAnimation *)createAnimationWithDuration:(CGFloat)duration delay:(CGFloat)delay;

@end

@implementation ZFCDoubleBounceActivityIndicatorView

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
    self.bounceColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
    self.radius = 20.0f;
    self.delay = 1.0f;
    self.duration = 1.0f;
}

- (UIView *)createCircleWithRadius:(CGFloat)radius color:(UIColor *)color
{
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.radius*2, self.radius*2)];
    circle.backgroundColor = self.bounceColor;
    circle.layer.cornerRadius = self.radius;
    return circle;
}

- (CABasicAnimation *)createAnimationWithDuration:(CGFloat)duration delay:(CGFloat)delay
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.fromValue = [NSNumber numberWithFloat:0.0f];
    anim.toValue = [NSNumber numberWithFloat:1.0f];
    anim.autoreverses = YES;
    anim.duration = duration;
    anim.beginTime = CACurrentMediaTime()+delay;
    anim.removedOnCompletion = NO;
    anim.repeatCount = INFINITY;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return anim;
}

- (void)drawCircles
{
    for (NSInteger i =0; i < 2; i++) {
        UIView *circle = [self createCircleWithRadius:self.radius color:self.bounceColor];
        [circle setTransform:CGAffineTransformMakeScale(0, 0)];
        [circle.layer addAnimation:[self createAnimationWithDuration:self.duration delay:(self.delay*i)] forKey:@"scale"];
        [self addSubview:circle];
    }
}

- (void)removeCircles
{
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
}

- (void)adjustFrame
{
    CGRect frame = self.frame;
    frame.size.width = self.radius * 2;
    frame.size.height = self.radius * 2;
    self.frame = frame;
}
#pragma mark - Public Methods
- (void)startAnimating
{
    if (!self.isAnimating) {
        [self drawCircles];
        self.hidden = NO;
        self.isAnimating = YES;
    }
}

- (void)stopAnimating
{
    if (self.isAnimating) {
        [self removeCircles];
        self.hidden = YES;
        self.isAnimating = NO;
    }
}

- (void)setRadius:(CGFloat)radius
{
    _radius = radius;
    [self adjustFrame];
}
@end
