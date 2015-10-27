//
//  Comment.h
//  Picster
//
//  Created by Jake Castro on 10/27/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <Parse/Parse.h>

@interface Comment : PFObject

@property PFUser *commentCreator;
@property NSString *commentText;

@end
