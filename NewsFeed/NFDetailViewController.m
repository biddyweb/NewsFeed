//
//  NFDetailViewController.m
//  NewsFeed
//
//  Created by joehsieh on 2015/9/8.
//  Copyright (c) 2015年 JH. All rights reserved.
//

#import "NFDetailViewController.h"
#import "NFNewsFeed.h"
#import "NFAPI.h"

#import "SDWebImageDownloader.h"

@interface NFDetailViewController ()
@property (nonatomic, strong) NFNewsFeed *newsFeed;
@end

@implementation NFDetailViewController

- (instancetype)initWithNewsFeed:(NFNewsFeed *)inNewsFeed
{
    self = [super initWithNibName:@"NFDetailViewController" bundle:nil];
    if (self) {
        self.newsFeed = inNewsFeed;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.publisherLabel.text = self.newsFeed.publisher;
    self.titleLabel.text = self.newsFeed.title;
    
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:self.newsFeed.thumbnail options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        self.thumbnailView.image = image;
    }];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
