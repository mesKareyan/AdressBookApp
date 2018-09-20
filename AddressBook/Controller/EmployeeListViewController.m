//
//  EmployeeListViewController.m
//  AddressBook
//
//  Created by Mesrop Kareyan on 19/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "EmployeeListViewController.h"

@interface EmployeeListViewController () <MXSessionDataDelegete>

@end

@implementation EmployeeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.session.dataDelegate = self;
    [self.session fetchCompanyData];
}

- (IBAction)logoutButtonTapped:(UIBarButtonItem *)sender {
    [self.session logout];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mak - Data delegate

- (void)sessionDidReciveCompany:(MXCompany *)company {
    NSLog(@"OK");
}

- (void)sessionDidReciveError:(NSError *)error {
    NSLog(@"Error");
}



@end
