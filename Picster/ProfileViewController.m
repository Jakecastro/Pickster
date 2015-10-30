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


@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ProfileCollectionViewCellDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextBox;
@property (weak, nonatomic) IBOutlet UITextField *userBioTextBox;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UILabel *numberOfFollowersLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfFollowingLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPosts;
@property (weak, nonatomic) IBOutlet UICollectionView *userImagesCollectionView;



@property (strong,nonatomic) NSMutableArray *dataArray;
@property (strong,nonatomic) User *profileUser;
@property (strong,nonatomic) UIImage *selectedPhoto;

@end

@implementation ProfileViewController{
    BOOL imagePicked;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userBioTextBox.enabled = false;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.dataArray = [NSMutableArray new];
    
    PFUser *user = [PFUser currentUser];
    //self.profileUser = [User currentUser];
    self.usernameTextBox.text = user.username;
    self.userBioTextBox.text = [user objectForKey:@"userBio"];
    self.userImageView.userInteractionEnabled = YES;
    
    
    if (!imagePicked) {
        self.userImageView.image = [UIImage imageNamed:@"Phil"];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickPhoto:)];
    [self.userImageView addGestureRecognizer:tap];
    
    
    
    PFQuery *photosFromCurrentUser = [PFQuery queryWithClassName:@"Post"];
    [photosFromCurrentUser whereKey:@"senderID" equalTo:[[PFUser currentUser] objectId]];
    [photosFromCurrentUser whereKeyExists:@"postImage"];

    [photosFromCurrentUser findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            self.dataArray = [objects mutableCopy];

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.userImagesCollectionView reloadData];
            });

        } else {
            NSLog(@"I AM ERROR");
        }
    }];

    //self.userImageView.image = [UIImage imageNamed:@"Phil"];
}


#pragma mark - Gesture Recognizer / Profile Image

-(void)pickPhoto:(UIGestureRecognizer *)sender{
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Profile Photo"
                                 message:@""
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* takeAPhoto = [UIAlertAction
                                 actionWithTitle:@"Take a photo"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                     UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                     picker.delegate = self;
                                     picker.allowsEditing = YES;
                                     picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                     
                                     [self imagePickerController:picker didFinishPickingMediaWithInfo:NSDictionaryOfVariableBindings(self.userImageView)];
                                     //    PFObject *pic = [PFObject objectWithClassName:@"Post"];
                                     //    pic[@"postImage"] = picker;
                                     
                                     [self presentViewController:picker animated:YES completion:NULL];
                                     
                                     [view dismissViewControllerAnimated:YES completion:nil];
                                     
                                     
                                     
                                     
                                 }];
    UIAlertAction* photoLib = [UIAlertAction
                               actionWithTitle:@"Photo Library"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               
                               {
                                   UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                   picker.delegate = self;
                                   picker.allowsEditing = YES;
                                   picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                   
                                   [self imagePickerController:picker didFinishPickingMediaWithInfo:NSDictionaryOfVariableBindings(self.userImageView)];
                                   
                                   
                                   [self presentViewController:picker animated:YES completion:NULL];
                                   
                                   [view dismissViewControllerAnimated:YES completion:nil];
                                   
                                   //self.postButton.hidden = false;
                                   //                                 PFObject *pic = [PFObject objectWithClassName:@"Post"];
                                   //                                 pic[@"postImage"] = self.postImageView.image;
                                   
                                   
                               }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    
    [view addAction:photoLib];
    [view addAction:takeAPhoto];
    [view addAction:cancelAction];
    [self presentViewController:view animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.selectedPhoto = info[UIImagePickerControllerEditedImage];
    self.userImageView.image = self.selectedPhoto;
    imagePicked = YES;
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)uploadPhoto{
    PFUser *user = [PFUser user];
    
    CGSize newSize = CGSizeMake(320, 480);
    CGRect newRectangle = CGRectMake(0, 0, 320, 480);
    UIGraphicsBeginImageContext(newSize);
    [self.selectedPhoto drawInRect:newRectangle];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(resizedImage);
    PFFile *imageFile = [PFFile fileWithName:@"userImage" data:imageData];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Problem saving image.");
        }else{
            [user setObject:imageFile forKey:@"profileImage"];
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (error) {
                    NSLog(@"%@",error);
                }
            }];
        }
    }];
}

#pragma mark - CollectionView Data Source

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProfileCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"userPhotoCell" forIndexPath:indexPath];
    cell.delegate = self;

    PFFile *file = [[self.dataArray objectAtIndex:indexPath.row]objectForKey:@"postImage"];

    [file getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        cell.postImage.image = [UIImage imageWithData:data];
        //NSLog(@"%@",error);
    }];

    return cell;

}


#pragma mark - Edit Bio

- (IBAction)onEditButtonPressed:(UIButton *)sender {

    
    if ([self.editButton.titleLabel.text isEqualToString:@"Save"]) {
        self.userBioTextBox.enabled = false;
        [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
    }
    else if ([self.editButton.titleLabel.text isEqualToString:@"Edit"]) {
        if ([self.userBioTextBox hasText]) {
            self.userBioTextBox.enabled = true;
            PFUser *user = [PFUser currentUser];
            [user setObject:self.userBioTextBox.text forKey:@"userBio"];
            [user saveInBackground];
            [self.editButton setTitle:@"Save" forState:UIControlStateNormal];
            
        }
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ShowComments" sender:self];
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    return NO;
}

#pragma mark - Segue 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UICollectionViewCell *)sender {
//    UINavigationController *navController = segue.destinationViewController;
//    UserCommentsTableViewController *commentsVC = navController.viewControllers[0];
//    UICollectionViewCell *cell = (UICollectionViewCell *)sender;
//    NSIndexPath *indexPath = [self.userImagesCollectionView indexPathForCell:sender];

//    Post *post = [self.dataArray objectAtIndex:indexPath.row];
//    ucVC.postForComment = post;

}


- (IBAction)didLongPressCellToDelete:(UILongPressGestureRecognizer*)gesture {
    CGPoint tapLocation = [gesture locationInView:self.userImagesCollectionView];
    NSIndexPath *indexPath = [self.userImagesCollectionView indexPathForItemAtPoint:tapLocation];
    if (indexPath && gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"image with index %ld to be deleted", (long)indexPath.item);
        NSInteger itemIndexToDelete = indexPath.item;
        [self.dataArray removeObjectAtIndex:itemIndexToDelete];
        [self.userImagesCollectionView reloadData];

//        UIAlertView *deleteAlert = [[UIAlertView alloc]
//                                    initWithTitle:@"Delete?"
//                                    message:@"Are you sure you want to delete this post?"
//                                    delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
//        [deleteAlert show];

    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"selected button index = %d", buttonIndex);
    if (buttonIndex == 1) {
        // Do what you need to do to delete the cell
        [self.userImagesCollectionView reloadData];
    }
}


- (void)profileCollectionViewCell:(id)cell didLongPressCell:(UILongPressGestureRecognizer *)sender {
    CGPoint tapLocation = [sender locationInView:self.userImagesCollectionView];
    NSIndexPath *indexPath = [self.userImagesCollectionView indexPathForItemAtPoint:tapLocation];
    if (indexPath && sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"image with index %ld to be deleted", (long)indexPath.item);
        NSInteger itemIndexToDelete = indexPath.item;
        [self.dataArray removeObjectAtIndex:itemIndexToDelete];
        [self.userImagesCollectionView reloadData];

        //        UIAlertView *deleteAlert = [[UIAlertView alloc]
        //                                    initWithTitle:@"Delete?"
        //                                    message:@"Are you sure you want to delete this post?"
        //                                    delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        //        [deleteAlert show];
        
    }


}







@end
