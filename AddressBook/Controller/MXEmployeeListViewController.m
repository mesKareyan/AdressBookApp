//
//  EmployeeListViewController.m
//  AddressBook
//
//  Created by Mesrop Kareyan on 19/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "MXEmployeeListViewController.h"
#import "MXEmployeeCell.h"
#import <RATreeView.h>

@interface MXEmployeeListViewController () <MXSessionDataDelegete, RATreeViewDelegate, RATreeViewDataSource>

@property (weak, nonatomic) RATreeView *treeView;
@property (weak, nonatomic) MXCompany *company;

@end

@implementation MXEmployeeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.session.dataDelegate = self;
    [self.session fetchCompanyData];
    [self setupTreeView];
}

- (void)setupTreeView {
    
    RATreeView *treeView = [[RATreeView alloc] initWithFrame:self.view.bounds];
    
    treeView.delegate = self;
    treeView.dataSource = self;
    treeView.treeFooterView = [UIView new];
    treeView.separatorStyle = RATreeViewCellSeparatorStyleSingleLine;
    
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(refreshControlChanged:) forControlEvents:UIControlEventValueChanged];
    [treeView.scrollView addSubview:refreshControl];
    
    [treeView reloadData];
    [treeView setBackgroundColor:[UIColor colorWithWhite:0.97 alpha:1.0]];
    
    self.treeView = treeView;
    self.treeView.frame = self.view.bounds;
    self.treeView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:treeView atIndex:0];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = NSLocalizedString(@"The company", nil);
    
    [self.treeView registerNib:[UINib nibWithNibName:NSStringFromClass([MXEmployeeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MXEmployeeCell class])];
}

- (IBAction)logoutButtonTapped:(UIBarButtonItem *)sender {
    [self showLogoutAlert];
}

- (void)showLogoutAlert {
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@"Logout?"
                                        message:@"Are you sure"
                                 preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.session logout];
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mak - Data delegate

- (void)sessionDidReciveCompany:(MXCompany *)company {
    NSLog(@"OK");
    self.company = company;
    [self.treeView reloadData];
}

- (void)sessionDidReciveError:(NSError *)error {
    NSLog(@"Error");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    int systemVersion = [[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."][0] intValue];
    if (systemVersion >= 7 && systemVersion < 8) {
        CGRect statusBarViewRect = [[UIApplication sharedApplication] statusBarFrame];
        float heightPadding = statusBarViewRect.size.height+self.navigationController.navigationBar.frame.size.height;
        self.treeView.scrollView.contentInset = UIEdgeInsetsMake(heightPadding, 0.0, 0.0, 0.0);
        self.treeView.scrollView.contentOffset = CGPointMake(0.0, -heightPadding);
    }
    
    self.treeView.frame = self.view.bounds;
}


#pragma mark - Actions

- (void)refreshControlChanged:(UIRefreshControl *)refreshControl
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [refreshControl endRefreshing];
    });
}

- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item {
    
    if (item == nil) {
        item = self.company;
    }
    
    MXEmployeeCell *cell = [self.treeView dequeueReusableCellWithIdentifier:NSStringFromClass([MXEmployeeCell class])];
    
    id<MXEntity> dataObject = item;
    NSInteger level = [self.treeView levelForCellForItem:item];
    BOOL expanded = [self.treeView isCellForItemExpanded:item];
    [cell setupWithEntity:dataObject withLevel:level isExpanded:expanded];
    
    cell.preservesSuperviewLayoutMargins = NO;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item
{
    if (item == nil) {
        return 1;
    }
    id<MXEntity> data = item;
    return [data.children count];
}

- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item
{
    if (item == nil) {
        return self.company;
    }
    id<MXEntity> data = item;
    return data.children[index];
}

- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item {
    return 70;
}

@end