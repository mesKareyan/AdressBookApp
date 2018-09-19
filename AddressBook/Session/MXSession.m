//
//  MXSession.m
//  AdressBook
//
//  Created by Mesrop Kareyan on 18/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "MXSession.h"
#import <UICKeyChainStore/UICKeyChainStore.h>

@interface MXSession()

@property (nonatomic, readwrite) MXUser *user;

@end

@implementation MXSession

- (instancetype)init
{
    self = [super init];
    if (self) {
        _network = [MXNetwork new];
    }
    return self;
}

- (MXUser *)savedUser {
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"com.mesropK.AdressBook"];
    NSString *keychainUser = keychain[@"user"];
    NSString *keychainPass = keychain[@"password"];
    if (keychainUser && keychainPass) {
        return [[MXUser alloc] initWithName:keychainUser password:keychainPass];
    }
    return nil;
}

- (void)loginWithUser:(MXUser *)user {
    [self loginWithUser:user.name password:user.password];
}

- (void)loginWithUser:(NSString *)user password:(NSString *)password {
    [self.network loginWithUser:user password:password completion:^(NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate sessionDidFailedLoginWithError:error];
            });
        } else {
            UICKeyChainStore *keychain = [UICKeyChainStore
                                          keyChainStoreWithService:@"com.mesropK.AdressBook"];
            keychain.synchronizable = YES;
            keychain[@"password"] = password;
            keychain[@"user"] = user;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.user = [[MXUser alloc] initWithName:user password:password];
                [self.delegate sessionDidLoggedIn];
            });
        }
    }];
}

- (void)logout{
    UICKeyChainStore *keychain = [UICKeyChainStore
                                  keyChainStoreWithService:@"com.mesropK.AdressBook"];
    keychain[@"password"] = nil;
    keychain[@"user"] = nil;
    [self.delegate sessionDidLogout];
}

@end
