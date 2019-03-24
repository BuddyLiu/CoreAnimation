//
//  AnimationViews.h
//  CoreAnimationDemo
//
//  Created by Paul on 2018/10/8.
//  Copyright © 2018年 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BasicAnimationView.h"
#import "KeyFrameAnimationView.h"
#import "ShapeLayerAnimationView.h"
#import "HourglassView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface AnimationViews : NSObject

+(AnimationViews *)sharedIstance;

-(NSArray *)createAnimationViews;

@end

@interface AnimationViewsDatas : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIView *view;

@end
