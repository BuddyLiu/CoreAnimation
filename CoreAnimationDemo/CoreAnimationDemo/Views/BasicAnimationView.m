//
//  BasicAnimationView.m
//  CoreAnimationDemo
//
//  Created by Paul on 2018/10/8.
//  Copyright © 2018年 Paul. All rights reserved.
//

#import "BasicAnimationView.h"

@interface BasicAnimationView()

@property (nonatomic, strong) CABasicAnimation *basicAnimation;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) UIButton *detailBtn;

@end

@implementation BasicAnimationView

-(void)refreshBasicAnimationView
{
    [self.detailBtn.layer removeAllAnimations];
    [self.detailBtn removeFromSuperview];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    self.detailBtn = [UIButton buttonWithType:(UIButtonTypeInfoDark)];
    [self.detailBtn setFrame:CGRectMake((self.frame.size.width - 44)/2.0, 0, 44, 44)];
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(watchMyViewAction)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    
    [self addAnimationToView:self.detailBtn];
    [self addSubview:self.detailBtn];
}

- (void)watchMyViewAction
{
    CALayer *presentationLayer = self.detailBtn.layer.presentationLayer;
    [self handleMaskViewWithMyViewFrame:presentationLayer.frame];
}

- (void)handleMaskViewWithMyViewFrame:(CGRect)myFrame
{
    self.detailBtn.alpha = 1 - myFrame.origin.y/self.frame.size.height;
}

-(void)addAnimationToView:(UIView *)view
{
    self.basicAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    self.basicAnimation.duration = 1.0; //动画时间
    self.basicAnimation.fromValue = @(view.center.y); //动画起始值
    self.basicAnimation.toValue = @(self.frame.size.height - view.frame.size.height/2.0); //动画结束值
    self.basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    self.basicAnimation.autoreverses = YES;
    self.basicAnimation.repeatCount = CGFLOAT_MAX;
    self.basicAnimation.removedOnCompletion = NO;
    self.basicAnimation.fillMode = kCAFillModeForwards;
    
    [view.layer addAnimation:self.basicAnimation forKey:@"DetailBtnAnimation"];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    UIButton *button = (UIButton *)object;
    if ([@"center" isEqualToString:keyPath])
    {
        NSLog(@"view.center.y的enabled属性改变了%@\nbutton.center.y:%@",[change objectForKey:@"new"], @(button.center.y));
    }
}

@end
