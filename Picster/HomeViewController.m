//
//  HomeViewController.m
//  Picster
//
//  Created by Jake Castro on 10/23/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "HomeViewController.h"
#import "LogInViewController.h"
#import <Parse/Parse.h>


@interface HomeViewController () <UITableViewDataSource, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *feedTableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) PFUser *currentUser;
@property (strong,nonatomic) NSArray *users;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentUser = [PFUser currentUser];
//    NSLog(@"User: %@",self.currentUser);
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    PFUser *currentUser = [PFUser currentUser];
//    [PFUser logOut];
    
    if (!currentUser) {
        LogInViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"loginController"];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.users count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedPhotoCell"];
    cell.textLabel.text = [self.users objectAtIndex:indexPath.row];
    
    return cell;
}

@end
