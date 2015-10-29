//
//  LogInViewController.m
//  Picster
//
//  Created by Jake Castro on 10/26/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "LogInViewController.h"
#import <Parse/Parse.h>
#import "HomeViewController.h"
#import "User.h"

@interface LogInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *createAccountButton;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.loginButton addTarget:self action:@selector(loginUser) forControlEvents:UIControlEventTouchUpInside];


}

-(void)loginUser {
    if ([self.usernameTextField hasText] && [self.passwordTextField hasText]) {

        
        [User logInWithUsernameInBackground:self.usernameTextField.text password:self.passwordTextField.text block:^(PFUser * _Nullable user, NSError * _Nullable error) {
            if (error) {
                NSLog(@"login failed");
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oooops"
                                                                               message:@"username and/or password is incorrect"
                                                                        preferredStyle:UIAlertControllerStyleAlert];

                UIAlertAction *tryAgain = [UIAlertAction actionWithTitle:@"Try Again"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action) {
                                                             }];
                [alert addAction:tryAgain];
                [self presentViewController:alert
                                   animated:YES
                                 completion:nil];
            }
            else {
                //NSLog(@"success");
                [self dismissViewControllerAnimated:YES completion:nil];

            }
        }];

    } else{

        NSLog(@"Type Something");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Ooops"
                                                                       message:@"you must enter a username and a password before pressing login"
                                                                preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *tryAgain = [UIAlertAction actionWithTitle:@"Try Again"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                         }];
        [alert addAction:tryAgain];
        [self presentViewController:alert
                           animated:YES
                         completion:nil];
    }



}

- (IBAction)onCreateAccountButtonPressed:(UIButton *)sender {

}



@end
