//
//  Comment.m
//  Picster
//
//  Created by Jake Castro on 10/27/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "Activity.h"

@implementation Activity

@dynamic username;
@dynamic commentText;

-(instancetype)initWithClassName:(NSString *)newClassName{

    return self;
}

//+ (void)load {
//    [self registerSubclass];
//}
+ (NSString *)parseClassName{
    return @"Comment";
}

@end
