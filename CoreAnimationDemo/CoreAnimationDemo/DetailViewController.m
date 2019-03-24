//
//  DetailViewController.m
//  CoreAnimationDemo
//
//  Created by Paul on 2018/10/8.
//  Copyright © 2018年 Paul. All rights reserved.
//

#import "DetailViewController.h"
#import "BasicAnimationView.h"
#import "KeyFrameAnimationView.h"
#import "ShapeLayerAnimationView.h"
#import "HourglassView.h"

@interface DetailViewController ()

@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (nonatomic, strong) UIView *animationView;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreshAnimationView:self.animationView];
}

-(void)transferAnimationView:(UIView *)animationView
{
    self.animationView = animationView;
}

- (IBAction)refreshBtnAction:(UIButton *)sender
{
    [self refreshAnimationView:self.animationView];
}

-(void)refreshAnimationView:(UIView *)animationView
{
    self.animationView.alpha = 0;
    if([self.animationView class] == [BasicAnimationView class])
    {
        BasicAnimationView *basicAnimationView = (BasicAnimationView *)self.animationView;
        [basicAnimationView refreshBasicAnimationView];
    }
    else if([self.animationView class] == [KeyFrameAnimationView class])
    {
        KeyFrameAnimationView *keyFrameAnimationView = (KeyFrameAnimationView *)self.animationView;
        [keyFrameAnimationView refreshKeyFrameAnimationView];
    }
    else if([self.animationView class] == [ShapeLayerAnimationView class])
    {
        ShapeLayerAnimationView *shapeLayerAnimationView = (ShapeLayerAnimationView *)self.animationView;
        [shapeLayerAnimationView refreshShapeLayerAnimationView];
    }
    else if([self.animationView class] == [HourglassView class])
    {
        HourglassView *hourglassView = (HourglassView *)self.animationView;
        [hourglassView refreshHourglassView];
    }
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.animationView.alpha = 1;
        [weakSelf.mainView addSubview:weakSelf.animationView];
    }];
}

-(void)dealloc
{
    self.mainView = nil;
    self.animationView = nil;
}

@end
