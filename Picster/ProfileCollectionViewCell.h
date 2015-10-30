//
//  ProfileCollectionViewCell.h
//  Picster
//
//  Created by Jake Castro on 10/28/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@protocol ProfileCollectionViewCellDelegate <NSObject>

- (void) profileCollectionViewCell:(id)cell didLongPressCell:(UILongPressGestureRecognizer *)sender;

@end

@interface ProfileCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *postImage;

@property id<ProfileCollectionViewCellDelegate> delegate;

@end
