//
//  NFNewsFeed.h
//  NewsFeed
//
//  Created by joehsieh on 2015/9/8.
//  Copyright (c) 2015年 JH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>
@interface NFNewsFeed : MTLModel <MTLJSONSerializing>
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *publisher;
@property (nonatomic, strong) NSURL *thumbnail;
@property (nonatomic, strong) NSString *uuid;
+ (NSArray *)newsFeedArrayFromAPIResponse:(NSArray *)inAPIResponse;
@end
