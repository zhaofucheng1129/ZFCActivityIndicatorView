//
//  ZFCWanderingCubesActivityIndicatorView.m
//  ZFCActivityIndicatorViewDemo
//
//  Created by 赵 福成 on 14-6-19.
//  Copyright (c) 2014年 ZhaoFucheng. All rights reserved.
//

#import "ZFCWanderingCubesActivityIndicatorView.h"

@interface ZFCWanderingCubesActivityIndicatorView ()

@property (readwrite, nonatomic) BOOL isAnimating;

- (void)setupDefaults;

- (void)addCubes;

- (void)removeCubes;

- (void)adjustFrame;

- (CAAnimationGroup *)createAnimationWithDuration:(CGFloat)duration delay:(CGFloat)delay cube:(UIView *)cube;

@end

@implementation ZFCWanderingCubesActivityIndicatorView

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
    self.firstCubeColor = [UIColor whiteColor];
    self.secondCubeColor = [UIColor whiteColor];
    self.duration = 1.8f;
    self.delay = 0.9f;
    self.cubeWidth = 10.0f;
    self.moveWidth = 22.0f;
}

- (CAAnimationGroup *)createAnimationWithDuration:(CGFloat)duration delay:(CGFloat)delay cube:(UIView *)cube
{
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.values = [NSArray arrayWithObjects:
                       [NSValue valueWithCGPoint:CGPointMake(0, 0)],
                       [NSValue valueWithCGPoint:CGPointMake(self.moveWidth, 0)],
                       [NSValue valueWithCGPoint:CGPointMake(self.moveWidth, self.moveWidth)],
                       [NSValue valueWithCGPoint:CGPointMake(0, self.moveWidth)],
                       [NSValue valueWithCGPoint:CGPointMake(0, 0)], nil];
    CAKeyframeAnimation *transformAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CATransform3D fromValue = cube.layer.transform;
    CATransform3D secondForm = CATransform3DRotate(fromValue, -M_PI/2, 0, 0, 1);
    CATransform3D thirdForm = CATransform3DRotate(secondForm, M_PI/2, 0, 0, 0);
    CATransform3D lastForm = CATransform3DRotate(thirdForm, -M_PI/2, 0, 0, 1);
    transformAnim.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:fromValue],
                            [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DScale(fromValue, 0.2, 0.2, 1),CATransform3DRotate(fromValue, -M_PI/2, 0, 0, 1))],
                        [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DScale(secondForm, 1, 1, 1),CATransform3DRotate(secondForm, M_PI, 0, 0, 0))],
                        [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DScale(thirdForm, 0.2, 0.2, 1),CATransform3DRotate(thirdForm, -M_PI/2, 0, 0, 1))],
                        [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DScale(lastForm, 1, 1, 1),CATransform3DRotate(lastForm, M_PI/2, 0, 0, 0))],nil];
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects: moveAnim, transformAnim, nil];
    animGroup.duration = duration;
    animGroup.beginTime = CACurrentMediaTime() + delay;
    animGroup.repeatCount = INFINITY;
    animGroup.removedOnCompletion = NO;
    animGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    return animGroup;
}

- (void)addCubes
{
    for (NSInteger i = 0; i < 2; i++) {
        UIView *cube = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.cubeWidth, self.cubeWidth)];
        cube.backgroundColor = i == 0 ? self.firstCubeColor : self.secondCubeColor;
        [cube.layer addAnimation:[self createAnimationWithDuration:self.duration delay:self.delay * i cube:cube] forKey:@"cube"];
        [self addSubview:cube];
    }
}

- (void)removeCubes
{
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
}

- (void)adjustFrame
{
    CGRect frame = self.frame;
    frame.size.width = self.moveWidth;
    frame.size.height = self.moveWidth;
    self.frame = frame;
}

#pragma mark - Public Methods

-(void)startAnimating
{
    if (!self.isAnimating) {
        [self addCubes];
        self.hidden = NO;
        self.isAnimating = YES;
    }
}

-(void)stopAnimating
{
    if (self.isAnimating) {
        [self removeCubes];
        self.hidden = YES;
        self.isAnimating = NO;
    }
}

- (void)setMoveWidth:(CGFloat)moveWidth
{
    _moveWidth = moveWidth;
    [self adjustFrame];
}

@end
