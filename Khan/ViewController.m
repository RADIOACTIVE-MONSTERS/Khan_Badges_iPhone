//
//  ViewController.m
//  Khan
//
//  Created by Tyler Lacroix on 2015-12-23.
//  Copyright © 2015 Tyler Lacroix. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSString *kCellID = @"cellID";
static ViewController *singletonInstance;

- (void)viewDidLoad {
    [super viewDidLoad];
    //Load JSONs from the API
    [ServerData loadData:self];
    
    singletonInstance = self;
    filter=ALL_BADGES;
    
    //Display a spinner until it finishes loading
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner setFrame:self.view.frame];
    [spinner.layer setBackgroundColor:[[UIColor colorWithWhite: 0.0 alpha:0.20] CGColor]];
    spinner.center = self.view.center;
    [spinner startAnimating];
    [self.view addSubview:spinner];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

#pragma mark Collection View Methods

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    badges = [ServerData getBadges:filter];
    if (badges) {
        return [badges count];
    }
    return 0;
}

/* Display each badge in a cell inside a collection view */
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Badge* badge = [badges objectAtIndex:indexPath.row];
    
    Cell *cell = [cv dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    cell.label.text = badge.descript;
    
    if (badge.points != 0) {
        cell.score.text = [@(badge.points) stringValue];
        cell.score.hidden = NO;
    }
    else {
        cell.score.hidden = YES;
    }
     
    [cell.image sd_setImageWithURL:[NSURL URLWithString:badge.icon]];
    
    return cell;
}

/* show the popup when a cell is clicked */
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.popViewController = [[PopUpViewController alloc] initWithNibName:@"PopUpView" bundle:nil];
    [self.popViewController showBadge:[badges objectAtIndex:indexPath.row]];
}

/* reload the table when a user changes the filter (from the slider) */
- (void) filterChanged:(enum BADGE_FILTER)_filter
{
    filter = _filter;
    badges = [ServerData getBadges:filter];
    [self.collectionView reloadData];
}

/* called when the JSONs are done loading. The spinner is removed and the table is reloaded. */
- (void)finishedLoading {
    badges = [ServerData getBadges:filter];
    [self.collectionView reloadData];
    [spinner removeFromSuperview];
}

+ (ViewController *)sharedInstance
{
    if (!singletonInstance)
        NSLog(@"ViewController has not been initialized.");
    
    return singletonInstance;
}

@end
