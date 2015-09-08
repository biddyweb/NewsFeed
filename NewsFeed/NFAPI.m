//
//  NFAPI.m
//  NewsFeed
//
//  Created by joehsieh on 2015/9/8.
//  Copyright (c) 2015年 JH. All rights reserved.
//

#import "NFAPI.h"
#import "NFNewsFeed.h"

static NSString *const kAPIBaseURLString = @"http://mhr.yql.yahoo.com/v1";

@implementation NFAPI
+ (instancetype)sharedAPI
{
    static NFAPI *API = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        API = [[NFAPI alloc] initWithBaseURL:[NSURL URLWithString:kAPIBaseURLString]];
        API.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return API;
}

- (NSURLSessionTask *)fetchNewsFeed:(void(^)(NSArray * newsFeedArray, NSError *error))inCallback
{
    return [[NFAPI sharedAPI] GET:@"newsfeed" parameters:@{@"all_content":@1} success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSArray *items = JSON[@"result"][@"items"];
        NSArray *result = [NFNewsFeed newsFeedArrayFromAPIResponse:items];
        if (inCallback) {
            inCallback(result, nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (inCallback) {
            inCallback(nil, error);
        }
    }];
}

- (NSURLSessionTask *)fetchInflationForItems:(NSArray *)inItemIDArray callback:(void(^)(NSArray *newsFeeds, NSError *error))inCallback
{
    NSString *allUUIDString = [inItemIDArray componentsJoinedByString:@","];
    return [[NFAPI sharedAPI] GET:@"newsitems" parameters:@{@"uuid":allUUIDString} success:^(NSURLSessionDataTask * __unused task, id JSON) {
         NSArray *items = JSON[@"result"][@"items"];
         NSArray *result = [NFNewsFeed newsFeedArrayFromAPIResponse:items];
        if (inCallback) {
            inCallback(result, nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (inCallback) {
            inCallback(nil, error);
        }
    }];
}
@end
