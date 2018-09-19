//
//  MXSplashViewController.m
//  AddressBook
//
//  Created by Mesrop Kareyan on 19/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "MXSplashViewController.h"

@interface MXSplashViewController ()
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (nonatomic) IBOutlet NSLayoutConstraint *centerConstraint;
@property (nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end

@implementation MXSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.centerConstraint.active = YES;
    self.topConstraint.active = NO;
    [self  start];
}

- (void)start {
    self.centerConstraint.active = NO;
    self.topConstraint.active = YES;
    self.welcomeLabel.alpha = 0.5;
    [UIView animateWithDuration:0.7 animations:^{
        self.welcomeLabel.alpha = 1.0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self performSegueWithIdentifier:@"start" sender:nil];
    }];
}

@end
