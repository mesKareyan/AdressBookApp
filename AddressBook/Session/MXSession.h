//
//  MXSession.h
//  AdressBook
//
//  Created by Mesrop Kareyan on 18/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXNetwork.h"
#import "MXUser.h"
#import "MXCompany.h"
#import "MXEmployee.h"

@protocol MXSessionDelegete <NSObject>

- (void)sessionDidLoggedIn;
- (void)sessionDidFailedLoginWithError:(NSError *)error;
- (void)sessionDidLogout;

@end

@protocol MXSessionDataDelegete <NSObject>

- (void)sessionDidReciveCompany:(MXCompany *)company;
- (void)sessionDidReciveError:(NSError *)error;

@end

NS_ASSUME_NONNULL_BEGIN

@interface MXSession : NSObject

@property (nonatomic, readonly, nonnull) MXNetwork *network;
@property (nonatomic, weak) id<MXSessionDelegete> delegate;
@property (nonatomic, weak) id<MXSessionDataDelegete> dataDelegate;
@property (nonatomic, readonly) MXUser *user;

- (MXUser *)savedUser;
- (void)loginWithUser:(MXUser *)user;
- (void)logout;
- (void)fetchCompanyData;
- (NSURL *)photoURLForEmployee:(MXEmployee *)employee;

@end

NS_ASSUME_NONNULL_END
