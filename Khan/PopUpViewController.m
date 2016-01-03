//
//  PopUpViewController.h
//  Khan
//
//  Created by Tyler Lacroix on 2015-12-23.
//  Copyright © 2015 Tyler Lacroix. All rights reserved.
//

#import "PopUpViewController.h"

@interface PopUpViewController ()

@end

@implementation PopUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.6];
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

/* Close the popup */
- (IBAction)closePopup:(id)sender {
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
        }
    }];
}

/* Load the popup with the badge info */
- (void)showBadge:(Badge*)badge
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
        self.view.frame = CGRectMake(0, 0, currentWindow.frame.size.width, currentWindow.frame.size.height);
        [currentWindow addSubview:self.view];
        self.view.layer.zPosition = 1000;
        [self.logoImg sd_setImageWithURL:[NSURL URLWithString:badge.image]];
        self.messageLabel.text = badge.description_extended;
        self.badgeTitle.text = badge.descript;
        
        if (badge.points > 0) {
            self.pointLabel.text = [NSString stringWithFormat:@"%d    ", badge.points];
            self.pointLabel.hidden = NO;
            [self.pointLabel setBackgroundColor:[UIColor colorWithRed:0 green:90.0/256.0 blue:136.0/256.0 alpha:0.8]];
            [self.pointLabel sizeToFit];
            CGRect frame = self.pointLabel.frame;
            frame.size.width = frame.size.width + 100;
            [self.pointLabel setFrame:frame];
            self.pointLabel.layer.cornerRadius = 5.0;
            self.pointLabel.clipsToBounds = YES;
        }
        else {
            self.pointLabel.hidden = YES;
        }
        
        [self showAnimate];
    });
}

/* Add an animation */
- (void)showAnimate
{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

@end
