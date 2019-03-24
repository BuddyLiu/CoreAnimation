//
//  DemoListTableViewController.m
//  CoreAnimationDemo
//
//  Created by Paul on 2018/10/8.
//  Copyright © 2018年 Paul. All rights reserved.
//

#import "DemoListTableViewController.h"
#import "DetailViewController.h"
#import "AnimationViews.h"

@interface DemoListTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation DemoListTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"Animations List";
    self.dataArray = [NSMutableArray arrayWithArray:[[AnimationViews sharedIstance] createAnimationViews]];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    if(indexPath.row < self.dataArray.count)
    {
        AnimationViewsDatas *animationViewsDatas = self.dataArray[indexPath.row];
        cell.textLabel.text = animationViewsDatas.title;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row < self.dataArray.count)
    {
        AnimationViewsDatas *animationViewsDatas = self.dataArray[indexPath.row];
        DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:[NSBundle mainBundle]];
        [detailViewController transferAnimationView:animationViewsDatas.view];
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}

- (NSMutableArray *)dataArray
{
    if(!_dataArray)
    {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

@end
