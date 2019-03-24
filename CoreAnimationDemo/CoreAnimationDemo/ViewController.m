//
//  ViewController.m
//  CoreAnimationDemo
//
//  Created by Paul on 2018/10/8.
//  Copyright © 2018年 Paul. All rights reserved.
//

#import "ViewController.h"
#import "DemoListTableViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIButton *startBtn;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.startBtn.layer.borderColor = [UIColor redColor].CGColor;
}

- (IBAction)startBtnClickAction:(UIButton *)sender
{
    DemoListTableViewController *listViewController = [[DemoListTableViewController alloc] initWithNibName:@"DemoListTableViewController" bundle:[NSBundle mainBundle]];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:listViewController];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

@end
