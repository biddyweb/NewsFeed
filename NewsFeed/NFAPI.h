//
//  NFAPI.h
//  NewsFeed
//
//  Created by joehsieh on 2015/9/8.
//  Copyright (c) 2015年 JH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface NFAPI : AFHTTPSessionManager
+ (instancetype)sharedAPI;
/*! Fetch array of newsFeed */
- (NSURLSessionTask *)fetchNewsFeed:(void(^)(NSArray *newsFeedArray, NSError *error))inCallback;
- (NSURLSessionTask *)fetchInflationForItems:(NSArray *)inItemIDArray callback:(void(^)(NSArray *newsFeeds, NSError *error))inCallback;
@end
