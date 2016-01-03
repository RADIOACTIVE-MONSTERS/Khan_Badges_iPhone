//
//  ServerData.h
//  Khan
//
//  Created by Tyler Lacroix on 2015-12-23.
//  Copyright © 2015 Tyler Lacroix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Badge.h"

enum BADGE_FILTER
{
    ALL_BADGES = -1,
    METEORITE_BADGES,
    MOON_BADGES,
    EARTH_BADGES,
    SUN_BADGES,
    BLACK_HOLE_BADGES,
    CHALLENGE_BADGES
};

@protocol ServerDataDelegate <NSObject>
@required
- (void)finishedLoading;
@end

@interface ServerData : NSObject {
    NSMutableArray *badges;
    NSMutableDictionary *categories;
}


+ (void) loadData:(NSObject <ServerDataDelegate>*) callback;
+ (NSMutableArray*) getBadges:(enum BADGE_FILTER) filter;
+ (NSDictionary*) getBadgeCategories;

@end
