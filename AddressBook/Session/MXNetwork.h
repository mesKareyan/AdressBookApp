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

NS_ASSUME_NONNULL_BEGIN

@interface MXNetwork : NSObject

- (void)loginWithUser:(NSString *)userName
             password:(NSString *)password
           completion:(MXLoginRequestCompletion)completion;

- (void)allDataWithUser:(NSString *)userName
               password:(NSString *)password
             completion:(MXAllDataRequestCompletion)completion;

- (NSURL *)photoURLWithID:(NSString *)userID
                 userName:(NSString *)userName
                 password:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
