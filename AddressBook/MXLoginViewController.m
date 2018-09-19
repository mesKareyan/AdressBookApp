//
//  ViewController.m
//  AdressBook
//
//  Created by Mesrop Kareyan on 18/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "MXLoginViewController.h"
#import "MXSession.h"

@interface MXLoginViewController () <MXSessionDelegete>

@property (nonatomic) MXSession *session;

@end


@implementation MXLoginViewController

- (MXSession *)session {
    if (!_session) {
        _session = [MXSession new];
        _session.delegate = self;
    }
    return _session;
}

#pragma mark - Lifecicle

- (void)viewDidLoad {
    [super viewDidLoad];
    MXUser *user = [[MXUser alloc] initWithName:@"test_user" password:@"test_pass"];
    [self.session loginWithUser:user];
}

#pragma mark - Actions
- (void)showEmployeesList {
    
}

#pragma mark - MXSession Delegate

- (void)sessionDidFailedLoginWithError:(NSError *)error {
    [self showAlertWithMessege: error.localizedDescription];
}

- (void)sessionDidLoggedIn {
    [self showAlertWithMessege: @"Logged in"];
   // [self performSegueWithIdentifier:@"employees" sender:nil];
}

- (void)showAlertWithMessege:(NSString *)messege {
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@"Упс!"
                                        message:messege
                                 preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}




@end
