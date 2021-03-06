//
//  MXProfileViewController.m
//  AddressBook
//
//  Created by Mesrop Kareyan on 22/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "MXProfileViewController.h"
#import "MXRoundedButton.h"
#import <MessageUI/MessageUI.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface MXProfileViewController () <MFMailComposeViewControllerDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profilePlaceholderImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet MXRoundedButton *emailButton;
@property (weak, nonatomic) IBOutlet MXRoundedButton *phoneButton;
@property (weak, nonatomic) IBOutlet UITextView *detailsTextView;
@property (nonatomic) UIImageView *profileImageView;

@property (nonatomic) CGFloat imageViewHeight;
@property (nonatomic, getter=isFullscreenProfileImage) BOOL fullscreenProfileImage;

@property (nonatomic, readwrite) MXEmployee *employee;
@property (nonatomic, readwrite) MXSession *session;

@end

@implementation MXProfileViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - Initialization

- (void)setupForEmployee:(MXEmployee *)employee
             withSession:(MXSession *)session {
    self.employee = employee;
    self.session = session;
}

- (void)setupUI {
    self.imageViewHeight = self.profilePlaceholderImageView.frame.size.height;
    self.fullscreenProfileImage = NO;
    // Creating view for extending background color
    CGRect frame = self.tableView.tableHeaderView.bounds;
    self.profileImageView = [[UIImageView alloc] initWithFrame:frame];
    self.profileImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileImageTapped:)];
    [self.profileImageView addGestureRecognizer: tap];
    // Adding the view below the refresh control
    [self.tableView insertSubview:self.profileImageView atIndex:3];
   
    self.nameLabel.text = self.employee.Name;
    self.phoneNumberLabel.text = self.employee.Phone;
    self.detailsTextView.text = self.employee.Title;
    NSURL *url = [self.session photoURLForEmployee:self.employee];
    [self.profileImageView sd_setImageWithURL:url];
    
    if (!self.employee.Phone || [self.employee.Phone isEqualToString:@""]) {
        self.phoneButton.enabled = NO;
    }
    ((UIScrollView *)self.tableView).delegate = self;
}

#pragma mark - Actions

- (IBAction)emailButtonTapped:(UIButton *)sender {
    [self sendEmail];
}

- (IBAction)phoneButtonTapped:(UIButton *)sender {
    [self makeCall];
}
     
- (void)profileImageTapped:(UITapGestureRecognizer*)tap {
    [self showProfileImageFullscreen: !self.isFullscreenProfileImage];
}

- (void)sendEmail {
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;
        [mailCont setSubject:@"The Copmany"];
        if (self.employee.Email) {
            [mailCont setToRecipients: @[self.employee.Email]];
        }
        [self presentViewController:mailCont animated:YES completion:nil];
    }
}

- (void)makeCall {
    NSURL *url = [NSURL URLWithString: [@"tel://" stringByAppendingString:self.employee.Phone]];
    UIApplication *application = [UIApplication sharedApplication];
    if ([application canOpenURL:url]) {
        [application openURL:url options:@{} completionHandler:nil];
    }
}

#pragma mark - Animations

- (void)showProfileImageFullscreen:(BOOL)isFullscreen {
    [self.navigationController setNavigationBarHidden:isFullscreen animated:YES];
    [UIView animateWithDuration:0.4 animations:^{
        if (self.isFullscreenProfileImage) {
            self.profileImageView.frame = self.profilePlaceholderImageView.frame;
        } else {
            self.profileImageView.frame = self.view.frame;
        }}];
    self.fullscreenProfileImage = isFullscreen;
    self.tableView.scrollEnabled = !isFullscreen;
}

#pragma mark - Email delegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultSent:
            //Email sent
            break;
        case MFMailComposeResultSaved:
            //Email saved
            break;
        case MFMailComposeResultCancelled:
            //Handle cancelling of the email
            break;
        case MFMailComposeResultFailed:
            //Handle failure to send.
            break;
        default:
            //A failure occurred while completing the email
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma  mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView != self.tableView) {
        return;
    }
    CGRect newFrame = self.profileImageView.frame;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat newHeight = self.imageViewHeight - offset;;
    newFrame.origin.y = offset;
    newFrame.size.height = newHeight;
    self.profileImageView.frame = newFrame;
}

@end
