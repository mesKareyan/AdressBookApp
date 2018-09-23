//
//  EmployeeListViewController.m
//  AddressBook
//
//  Created by Mesrop Kareyan on 19/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "MXEmployeeListViewController.h"
#import <RATreeView.h>
#import "MXEmployeeCell.h"
#import "MXEmployee.h"
#import "MXProfileViewController.h"

@interface MXEmployeeListViewController () <MXSessionDataDelegete, RATreeViewDelegate, RATreeViewDataSource>

@property (weak, nonatomic) RATreeView *treeView;
@property (weak, nonatomic) MXCompany *company;
@property (nonatomic) MXEmployee *selectedEmployee;

@end

@implementation MXEmployeeListViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupController];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.treeView.frame = self.view.bounds;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showProfile"]) {
        MXProfileViewController *profileController = (MXProfileViewController *)segue.destinationViewController;
        [profileController setupForEmployee:self.selectedEmployee
                                withSession:self.session];
    }
}

#pragma mark - Initialization

- (void)setupController {
    self.session.dataDelegate = self;
    [self.session fetchCompanyData];
    [self setupTreeView];
    [self animateNavBar];
}

- (void)setupTreeView {
    
    UIColor *backColor = [UIColor colorNamed:@"mxLightGreen"];
    RATreeView *treeView = [[RATreeView alloc] initWithFrame:self.view.bounds];
    treeView.delegate = self;
    treeView.dataSource = self;
    treeView.treeFooterView = [UIView new];
    treeView.separatorStyle = RATreeViewCellSeparatorStyleSingleLine;
    
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(refreshControlChanged:) forControlEvents:UIControlEventValueChanged];
    refreshControl.tintColor = UIColor.whiteColor;
    [treeView.scrollView addSubview:refreshControl];
    refreshControl.backgroundColor = backColor;

    [treeView reloadData];
    [treeView setBackgroundColor:[UIColor colorWithWhite:0.97 alpha:1.0]];
    
    self.treeView = treeView;
    self.treeView.frame = self.view.bounds;
    self.treeView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:treeView atIndex:0];
    
    // Creating view for extending background color
    CGRect frame = self.treeView.bounds;
    frame.origin.y = -frame.size.height;
    UIView* bgView = [[UIView alloc] initWithFrame:frame];
    bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    // Adding the view below the refresh control
    [treeView.scrollView insertSubview:bgView atIndex:0];
    bgView.backgroundColor = backColor;

    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = NSLocalizedString(@"The Company", nil);
    [self.treeView registerNib:[UINib nibWithNibName:NSStringFromClass([MXEmployeeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MXEmployeeCell class])];
}

#pragma mark - Actions

- (IBAction)logoutButtonTapped:(UIBarButtonItem *)sender {
    [self showLogoutAlert];
}

- (void)refreshControlChanged:(UIRefreshControl *)refreshControl {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [refreshControl endRefreshing];
    });
}

- (void)showLogoutAlert {
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Logout?", "")
                                        message:NSLocalizedString(@"Are you sure?", "")
                                 preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Logout", "")
                                              style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.session logout];
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", "") style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Session Delegate

- (void)sessionDidReciveCompany:(MXCompany *)company {
    self.company = company;
    [self.treeView reloadData];
}

- (void)sessionDidReciveError:(NSError *)error {
    NSLog(@"%@", error.localizedDescription);
}

#pragma mark - TreeView delegate

- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item {
    if (item == nil) {
        return 1;
    }
    id<MXEntity> entity = item;
    return entity.children.count;
}

- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item {
    
    if (item == nil) {
        item = self.company;
    }
    
    MXEmployeeCell *cell = [self.treeView dequeueReusableCellWithIdentifier:NSStringFromClass([MXEmployeeCell class])];
    
    id<MXEntity> entity = item;
    NSInteger level = [self.treeView levelForCellForItem:item];
    BOOL expanded = [self.treeView isCellForItemExpanded:item];
    [cell setupWithEntity:entity withLevel:level isExpanded:expanded];
    
    return cell;
    
}

- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item {
    if (item == nil) {
        return self.company;
    }
    id<MXEntity> data = item;
    return data.children[index];
}

-(void)treeView:(RATreeView *)treeView didSelectRowForItem:(id)item {
    if ([item isKindOfClass:MXEmployee.class]) {
        self.selectedEmployee = item;
        [self performSegueWithIdentifier:@"showProfile" sender:nil];
    }
}

- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item {
    return 70;
}

- (BOOL)treeView:(RATreeView *)treeView canEditRowForItem:(id)item {
    return NO;
}

#pragma mark - Animations

- (void)animateNavBar {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    CGFloat height = self.navigationController.navigationBar.bounds.size.height;
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -height);
    self.view.transform = transform;
    [UIView animateWithDuration:0.3 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
}

@end
