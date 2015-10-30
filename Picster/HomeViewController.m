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
#import "HomeTableViewCell.h"



@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) PFUser *followedUsers;
@property (strong, nonatomic) PFUser *currentUser;
@property (strong, nonatomic) NSArray *users;
@property (strong,nonatomic) NSArray *postArray;
@property (strong,nonatomic) NSArray *usersArray;
@property Post *post;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getActivityFeed];
    self.title = @"PicStarter";
    [self.tableView reloadData];

    self.currentUser = [PFUser currentUser];
//    NSLog(@"User: %@",self.currentUser);
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    PFUser *currentUser = [PFUser currentUser];
    //[PFUser logOut];
    
    if (!currentUser) {
        LogInViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"loginController"];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.postArray = [NSArray new];
    
//    PFQuery *allUsers = [PFUser query];
//    [allUsers findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//        self.users = objects;
//        //NSLog(@"%lu",[objects count]);
//    }];
    
    PFQuery *postQuery = [PFQuery queryWithClassName:@"Post"];
    //[postQuery whereKey:@"senderID" equalTo:[[PFUser currentUser] objectId]];
    [postQuery whereKeyExists:@"postImage"];
    
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            self.postArray = objects;
            NSLog(@"Post %lu",[objects count]);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
        } else {
            NSLog(@"I AM ERROR");
        }
    }];
    
}

- (void)getActivityFeed {
//  TODO: fill self.users with posts from the users the current user follows
//    PFQuery *query = [PFUser query];
//    [query setLimit:150];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            self.users = objects;
//            [self.tableView reloadData];
//        }
//    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.postArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedPhotoCell"];
    self.followedUsers = self.users[indexPath.row];

// TODO: change username to be in the header, set profile pic to be in the header add postimage to the cell image veiw
    
    PFFile *file = [[self.postArray objectAtIndex:indexPath.row]objectForKey:@"postImage"];
        
    [file getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        cell.feedView.image = [UIImage imageWithData:data];
        NSLog(@"%@",error);
        cell.usernameLabel.text = self.followedUsers.username;
    }];

    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    UINavigationController *nvc = segue.destinationViewController;
//    ActivityFeedCommentsTableViewController *aVC = nvc.viewControllers[0];
//    aVC.userComments = self.post.commentsArray[indexpath.row];
}

@end










