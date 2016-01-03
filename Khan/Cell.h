//
//  Cell.h
//  Khan
//
//  Created by Tyler Lacroix on 2015-12-23.
//  Copyright © 2015 Tyler Lacroix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UILabel *score;

@end
