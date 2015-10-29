//
//  User.m
//  Picster
//
//  Created by Jake Castro on 10/26/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "User.h"

@implementation User

@dynamic profileImage;
@dynamic photosArray;
@dynamic follwersArray;
@dynamic followingArray;
@dynamic bioString;


-(instancetype)initWithClassName:(NSString *)newClassName{

    return self;
}

+ (void)load {
    [self registerSubclass];
}
+ (NSString *)parseClassName{
    return @"User";
}



@end
