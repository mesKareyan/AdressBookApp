//
//  MXEntity.m
//  AddressBook
//
//  Created by Mesrop Kareyan on 20/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "MXEntity.h"

@implementation MXEntity

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if(self.class == MXEntity.class) {
        NSException *exception =
        [NSException exceptionWithName:@"MXentity is abstract class"
                                reason:@"You cannot init this class directly. Instead, use a subclass"
                              userInfo:@{@"": @""}];
        [exception raise];
        return nil;
    } else {
        self = [super init];
    }
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"Undefind >> %@", key);
}

@end
