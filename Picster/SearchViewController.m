//
//  SearchViewController.m
//  Picster
//
//  Created by Jake Castro on 10/29/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "SearchViewController.h"
#import "User.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Post.h"

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *searchResultsArray;
@property (strong, nonatomic) PFUser *allUser;
@property (strong, nonatomic) PFUser *followedUsers;
@property NSMutableArray *filteredResultsArray;
@property BOOL isFiltered;
@property (strong,nonatomic) PFUser *user;
@property NSMutableArray *friends;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.friends = [NSMutableArray new];


    [self SearchUsers];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.isFiltered) {
        return self.filteredResultsArray.count;
    }else {

        return self.searchResultsArray.count;
    }


}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"searchCell"];

    if (self.isFiltered) {
        self.allUser = [self.filteredResultsArray objectAtIndex:indexPath.row];
    }
    else {
        self.allUser = [self.searchResultsArray objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = self.allUser.username;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.searchBar resignFirstResponder];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    PFUser *user = [self.searchResultsArray objectAtIndex:indexPath.row];
    PFUser *currentUser = [PFUser currentUser];
    PFRelation *friendsRelation = [currentUser relationForKey:@"friendsRelation"];

    if ([self isFriend:user]) {
        cell.accessoryType = UITableViewCellAccessoryNone;

        for(PFUser *friend in self.friends) {
            if ([friend.objectId isEqualToString:user.objectId]) {
                [self.friends removeObject:friend];
                break;
            }
        }

        [friendsRelation removeObject:user];
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.friends addObject:user];
        [friendsRelation addObject:user];
    }

    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];


}
- (BOOL)isFriend:(PFUser *)user {
    for(PFUser *friend in self.friends) {
        if ([friend.objectId isEqualToString:user.objectId]) {
            return YES;
        }
    }

    return NO;
}

- (void)SearchUsers {
    PFQuery *query = [PFUser query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.searchResultsArray  = objects;
            [self.tableView reloadData];
        }
    }];
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (self.searchBar.text.length == 0) {
        self.isFiltered = NO;
    }
    else {
        self.isFiltered = YES;
        self.filteredResultsArray = [NSMutableArray new];

        for (User *user in self.searchResultsArray) {
            NSRange nameRange = [user.username rangeOfString:self.searchBar.text options:NSCaseInsensitiveSearch];

            if (nameRange.location != NSNotFound) {
                [self.filteredResultsArray addObject:user];
            }


        }

    }
    [self.tableView reloadData];
}















@end
