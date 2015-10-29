//
//  ProfileViewController.m
//  Picster
//
//  Created by Jake Castro on 10/23/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileCollectionViewCell.h"
#import <Parse/Parse.h>


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

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    PFUser *user = [PFUser currentUser];
//    PFQuery *query = [PFQuery queryWithClassName:@"User"];
//    [query whereKey:@"username" equalTo:user.username];
//    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//        self.dataArray = objects;
//        NSLog(@"%@",objects[0]);
//    }];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.dataArray = [NSArray new];

    PFQuery *photosFromCurrentUser = [PFQuery queryWithClassName:@"Post"];
    [photosFromCurrentUser whereKey:@"senderID" equalTo:[[PFUser currentUser] objectId]];
    [photosFromCurrentUser whereKeyExists:@"postImage"];

    [photosFromCurrentUser findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            //NSLog(@"%@", objects);
            NSLog(@"yup");
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProfileCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"userPhotoCell" forIndexPath:indexPath];

    //PFImageView *imageView = [PFImageView new];

    //PFFile *file =[self.dataArray objectAtIndex:indexPath.row];
    PFFile *file = [[self.dataArray objectAtIndex:indexPath.row]objectForKey:@"postImage"];

    [file getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        cell.postImage.image = [UIImage imageWithData:data];
        NSLog(@"%@",error);
    }];

    return cell;

//    cell.postImage.image =
}

- (IBAction)onEditButtonPressed:(UIButton *)sender {
}

@end
