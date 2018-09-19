//
//  User.m
//  AdressBook
//
//  Created by Mesrop Kareyan on 19/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "MXUser.h"

@implementation MXUser

- (instancetype)initWithName:(NSString *)name password:(NSString *)password {
    self = [super init];
    if (self) {
        _name = [name copy];
        _password = [password copy];
    }
    return self;
}


@end
