//
//  NFTableViewCell.h
//  NewsFeed
//
//  Created by joehsieh on 2015/9/8.
//  Copyright (c) 2015年 JH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NFTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *publiserLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailView;
@property (nonatomic, strong) NSURL *thumbnailURL;
@end
