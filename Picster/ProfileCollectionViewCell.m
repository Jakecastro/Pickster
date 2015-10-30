//
//  ProfileCollectionViewCell.m
//  Picster
//
//  Created by Jake Castro on 10/28/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "ProfileCollectionViewCell.h"

@implementation ProfileCollectionViewCell


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    if (self) {
        UILongPressGestureRecognizer *pgr = [[UILongPressGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(handleLong:)];
        [self addGestureRecognizer:pgr];
    }
    return self;
}

-(IBAction)handleLong:(UILongPressGestureRecognizer *)sender {

    [self.delegate profileCollectionViewCell:self didLongPressCell:sender];
}



@end
