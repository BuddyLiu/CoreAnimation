//
//  AnimationViews.m
//  CoreAnimationDemo
//
//  Created by Paul on 2018/10/8.
//  Copyright © 2018年 Paul. All rights reserved.
//

#import "AnimationViews.h"

@implementation AnimationViews

static AnimationViews *animationViews;
+(AnimationViews *)sharedIstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        animationViews = [[AnimationViews alloc] init];
    });
    return animationViews;
}

-(NSArray *)createAnimationViews
{
    NSMutableArray *mArr = [NSMutableArray new];
    [mArr addObject:[self createAnimationViewsDatasWithTitle:@"CABasicAnimation" view:[self createCABasicAnimationView]]];
    [mArr addObject:[self createAnimationViewsDatasWithTitle:@"KeyFrameAnimation" view:[self createKeyFrameAnimationView]]];
    [mArr addObject:[self createAnimationViewsDatasWithTitle:@"ShapeLayerAnimation" view:[self createShapeLayerAnimationView]]];
    [mArr addObject:[self createAnimationViewsDatasWithTitle:@"HourglassView" view:[self createHourglassView]]];
    return [mArr copy];
}

-(AnimationViewsDatas *)createAnimationViewsDatasWithTitle:(NSString *)title view:(UIView *)view
{
    AnimationViewsDatas *animationViewsDatas = [[AnimationViewsDatas alloc] init];
    animationViewsDatas.title = title;
    animationViewsDatas.view = view;
    return animationViewsDatas;
}

-(UIView *)createCABasicAnimationView
{
    BasicAnimationView *animationView = [[BasicAnimationView alloc] initWithFrame:CGRectMake((ScreenWidth- 120)/2.0,
                                                                                             50,
                                                                                             120,
                                                                                             120)];
    animationView.backgroundColor = [UIColor whiteColor];
    animationView.clipsToBounds = YES;
    animationView.layer.cornerRadius = 10;
    animationView.layer.borderWidth = 1.0;
    animationView.layer.borderColor = [UIColor blackColor].CGColor;
    
    return animationView;
}

-(UIView *)createKeyFrameAnimationView
{
    KeyFrameAnimationView *animationView = [[KeyFrameAnimationView alloc] initWithFrame:CGRectMake((ScreenWidth- 120)/2.0,
                                                                                                   50,
                                                                                                   120,
                                                                                                   120)];
    animationView.backgroundColor = [UIColor whiteColor];
    animationView.clipsToBounds = YES;
    animationView.layer.cornerRadius = 10;
    animationView.layer.borderWidth = 1.0;
    animationView.layer.borderColor = [UIColor blackColor].CGColor;
    
    return animationView;
}

-(UIView *)createShapeLayerAnimationView
{
    ShapeLayerAnimationView *animationView = [[ShapeLayerAnimationView alloc] initWithFrame:CGRectMake((ScreenWidth- 320)/2.0,
                                                                                                       50,
                                                                                                       320,
                                                                                                       320)];
    animationView.backgroundColor = [UIColor whiteColor];
    //    animationView.clipsToBounds = YES;
    //    animationView.layer.cornerRadius = 10;
    //    animationView.layer.borderWidth = 1.0;
    //    animationView.layer.borderColor = [UIColor blackColor].CGColor;
    
    return animationView;
}

-(UIView *)createHourglassView
{
    HourglassView *animationView = [[HourglassView alloc] initWithFrame:CGRectMake((ScreenWidth- 240)/2.0,
                                                                                   50,
                                                                                   240,
                                                                                   320)];
    animationView.backgroundColor = [UIColor whiteColor];
    
    return animationView;
}

@end

@implementation AnimationViewsDatas

@end

