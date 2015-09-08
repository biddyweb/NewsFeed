//
//  NFTableViewController.m
//  NewsFeed
//
//  Created by joehsieh on 2015/9/8.
//  Copyright (c) 2015年 JH. All rights reserved.
//

#import "NFAPI.h"
#import "NFTableViewController.h"
#import "NFDetailViewController.h"

#import "NFTableViewCell.h"
#import "NFNewsFeed.h"

static NSString *const kCellIdentifier = @"kCellIdentifier";

@interface NFTableViewController ()
@property (nonatomic, strong) NSArray *newsFeedArray;
@property (nonatomic, strong) NSArray *currentUUIDArray;
@property (nonatomic, strong) UIRefreshControl *newsFeedRefreshControl;
@end

@implementation NFTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"NFTableViewCell" bundle:nil] forCellReuseIdentifier:kCellIdentifier];
    
    self.newsFeedRefreshControl = [[UIRefreshControl alloc] init];
    [self.newsFeedRefreshControl addTarget:self action:@selector(nf_pullToRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.newsFeedRefreshControl atIndex:0];
    
    [[NFAPI sharedAPI] fetchNewsFeed:^(NSArray *newsFeedArray, NSError *error) {
        if (error) {
            return;
        }
        self.newsFeedArray = newsFeedArray;
        [self.tableView reloadData];
    }];
}

- (void)nf_pullToRefresh:(id)sender
{
    [self.newsFeedRefreshControl beginRefreshing];
    [[NFAPI sharedAPI] fetchNewsFeed:^(NSArray *newsFeedArray, NSError *error) {
        [self.newsFeedRefreshControl endRefreshing];
        if (error) {
            return;
        }
        self.newsFeedArray = newsFeedArray;
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.newsFeedArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    NFNewsFeed *newsFeed = self.newsFeedArray[indexPath.row];
    cell.titleLabel.text = newsFeed.title;
    cell.publiserLabel.text = newsFeed.publisher;
    cell.thumbnailURL = newsFeed.thumbnail;
    
    if (indexPath.row == [self.newsFeedArray count] - 1) {
        if ([self.currentUUIDArray count] == 0) {
            self.currentUUIDArray = [self.newsFeedArray valueForKey:@"uuid"];
        }
       [[NFAPI sharedAPI] fetchInflationForItems:self.currentUUIDArray callback:^(NSArray *newsFeedArray, NSError *error) {
           if (error) {
               return;
           }
           self.currentUUIDArray = [newsFeedArray valueForKey:@"uuid"];
           NSMutableArray *mutableArray = [self.newsFeedArray mutableCopy];
           [mutableArray addObjectsFromArray:newsFeedArray];
           self.newsFeedArray = [mutableArray copy];
           [self.tableView reloadData];
       }];
    }
    return cell;
}

#pragma mark UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NFNewsFeed *newsFeed = self.newsFeedArray[indexPath.row];
    NFDetailViewController *vc = [[NFDetailViewController alloc] initWithNewsFeed:newsFeed];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
