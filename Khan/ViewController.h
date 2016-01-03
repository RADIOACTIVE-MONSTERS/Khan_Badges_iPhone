//
//  ViewController.h
//  Khan
//
//  Created by Tyler Lacroix on 2015-12-23.
//  Copyright © 2015 Tyler Lacroix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "Cell.h"
#import "ServerData.h"
#import "UIImageView+WebCache.h"
#import "PopUpViewController.h"

@interface ViewController : UIViewController  <SlideNavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, ServerDataDelegate> {
    NSMutableArray *badges;
    enum BADGE_FILTER filter;
    UIActivityIndicatorView *spinner;
}

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) PopUpViewController *popViewController;

- (void) filterChanged:(enum BADGE_FILTER)filter;

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;

+ (ViewController *)sharedInstance;

@end

