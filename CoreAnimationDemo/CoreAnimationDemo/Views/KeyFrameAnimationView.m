//
//  KeyFrameAnimationView.m
//  CoreAnimationDemo
//
//  Created by Paul on 2018/10/8.
//  Copyright © 2018年 Paul. All rights reserved.
//

#import "KeyFrameAnimationView.h"

@interface KeyFrameAnimationView()

@property (nonatomic, strong) UIButton *keyBtn;
@property (nonatomic, strong) CAKeyframeAnimation *keyFrameAnimation;

@end

@implementation KeyFrameAnimationView

-(void)refreshKeyFrameAnimationView
{
    [self.keyBtn.layer removeAllAnimations];
    [self.keyBtn removeFromSuperview];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    self.keyBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.keyBtn.frame = CGRectMake((self.frame.size.width - 60)/2.0, (self.frame.size.width - 60)/2.0, 60, 60);
    [self.keyBtn setImage:[UIImage imageNamed:@"loading"] forState:(UIControlStateNormal)];
    [self addkeyFrameAnimationToView:self.keyBtn];
    [self addSubview:self.keyBtn];
}

-(void)addkeyFrameAnimationToView:(UIView *)view
{
    self.keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    NSArray *rotationArray = @[@(0), @(M_PI), @(M_PI*2)];
    self.keyFrameAnimation.values = rotationArray;
    self.keyFrameAnimation.rotationMode = kCAAnimationRotateAuto;
    self.keyFrameAnimation.duration = 1.5;
    self.keyFrameAnimation.keyTimes = @[@(0), @(0.5), @(1)];
    self.keyFrameAnimation.repeatCount = CGFLOAT_MAX;
    [view.layer addAnimation:self.keyFrameAnimation forKey:@"self.keyFrameAnimation"];
}

@end
