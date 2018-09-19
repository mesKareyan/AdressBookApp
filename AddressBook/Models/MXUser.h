//
//  User.h
//  AdressBook
//
//  Created by Mesrop Kareyan on 19/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXUser : NSObject

- (instancetype)initWithName:(NSString *)name password:(NSString *)password;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *password;

@end

NS_ASSUME_NONNULL_END
