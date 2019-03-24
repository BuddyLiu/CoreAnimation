//
//  HourglassView.h
//  CoreAnimationDemo
//
//  Created by Paul on 2018/10/9.
//  Copyright © 2018年 Qinghu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HourglassView : UIView

/**
 刷新视图
 */
-(void)refreshHourglassView;

/**
 刷新视图
 指定总时长
 @param timeSecond 总时长
 */
-(void)refreshHourglassViewWithWholeTime:(NSUInteger)timeSecond;

/**
 开始计时
 */
-(void)startTimer;

/**
 结束计时
 */
-(void)stopTimer;

/**
 添加小球
 */
-(void)addBallManual;

@end
