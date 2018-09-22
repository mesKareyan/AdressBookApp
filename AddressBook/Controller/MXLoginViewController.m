//
//  ViewController.m
//  AdressBook
//
//  Created by Mesrop Kareyan on 18/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "MXLoginViewController.h"
#import "MXSession.h"
#import "MXEmployeeListViewController.h"

@interface MXLoginViewController () <MXSessionDelegete>

@property (nonatomic) MXSession *session;
@property (weak, nonatomic) IBOutlet UIStackView *itemsStackView;
@property (weak, nonatomic) IBOutlet UIView *bottomContainerVIew;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewTopConstraint;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation MXLoginViewController

- (MXSession *)session {
    if (!_session) {
        _session = [MXSession new];
        _session.delegate = self;
    }
    return _session;
}

- (void)setupController {
    self.loginButton.enabled = NO;
    self.loginTextField.delegate = (id<UITextFieldDelegate>)self;
    self.passwordTextField.delegate =  (id<UITextFieldDelegate>)self;
    [self.view addGestureRecognizer: [[UITapGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(dismissKeyboard)]];
    MXUser *user = [[MXUser alloc] initWithName:@"test_user" password:@"test_pass"];
    MXUser *savedUser = [self.session savedUser];
    if (savedUser) {
        self.itemsStackView.hidden = YES;
        [self.session loginWithUser:user];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self animteItems];
        });
    }
}

#pragma mark - Lifecicle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showEmployees"] &&
        [segue.destinationViewController isKindOfClass:UINavigationController.class]) {
        UINavigationController *navCtrl = segue.destinationViewController;
        if ([navCtrl.topViewController isKindOfClass:MXEmployeeListViewController.class]) {
            MXEmployeeListViewController *list =
            (MXEmployeeListViewController *)[navCtrl topViewController];
            list.session = self.session;
        }
    }
}


#pragma mark - Actions

- (void)showEmployeesList {
    
}

- (IBAction)loginButtonTapped:(MXRoundedButton *)sender {
    MXUser *newUser = [[MXUser alloc] initWithName:self.loginTextField.text password:self.passwordTextField.text];
    [self.session loginWithUser:newUser];
    [self animteItems];
    [self.view endEditing:YES];
}


-(void)dismissKeyboard {
    [self.view endEditing:YES];
}


#pragma mark - MXSession Delegate

- (void)sessionDidFailedLoginWithError:(NSError *)error {
    [self showAlertWithMessege: error.localizedDescription];
    self.itemsStackView.hidden = NO;
}

- (void)sessionDidLoggedIn {
    [self performSegueWithIdentifier:@"showEmployees" sender:nil];
}

- (void)sessionDidLogout {
    self.itemsStackView.hidden = NO;
}

- (void)showAlertWithMessege:(NSString *)messege {
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@"Упс!"
                                        message:messege
                                 preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - keyboard

- (void)subscribeKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)unsubscribeKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y  = -(keyboardSize.height - 60);
            self.view.frame = frame;
        }];
}

-(void)keyboardWillHide:(NSNotification *)notification {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
}

- (void)animteItems {
    
    CGRect  frame = self.bottomContainerVIew.frame;
    CGFloat nameDeltaY  = frame.size.height + 44;
    CGFloat passDeltaY  = nameDeltaY - 44 - 16;
    CGFloat loginDeltaY = passDeltaY - 44 - 16;
    
    self.loginTextField.transform = CGAffineTransformMakeTranslation(0, nameDeltaY);
    self.passwordTextField.transform = CGAffineTransformMakeTranslation(0, passDeltaY);
    self.loginButton.transform = CGAffineTransformMakeTranslation(0, loginDeltaY);
    self.loginButton.alpha = 0.0;
    
    [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping:1 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.loginTextField.transform = CGAffineTransformIdentity;
    } completion:nil];

    [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping:1 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.passwordTextField.transform = CGAffineTransformIdentity;
    } completion:nil];

    [UIView animateWithDuration:1 delay:0.1 usingSpringWithDamping:1 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.loginButton.transform = CGAffineTransformIdentity;
    } completion:nil];
    
    [UIView animateWithDuration: 1.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.loginButton.alpha = 1.0;
    } completion:nil];
    

}
@end
