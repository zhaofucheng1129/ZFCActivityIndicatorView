//
//  ZFCMainViewController.m
//  ZFCActivityIndicatorViewDemo
//
//  Created by 赵 福成 on 14-6-18.
//  Copyright (c) 2014年 ZhaoFucheng. All rights reserved.
//

#import "ZFCMainViewController.h"
#import "Common.h"
#import "ZFCRotatingPlaneActivityIndicatorView.h"
#import "ZFCDoubleBounceActivityIndicatorView.h"
#import "ZFCWaveActivityIndicatorView.h"
#import "ZFCWanderingCubesActivityIndicatorView.h"
@interface ZFCMainViewController ()

@end

@implementation ZFCMainViewController
UIScrollView *scrollView;
UIPageControl *page;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColorMake(211, 84, 0,1);
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, UIScreenWidth, 400)];
    scrollView.delegate = self;
    scrollView.center = self.view.center;
    scrollView.contentSize = CGSizeMake(UIScreenWidth*4, 400);
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.directionalLockEnabled = YES;
    scrollView.alwaysBounceVertical = NO;
    [self.view addSubview:scrollView];
    
    page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, UIScreenHeight - 80, UIScreenWidth, 80)];
    page.numberOfPages = 4;
    [self.view addSubview:page];
    
    
    ZFCRotatingPlaneActivityIndicatorView *rotatingPlane = [[ZFCRotatingPlaneActivityIndicatorView alloc] init];
    rotatingPlane.center = CGPointMake(UIScreenWidth/2, 200);
    [rotatingPlane startAnimating];
    [scrollView addSubview:rotatingPlane];
    [NSTimer scheduledTimerWithTimeInterval:7 target:rotatingPlane selector:@selector(stopAnimating) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:9 target:rotatingPlane selector:@selector(startAnimating) userInfo:nil repeats:NO];
    
    ZFCDoubleBounceActivityIndicatorView *doubleBounce = [[ZFCDoubleBounceActivityIndicatorView alloc] init];
    doubleBounce.center = CGPointMake(UIScreenWidth*1.5, 200);
    [doubleBounce startAnimating];
    [scrollView addSubview:doubleBounce];
    [NSTimer scheduledTimerWithTimeInterval:7 target:doubleBounce selector:@selector(stopAnimating) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:9 target:doubleBounce selector:@selector(startAnimating) userInfo:nil repeats:NO];
    
    ZFCWaveActivityIndicatorView *waveActivityIndicator = [[ZFCWaveActivityIndicatorView alloc] init];
    waveActivityIndicator.center = CGPointMake(UIScreenWidth*2.5, 200);
    waveActivityIndicator.delegate = self;
    [waveActivityIndicator startAnimating];
    [scrollView addSubview:waveActivityIndicator];
    [NSTimer scheduledTimerWithTimeInterval:7 target:waveActivityIndicator selector:@selector(stopAnimating) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:9 target:waveActivityIndicator selector:@selector(startAnimating) userInfo:nil repeats:NO];
    
    ZFCWanderingCubesActivityIndicatorView *wanderingCubes = [[ZFCWanderingCubesActivityIndicatorView alloc] init];
    wanderingCubes.center = CGPointMake(UIScreenWidth*3.5, 200);
    [wanderingCubes startAnimating];
    [scrollView addSubview:wanderingCubes];
    [NSTimer scheduledTimerWithTimeInterval:7 target:wanderingCubes selector:@selector(stopAnimating) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:9 target:wanderingCubes selector:@selector(startAnimating) userInfo:nil repeats:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger currentPage = floor((scrollView.contentOffset.x - UIScreenWidth/2)/UIScreenWidth ) + 1;
    page.currentPage = currentPage;
}

//- (UIColor *)activityIndicatorView:(ZFCWaveActivityIndicatorView *)activityIndicatorView rectangleBackgroundColorAtIndex:(NSUInteger)index
//{
//    CGFloat red   = (arc4random() % 256)/255.0;
//    CGFloat green = (arc4random() % 256)/255.0;
//    CGFloat blue  = (arc4random() % 256)/255.0;
//    CGFloat alpha = 1.0f;
//    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
//}

@end
