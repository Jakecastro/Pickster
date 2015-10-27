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


@interface CameraViewController ()<UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UIButton *postButton;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.postImageView.image = [UIImage imageNamed:@"Phil"];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self popUpAlertController];



}

- (void)viewWillAppear:(BOOL)animated{
    [self popUpAlertController];
}


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
                                 
                                 [self presentViewController:picker animated:YES completion:NULL];

                                 [view dismissViewControllerAnimated:YES completion:nil];
                             }];


    [view addAction:photoLib];
    [view addAction:takeAPhoto];
    [self presentViewController:view animated:YES completion:nil];





}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.postImageView.image = chosenImage;

    [picker dismissViewControllerAnimated:YES completion:NULL];

}



























@end
