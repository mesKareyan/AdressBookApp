//
//  MXSession.m
//  AdressBook
//
//  Created by Mesrop Kareyan on 18/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "MXSession.h"

@implementation MXSession

- (instancetype)init
{
    self = [super init];
    if (self) {
        _network = [MXNetwork new];
    }
    return self;
}

- (void)loginWithUser:(NSString *)user password:(NSString *)password {
    [self.network loginWithUser:user password:password completion:^(NSError *error) {
        if (error) {
            [self.delegate sessionDidLoggedIn];
        } else {
            [self.delegate sessionDidFailedLoginWithError:error];
        }
    }];
}

- (void)logout{
    
}

@end
