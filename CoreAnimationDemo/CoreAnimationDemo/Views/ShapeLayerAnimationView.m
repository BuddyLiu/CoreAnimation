//
//  ShapeLayerAnimationView.m
//  CoreAnimationDemo
//
//  Created by Paul on 2018/10/8.
//  Copyright © 2018年 Paul. All rights reserved.
//

#import "ShapeLayerAnimationView.h"

static CGFloat roundUnit = 12;
static CGFloat unit = 60;

@implementation ShapeLayerAnimationView

-(void)refreshShapeLayerAnimationView
{
    [self.layer removeAllAnimations];
    NSArray *layers = [self.layer.sublayers copy];
    for (CAShapeLayer *layer in layers)
    {
        [layer removeAllAnimations];
        [layer removeFromSuperlayer];
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    //圆环
    [self.layer addSublayer:[self createRoundShapeLayerWithCenter:CGPointMake(rect.size.width/2.0, rect.size.height/2.0)
                                                           radius:rect.size.width/2.0-10
                                                       startAngle:0
                                                         endAngle:M_PI*2.0
                                                        clockwise:YES
                                                      strokeColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]
                                                        fillColor:[UIColor clearColor]
                                                        lineWidth:5.0]];
    //背景环
    [self.layer addSublayer:[self createRoundShapeLayerWithCenter:CGPointMake(rect.size.width/2.0, rect.size.height/2.0)
                                                           radius:rect.size.width/2-120
                                                       startAngle:0
                                                         endAngle:M_PI*2.0
                                                        clockwise:YES
                                                      strokeColor:[[UIColor blackColor] colorWithAlphaComponent:0.1]
                                                        fillColor:[[UIColor blackColor] colorWithAlphaComponent:0.2]
                                                        lineWidth:5.0]];
    //刻度
    for (int i = 1; i < 61; i++)
    {
        UIColor *lineColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        CGFloat lineLength = 10;
        if(i%5 == 0)
        {
            lineLength = 15;
            lineColor = [UIColor blackColor];
        }
        CGFloat radius = rect.size.width/2.0 - 20;
        CGFloat radiusIn = radius - lineLength;
        CGFloat angle = i*1.0/60.0*(2*M_PI);
        CGPoint borderLineStartPoint = [self getTimerPointWithRadius:radius angle:angle];
        CGPoint boderLineEndPoint = [self getTimerPointWithRadius:radiusIn angle:angle];
        CAShapeLayer *shapeLayerBorderLine = [self createLineShapeLayerWithStartPoint:borderLineStartPoint
                                                                             endPoint:boderLineEndPoint
                                                                          anchorPoint:CGPointMake(0, 0)
                                                                            lineWidth:2.0
                                                                          strokeColor:lineColor
                                                                            fillColor:[UIColor blackColor]
                                                                      relativelyPoint:CGPointMake(rect.size.width/2.0, rect.size.height/2.0)];
        [self.layer addSublayer:shapeLayerBorderLine];
    }
    
    for (int i = 1; i < 13; i++)
    {
        CATextLayer *textLayer = [CATextLayer layer];
        CGFloat radius = rect.size.width/2.0 - 50;
        CGFloat angle = i*1.0/12.0*(2*M_PI);
        CGPoint borderTextPoint = [self getTimerPointWithRadius:radius angle:angle];
        textLayer.bounds = CGRectMake(0, 0, 20, 20);
        textLayer.position = CGPointMake(borderTextPoint.x + rect.size.width/2.0, borderTextPoint.y + rect.size.height/2.0);
        textLayer.string = [NSString stringWithFormat:@"%d", i];
        textLayer.fontSize = 15;
        textLayer.wrapped = YES;
        textLayer.alignmentMode = kCAAlignmentCenter;
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        textLayer.foregroundColor = [UIColor blackColor].CGColor;
        [self.layer addSublayer:textLayer];
    }
    
    //时针
    CGPoint hourStartPoint = CGPointMake(rect.size.height/2.0, rect.size.height/2.0);
    CGFloat angleHour = [self getAngleWithFormat:@"hh"];
    if(angleHour >= 2*M_PI) {
        angleHour = 0;
    }
    CGPoint hourEndPoint = [self getTimerPointWithRadius:rect.size.height/2.0 - 80 angle:angleHour + [self getAngleWithFormat:@"mm"]/12.0];
    CAShapeLayer *shapeLayerHour = [self createLineShapeLayerWithStartPoint:CGPointZero
                                                                   endPoint:hourEndPoint
                                                                anchorPoint:CGPointMake(0.5, 0.5)
                                                                  lineWidth:8.0
                                                                strokeColor:[UIColor blackColor]
                                                                  fillColor:[UIColor blackColor]
                                                            relativelyPoint:hourStartPoint];
    [self addKeyFrameAnimateToShapeLayer:shapeLayerHour duration:unit*unit*roundUnit key:@"HourLayer"];
    [self.layer addSublayer:shapeLayerHour];
    
    //分针
    CGPoint minuteStartPoint = CGPointMake(rect.size.height/2.0, rect.size.height/2.0);
    CGPoint minuteEndPoint = [self getTimerPointWithRadius:rect.size.height/2.0 - 60 angle:[self getAngleWithFormat:@"mm"] + [self getAngleWithFormat:@"ss"]/60.0];
    CAShapeLayer *shapeLayerMinute = [self createLineShapeLayerWithStartPoint:CGPointZero
                                                                     endPoint:minuteEndPoint
                                                                  anchorPoint:CGPointMake(0.5, 0.5)
                                                                    lineWidth:5.0
                                                                  strokeColor:[UIColor darkGrayColor]
                                                                    fillColor:[UIColor blackColor]
                                                              relativelyPoint:minuteStartPoint];
    [self addKeyFrameAnimateToShapeLayer:shapeLayerMinute duration:unit*unit key:@"MinLayer"];
    [self.layer addSublayer:shapeLayerMinute];

    //秒针
    CGPoint secondStartPoint = CGPointMake(rect.size.height/2.0, rect.size.height/2.0);
    CGPoint secondEndPoint = [self getTimerPointWithRadius:rect.size.height/2.0 - 40 angle:[self getAngleWithFormat:@"ss"]];
    CAShapeLayer *shapeLayerSecond = [self createLineShapeLayerWithStartPoint:CGPointZero
                                                                     endPoint:secondEndPoint
                                                                  anchorPoint:CGPointMake(0.5, 0.5)
                                                                    lineWidth:2.0
                                                                  strokeColor:[UIColor redColor]
                                                                    fillColor:[UIColor blackColor]
                                                              relativelyPoint:secondStartPoint];
    [self addKeyFrameAnimateToShapeLayer:shapeLayerSecond duration:unit key:@"SecLayer"];
    [self.layer addSublayer:shapeLayerSecond];
    
    //圆心
    [self.layer addSublayer:[self createRoundShapeLayerWithCenter:CGPointMake(rect.size.width/2.0, rect.size.height/2.0)
                                                           radius:10
                                                       startAngle:0
                                                         endAngle:M_PI*2.0
                                                        clockwise:YES
                                                      strokeColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5]
                                                        fillColor:[UIColor blackColor]
                                                        lineWidth:5.0]];
}

-(void)addKeyFrameAnimateToShapeLayer:(CAShapeLayer *)layer duration:(CGFloat)duration key:(NSString *)key
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.values = @[@(0), @(M_PI*2.0)];
    animation.keyTimes = @[@(0), @(1)];
    animation.duration = duration;
    animation.repeatCount = CGFLOAT_MAX;
    animation.removedOnCompletion = NO;
    [layer addAnimation:animation forKey:key];
}

-(CAShapeLayer *)createRoundShapeLayerWithCenter:(CGPoint)center
                                         radius:(CGFloat)radius
                                     startAngle:(CGFloat)startAngle
                                       endAngle:(CGFloat)endAngle
                                      clockwise:(BOOL)clockwise
                                    strokeColor:(UIColor *)strokeColor
                                      fillColor:(UIColor *)fillColor
                                      lineWidth:(CGFloat)lineWidth
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = strokeColor.CGColor;
    shapeLayer.fillColor = fillColor.CGColor;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    return shapeLayer;
}

-(CAShapeLayer *)createLineShapeLayerWithStartPoint:(CGPoint)startPoint
                                           endPoint:(CGPoint)endPoint
                                        anchorPoint:(CGPoint)anchorPoint
                                          lineWidth:(CGFloat)lineWidth
                                        strokeColor:(UIColor *)strokeColor
                                          fillColor:(UIColor *)fillColor
                                    relativelyPoint:(CGPoint)relativelyPoint
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = strokeColor.CGColor;
    shapeLayer.fillColor = fillColor.CGColor;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    shapeLayer.position = relativelyPoint;
//    shapeLayer.anchorPoint = anchorPoint;
    
    return shapeLayer;
}

-(CGPoint)getTimerPointWithRadius:(CGFloat)radius angle:(CGFloat)angle
{
    CGPoint timerPoint = CGPointZero;
    if(angle > 0 && angle <= M_PI/2.0)
    {
        //第一象限
        timerPoint = ({
            CGPoint point = timerPoint;
            point.x += radius*sin(angle);
            point.y -= radius*cos(angle);
            point;
        });
    }
    else if(angle > M_PI/2.0 && angle <= M_PI)
    {
        //第二象限
        timerPoint = ({
            CGPoint point = timerPoint;
            point.x += radius*sin(M_PI - angle);
            point.y += radius*cos(M_PI - angle);
            point;
        });
    }
    else if(angle > M_PI && angle <= M_PI*3.0/2.0)
    {
        //第三象限
        timerPoint = ({
            CGPoint point = timerPoint;
            point.x -= radius*sin(angle - M_PI);
            point.y += radius*cos(angle - M_PI);
            point;
        });
    }
    else if(angle > M_PI*3.0/2.0 && angle <= M_PI*2.0)
    {
        //第四象限
        timerPoint = ({
            CGPoint point = timerPoint;
            point.x -= radius*sin(2.0*M_PI - angle);
            point.y -= radius*cos(2.0*M_PI - angle);
            point;
        });
    }
    else
    {
        
    }
    return timerPoint;
}

-(CGFloat)getAngleWithFormat:(NSString *)dateFormatter
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormatter];
    NSString *timerStr = [formatter stringFromDate:date];
    if([timerStr hasPrefix:@"0"])
    {
        timerStr = [timerStr stringByReplacingOccurrencesOfString:@"0" withString:@""];
    }
    timerStr = [NSString stringWithFormat:@"%@.0",timerStr];
    CGFloat timerUnit = 60.0;
    if([dateFormatter isEqual:@"hh"])
    {
        timerUnit = 12.0;
    }
    return ([timerStr floatValue]/timerUnit)*(2*M_PI);
}

@end
