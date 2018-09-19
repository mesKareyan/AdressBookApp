//
//  MXSession.m
//  AdressBook
//
//  Created by Mesrop Kareyan on 18/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "MXSession.h"
#import <UICKeyChainStore/UICKeyChainStore.h>

@implementation MXSession

- (instancetype)init
{
    self = [super init];
    if (self) {
        _network = [MXNetwork new];
    }
    return self;
}

- (void)loginWithUser:(MXUser *)user {
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"com.mesropK.AdressBook"];
    NSString *keychainUser = keychain[@"user"];
    if (!keychainUser) {
        [self loginWithUser:user.name password:user.password];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate sessionDidLoggedIn];
        });
    }
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
    [self.delegate sessionDIDLogout];
}

@end
