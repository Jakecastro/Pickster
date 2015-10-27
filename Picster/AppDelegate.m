//
//  AppDelegate.m
//  Picster
//
//  Created by Jake Castro on 10/22/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "HomeViewController.h"
#import "LogInViewController.h"
#import "ActivityFeedViewController.h"
#import "CameraViewController.h"

@interface AppDelegate ()
@property (strong,nonatomic) UITabBarController *tabBarController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Parse enableLocalDatastore];
    [Parse setApplicationId:@"YDeHOhHiYM3o17VAxIdLyaKlW7wXlWAV3zLIFfMs"
                  clientKey:@"ZKB9A4NlsMyfFAlsILcLC6P7wkL29fX75J70lMJm"];
    
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"homeController"];
//    UIViewController *cameraVC = [storyboard instantiateViewControllerWithIdentifier:@"cameraController"];
//    UIViewController *profileVC = [storyboard instantiateViewControllerWithIdentifier:@"profileController"];
//    UIViewController *activityVC = [storyboard instantiateViewControllerWithIdentifier:@"homeController"];
//    self.tabBarController = [[UITabBarController alloc]init];
//    self.tabBarController.viewControllers = @[homeVC,cameraVC,activityVC,profileVC];
//    PFUser *currentUser = [PFUser currentUser];
//
//    if (currentUser) {
//        UITabBarController *tabBar = (UITabBarController *)self.window.rootViewController;
//        tabBar.selectedIndex = 0;
//    }
//    else {
//        UIViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"loginController"];
//        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//        self.window.rootViewController = loginVC;
//
//    }
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.tabBarController = (UITabBarController *)self.window.rootViewController;
//    [self.window makeKeyAndVisible];
//    [homeVC presentViewController:loginVC animated:YES completion:nil];

    return YES;

    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
