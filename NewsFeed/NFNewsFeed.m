//
//  NFNewsFeed.m
//  NewsFeed
//
//  Created by joehsieh on 2015/9/8.
//  Copyright (c) 2015年 JH. All rights reserved.
//

#import "NFNewsFeed.h"

@implementation NFNewsFeed
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"title": @"title",
             @"publisher": @"publisher",
             @"uuid": @"uuid"
             };
}

+ (NSArray *)newsFeedArrayFromAPIResponse:(NSArray *)inAPIResponse
{
    NSAssert([inAPIResponse isKindOfClass:[NSArray class]], @"response must be array");
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSDictionary *item in inAPIResponse) {
        NSError *error = nil;
        NFNewsFeed *newsFeed = [MTLJSONAdapter modelOfClass:NFNewsFeed.class fromJSONDictionary:item error:&error];
        [result addObject:newsFeed];
        for (NSDictionary *imageDict in item[@"images"]) {
            NSArray *tags = imageDict[@"tags"];
            for (NSString *tag in tags) {
                if ([tag isEqualToString:@"ios:size=square_large"]) {
                    NSString *thumbnailURLString = imageDict[@"url"];
                    if (thumbnailURLString) {
                        newsFeed.thumbnail = [NSURL URLWithString:imageDict[@"url"]];
                    }
                }
            }
        }
    }
    return [result copy];
}
@end
