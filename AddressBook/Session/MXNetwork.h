//
//  MXNetwork.h
//  AdressBook
//
//  Created by Mesrop Kareyan on 18/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import <Foundation/Foundation.h>

//Completion hendlers
typedef void(^MXLoginRequestCompletion)(NSError *error);
typedef void(^MXAllDataRequestCompletion)(NSDictionary *data, NSError *error);
typedef void(^MXEmployeeDataRequestCompletion)(NSDictionary *data, NSError *error);

NS_ASSUME_NONNULL_BEGIN

@interface MXNetwork : NSObject

- (void)signInWithLogin:(NSString *)userName
               password:(NSString *)password
             completion:(MXLoginRequestCompletion)completion;

- (void)allDataLogin:(NSString *)userName
            password:(NSString *)password
          completion:(MXAllDataRequestCompletion)completion;

- (void)employeeDataWithID:(NSString *)employeeID
                     login:(NSString *)userName
                  password:(NSString *)password
                completion:(MXEmployeeDataRequestCompletion)completion;

- (NSURL *)photoURLWithEmployeeID:(NSString *)userID
                            login:(NSString *)userName
                         password:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
