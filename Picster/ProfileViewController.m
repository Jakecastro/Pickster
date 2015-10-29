//
//  ProfileViewController.m
//  Picster
//
//  Created by Jake Castro on 10/23/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileCollectionViewCell.h"
#import "UserCommentsTableViewController.h"
#import <Parse/Parse.h>
#import "User.h"


@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextBox;
@property (weak, nonatomic) IBOutlet UITextField *userBioTextBox;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UILabel *numberOfFollowersLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfFollowingLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPosts;
@property (weak, nonatomic) IBOutlet UICollectionView *userImagesCollectionView;

@property (strong,nonatomic) NSArray *dataArray;
@property (strong,nonatomic) User *profileUser;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.dataArray = [NSArray new];
    
    PFUser *user = [PFUser currentUser];
    //self.profileUser = [User currentUser];
    self.usernameTextBox.text = user.username;
    self.userBioTextBox.text = [user objectForKey:@"userBio"];
    
    
    
    PFQuery *photosFromCurrentUser = [PFQuery queryWithClassName:@"Post"];
    [photosFromCurrentUser whereKey:@"senderID" equalTo:[[PFUser currentUser] objectId]];
    [photosFromCurrentUser whereKeyExists:@"postImage"];

    [photosFromCurrentUser findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            //NSLog(@"yup");
            self.dataArray = objects;

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.userImagesCollectionView reloadData];
            });

        } else {
            NSLog(@"I AM ERROR");
        }
    }];

    self.userImageView.image = [UIImage imageNamed:@"Phil"];
}


- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProfileCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"userPhotoCell" forIndexPath:indexPath];

    PFFile *file = [[self.dataArray objectAtIndex:indexPath.row]objectForKey:@"postImage"];

    [file getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        cell.postImage.image = [UIImage imageWithData:data];
        //NSLog(@"%@",error);
    }];

    return cell;

}

- (IBAction)onEditButtonPressed:(UIButton *)sender {
    if ([self.userBioTextBox hasText]) {
        PFUser *user = [PFUser currentUser];
        [user setObject:self.userBioTextBox.text forKey:@"userBio"];
        //self.profileUser.bioString = self.userBioTextBox.text;
        [user saveInBackground];
    }
}

//- (void)collectionView:(UICollectionView ​*)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UICollectionViewCell *)sender {
    UINavigationController *nvc = segue.destinationViewController;
    UserCommentsTableViewController *ucVC = nvc.viewControllers[0];
//    UICollectionViewCell *cell = (UICollectionViewCell *)sender;
    NSIndexPath *indexPath = [self.userImagesCollectionView indexPathForCell:sender];

    Post *post = [self.dataArray objectAtIndex:indexPath.row];
    ucVC.postForComment = post;

}

@end
