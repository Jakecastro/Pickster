//
//  HomeTableViewCell.h
//  Picster
//
//  Created by Jake Castro on 10/30/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *feedView;

@end
