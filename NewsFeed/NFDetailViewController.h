//
//  NFDetailViewController.h
//  NewsFeed
//
//  Created by joehsieh on 2015/9/8.
//  Copyright (c) 2015年 JH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NFNewsFeed;
@interface NFDetailViewController : UIViewController
- (instancetype)initWithNewsFeed:(NFNewsFeed *)inNewsFeed;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *publisherLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailView;
@end
