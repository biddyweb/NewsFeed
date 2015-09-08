//
//  NFTableViewCell.m
//  NewsFeed
//
//  Created by joehsieh on 2015/9/8.
//  Copyright (c) 2015年 JH. All rights reserved.
//

#import "NFTableViewCell.h"
#import <SDWebImageDownloader.h>

@implementation NFTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setThumbnailURL:(NSURL *)thumbnailURL
{
    _thumbnailURL = thumbnailURL;
    if (!thumbnailURL) {
        return;
    }
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:thumbnailURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        self.thumbnailView.image = image;
    }];
}
@end
