//
//  Post.m
//  Picster
//
//  Created by Jake Castro on 10/26/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "Post.h"

@implementation Post

@dynamic username;
@dynamic likesArray;
@dynamic commentsArray;
@dynamic postImage;

-(instancetype)initWithClassName:(NSString *)newClassName{

    return self;
}

+ (void)load {
    [self registerSubclass];
}
+ (NSString *)parseClassName{
    return @"Image";
}


@end
