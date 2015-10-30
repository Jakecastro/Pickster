//
//  CameraViewController.m
//  Picster
//
//  Created by Jake Castro on 10/23/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "CameraViewController.h"
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface CameraViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property UIImage *daPic;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.postImageView.image = [UIImage imageNamed:@"Phil"];
    self.view.backgroundColor = [UIColor lightGrayColor];

    
// in the IBAction from the post button make sure to clear the imageView.

    if (self.postImageView.image == nil) {
        [self popUpAlertController];
        self.postButton.hidden = true;
    }




}

//- (void)viewWillAppear:(BOOL)animated{
//    [self popUpAlertController];
//}


- (void)popUpAlertController{


    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Pick Picuture for Post"
                                 message:@"Select you Choice"
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

                             [self imagePickerController:picker didFinishPickingMediaWithInfo:NSDictionaryOfVariableBindings(self.postImageView)];
//                             PFObject *pic = [PFObject objectWithClassName:@"Post"];
//                             pic[@"postImage"] = picker;

                             [self presentViewController:picker animated:YES completion:NULL];

                             [view dismissViewControllerAnimated:YES completion:nil];
                             self.postButton.hidden = false;


                             

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

                                 [self imagePickerController:picker didFinishPickingMediaWithInfo:NSDictionaryOfVariableBindings(self.postImageView)];


                                 [self presentViewController:picker animated:YES completion:NULL];

                                 [view dismissViewControllerAnimated:YES completion:nil];

                                 self.postButton.hidden = false;
//                                 PFObject *pic = [PFObject objectWithClassName:@"Post"];
//                                 pic[@"postImage"] = self.postImageView.image;


                             }];


    [view addAction:photoLib];
    [view addAction:takeAPhoto];
    [self presentViewController:view animated:YES completion:nil];





}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    self.daPic = info[UIImagePickerControllerEditedImage];
    self.postImageView.image = self.daPic;

    [picker dismissViewControllerAnimated:YES completion:NULL];

}


//NSData *imageData = UIImagePNGRepresentation(profileImage);
//PFFile *imageFile = [PFFile fileWithName:@"Profileimage.png" data:imageData];
//[imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {

- (IBAction)onPushPostButton:(UIButton *)sender {
//on push should save to parse and clear the image view
    if ([self.postButton.titleLabel.text isEqualToString:@"Post another photo"]) {
        [self popUpAlertController];
        [self.postButton setTitle:@"Post" forState:UIControlStateNormal];
    }
    else {
        NSString *user = [[PFUser currentUser] objectId];
        NSData *imageData = UIImagePNGRepresentation(self.postImageView.image);
        PFFile *imageFile = [PFFile fileWithName:@"currentUsersNameHereAndTime" data:imageData];
        [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Well,fuck Me!");
            }else{
                PFObject *post = [PFObject objectWithClassName:@"Post"];
                [post setObject:imageFile forKey:@"postImage"];
                [post setObject:user forKey:@"senderID"];
                [post setObject:[PFUser currentUser] forKey:@"author"];

                [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (!error) {
                        NSLog(@"Yup");
                        NSLog(@"%@", error);
                        [self.postButton setTitle:@"Post another photo" forState:UIControlStateNormal];
                        [self.postButton sizeToFit];
                    }else{
                        NSLog(@"Well,Fuck");
                    }
                    
                }];
            }
        }];

    }

    self.postImageView.image = nil;



}















@end
