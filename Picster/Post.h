//
//  Post.h
//  Picster
//
//  Created by Jake Castro on 10/26/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <Parse/Parse.h>

@interface Post : PFObject

@property NSMutableArray *commentsArray;
@property UIImage *postImage;
@property CLLocation *location;
@property NSInteger likeCount;

@end
