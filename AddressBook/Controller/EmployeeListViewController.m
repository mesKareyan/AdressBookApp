//
//  EmployeeListViewController.m
//  AddressBook
//
//  Created by Mesrop Kareyan on 19/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "EmployeeListViewController.h"

@interface EmployeeListViewController ()

@end

@implementation EmployeeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)logoutButtonTapped:(UIBarButtonItem *)sender {
    [self.session logout];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
