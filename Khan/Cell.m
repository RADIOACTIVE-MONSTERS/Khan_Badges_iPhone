//
//  Cell.m
//  Khan
//
//  Created by Tyler Lacroix on 2015-12-23.
//  Copyright © 2015 Tyler Lacroix. All rights reserved.
//

#import "Cell.h"

@implementation Cell

/* Add a basic highlighting appearance when a cell is clicked */
-(void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}
-(void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.highlighted) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor(context, 0.95, 0.95, 0.95, 1);
        CGContextFillRect(context, self.bounds);
    }
}

@end
