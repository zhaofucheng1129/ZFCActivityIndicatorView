//
//  ZFCDoubleBounceActivityIndicatorView.h
//  ZFCActivityIndicatorViewDemo
//
//  Created by 赵 福成 on 14-6-19.
//  Copyright (c) 2014年 ZhaoFucheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFCDoubleBounceActivityIndicatorView : UIView
/**
 设置颜色
 */
@property (readwrite, nonatomic) UIColor *bounceColor;
/**
 设置半径
 */
@property (readwrite, nonatomic) CGFloat radius;
/**
 设置动画延迟
 */
@property (readwrite, nonatomic) CGFloat delay;
/**
 设置动画持续时间
 */
@property (readwrite, nonatomic) CGFloat duration;

- (void)startAnimating;

- (void)stopAnimating;

@end
