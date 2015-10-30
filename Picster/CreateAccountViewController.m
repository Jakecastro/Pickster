//
//  CreateAccountViewController.m
//  Picster
//
//  Created by Jake Castro on 10/26/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "CreateAccountViewController.h"
#import <Parse/Parse.h>
#import "User.h"

@interface CreateAccountViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailAddressTextField;
@property (weak, nonatomic) IBOutlet UIButton *createAndLoginButton;

@end

@implementation CreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)onCreateAndLoginButtonPressed:(UIButton *)sender {
    User *user = [PFUser user];
    
    if (![self.passwordTextField.text isEqualToString:self.verifyPasswordTextField.text]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:@"Passwords not matching!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *tryAgain = [UIAlertAction actionWithTitle:@"Try Again"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                         }];
        [alert addAction:tryAgain];
        [self presentViewController:alert
                           animated:YES
                         completion:nil];
        return;
    }else{
        user.username = self.usernameTextField.text;
        user.password = self.passwordTextField.text;
        user.email = self.emailAddressTextField.text;
    }
    
    if ([self.usernameTextField hasText] && [self.passwordTextField hasText] && [self.emailAddressTextField hasText] && [self.verifyPasswordTextField hasText]) {
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                //NSLog(@"Success");
            } else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                               message:@"There was a problem. Please try again later!"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *tryAgain = [UIAlertAction actionWithTitle:@"OK"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction *action) {
                                                                 }];
                [alert addAction:tryAgain];
                [self presentViewController:alert
                                   animated:YES
                                 completion:nil];
            }
        }];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:@"Information is not Correct!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *tryAgain = [UIAlertAction actionWithTitle:@"Try Again!"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                         }];
        [alert addAction:tryAgain];
        [self presentViewController:alert
                           animated:YES
                         completion:nil];
    }

}


@end
