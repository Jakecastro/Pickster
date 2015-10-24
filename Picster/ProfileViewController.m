//
//  ProfileViewController.m
//  Picster
//
//  Created by Jake Castro on 10/23/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextBox;
@property (weak, nonatomic) IBOutlet UITextField *userBioTextBox;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UILabel *numberOfFollowersLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfFollowingLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPosts;
@property (weak, nonatomic) IBOutlet UICollectionView *userImagesCollectionView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}



- (IBAction)onEditButtonPressed:(UIButton *)sender {
}

@end
