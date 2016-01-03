//
//  ServerData.m
//  Khan
//
//  Created by Tyler Lacroix on 2015-12-23.
//  Copyright © 2015 Tyler Lacroix. All rights reserved.
//

#import "ServerData.h"

@implementation ServerData

static ServerData *singletonInstance;

- (id)init
{
    if (self = [super init])
    {
        badges = [[NSMutableArray alloc] init];
        categories = [[NSMutableDictionary alloc] init];
    }
    return self;
}

/* returns the shared instance of ServerData */
+ (ServerData *)sharedInstance
{
    if (!singletonInstance)
        NSLog(@"ServerData has not been initialized.");
    
    return singletonInstance;
}

/* load the JSONs */
+ (void) loadData:(NSObject <ServerDataDelegate>*) callback
{
    if (singletonInstance) {
        NSLog(@"Singleton instance already exists. You can only instantiate one instance of ServerData.");
        return;
    }
    singletonInstance = [[ServerData alloc] init];
    
    [singletonInstance ParseBadgeCategory];
    [singletonInstance ParseBadges:callback];
}

- (void)ParseBadges:(NSObject <ServerDataDelegate>*) callback
{
    // Make URL request with server
    NSString *jsonUrlString = [NSString stringWithFormat:@"http://www.khanacademy.org/api/v1/badges"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:jsonUrlString]
            completionHandler:^(NSData *responseData,
                                NSURLResponse *response,
                                NSError *error) {
                
                // JSON Parsing
                NSMutableArray *result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
                
                for (NSMutableDictionary *dic in result)
                {
                    Badge *badge = [[Badge alloc] init];
                    badge.icon = dic[@"icons"][@"email"];
                    badge.descript = dic[@"description"];
                    badge.description_extended = dic[@"safe_extended_description"];
                    badge.category = (int)[dic[@"badge_category"] integerValue];
                    badge.image = dic[@"icons"][@"large"];
                    badge.points = (int)[dic[@"points"] integerValue];
                    
                    [badges addObject:badge];
                }
                
                /* Sort the badges in the same order as the site */
                [badges sortUsingComparator:^NSComparisonResult(id a, id b) {
                    Badge *first = (Badge *)a;
                    Badge *second = (Badge *)b;
                    if ((first.category == second.category) && (first.points + second.points > 0)) {
                        if (first.points == 0)
                            return true;
                        else if (second.points == 0)
                            return false;
                        return first.points > second.points;
                    }
                    return first.category > second.category;
                }];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    /* Callback once the JSON has loaded and been parsed */
                    [callback finishedLoading];
                });
                
            }] resume];
}

- (void)ParseBadgeCategory
{
    // Make URL request with server
    NSString *jsonUrlString = [NSString stringWithFormat:@"http://www.khanacademy.org/api/v1/badges/categories"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:jsonUrlString]
            completionHandler:^(NSData *responseData,
                                NSURLResponse *response,
                                NSError *error) {
                // JSON Parsing
                NSMutableArray *result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
                
                for (NSMutableDictionary *dic in result)
                    [categories setObject:dic[@"type_label"] forKey:dic[@"category"]];
                
            }] resume];
}

/* return an array of the badges */
+ (NSMutableArray*) getBadges:(enum BADGE_FILTER) filter
{
    NSMutableArray * badg = [ServerData sharedInstance]->badges;
    if (filter == ALL_BADGES)
        return [[NSMutableArray alloc] initWithArray:badg];
    
    
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    for (int i = 0; i < badg.count; i++) {
        Badge *badge = [badg objectAtIndex:i];
        if (badge.category == filter) {
            [ret addObject:badge];
        }
    }
    return ret;
}

/* returns a dictonary of the categories */
+ (NSDictionary*) getBadgeCategories
{
    return [ServerData sharedInstance]->categories;
}

@end
