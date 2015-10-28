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
#import "Post.h"
#import "ActivityFeedCommentsTableViewController.h"



@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *feedTableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) PFUser *followedUsers;
@property (strong, nonatomic) PFUser *currentUser;
@property (strong, nonatomic) NSArray *users;
@property Post *post;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getActivityFeed];


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

- (void)getActivityFeed {
//  TODO: fill self.users with posts from the users the current user follows
    PFQuery *query = [PFUser query];
    [query setLimit:150];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.users = objects;
            [self.tableView reloadData];
        }
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.users count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedPhotoCell"];
    self.followedUsers = self.users[indexPath.row];

// TODO: change username to be in the header, set profile pic to be in the header add postimage to the cell image veiw
    cell.textLabel.text = self.followedUsers.username;
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *nvc = segue.destinationViewController;
    ActivityFeedCommentsTableViewController *aVC = nvc.viewControllers[0];
//    aVC.userComments = self.post.commentsArray[indexpath.row];
}

@end










