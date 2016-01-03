//
//  Badge.h
//  Khan
//
//  Created by Tyler Lacroix on 2015-12-23.
//  Copyright © 2015 Tyler Lacroix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Badge : NSObject
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *descript;
@property (strong, nonatomic) NSString *description_extended;
@property (nonatomic) int category;
@property (nonatomic) int points;

@end
