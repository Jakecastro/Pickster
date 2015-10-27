//
//  User.h
//  Picster
//
//  Created by Jake Castro on 10/26/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <Parse/Parse.h>

@interface User : PFUser

@property UIImage *profileImage;
@property NSMutableArray *photosArray;
@property NSMutableArray *follwersArray;
@property NSMutableArray *followingArray;
@property NSString *bioString;


@end
