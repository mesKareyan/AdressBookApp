//
//  MXProfileViewControllerTableViewController.h
//  AddressBook
//
//  Created by Mesrop Kareyan on 22/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXEmployee.h"
#import "MXSession.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXProfileViewController : UITableViewController

@property (nonatomic, readonly) MXEmployee *employee;
@property (nonatomic, readonly) MXSession *session;

- (void)setupForEmployee:(MXEmployee *)employee withSession:(MXSession *)session;

@end

NS_ASSUME_NONNULL_END
