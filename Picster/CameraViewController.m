//
//  CameraViewController.m
//  Picster
//
//  Created by Jake Castro on 10/23/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "CameraViewController.h"
#import <UIKit/UIKit.h>

@interface CameraViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UIButton *postButton;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.postImageView.image = [UIImage imageNamed:@"Phil"];
    self.view.backgroundColor = [UIColor colorWithHue:0.0 saturation:0.0 brightness:1.0 alpha:0.5];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
