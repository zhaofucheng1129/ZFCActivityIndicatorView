//
//  ZFCWaveActivityIndicatorView.h
//  ZFCActivityIndicatorViewDemo
//
//  Created by 赵 福成 on 14-6-19.
//  Copyright (c) 2014年 ZhaoFucheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZFCWaveActivityIndicatorViewDelegate;

@interface ZFCWaveActivityIndicatorView : UIView
/**
 设置矩形个数
 */
@property (readwrite, nonatomic) NSUInteger numbers;
/**
 设置间隔距离
 */
@property (readwrite, nonatomic) CGFloat internalSpacing;
/**
 设置矩形尺寸
 */
@property (readwrite, nonatomic) CGSize size;
/**
 设置动画延迟
 */
@property (readwrite, nonatomic) CGFloat delay;
/**
 设置动画持续时间
 */
@property (readwrite, nonatomic) CGFloat duration;


@property (strong, nonatomic) id<ZFCWaveActivityIndicatorViewDelegate> delegate;


- (void)startAnimating;

- (void)stopAnimating;

@end

@protocol ZFCWaveActivityIndicatorViewDelegate <NSObject>
@optional
/**
 设置每个矩形的颜色
 */
- (UIColor *)activityIndicatorView:(ZFCWaveActivityIndicatorView *)activityIndicatorView rectangleBackgroundColorAtIndex:(NSUInteger)index;

@end
