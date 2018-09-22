//
//  MXNetwork.m
//  AdressBook
//
//  Created by Mesrop Kareyan on 18/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "MXNetwork.h"
#import "Errors.h"

//Endpoints
NSString *const baseApi = @"https://contact.taxsee.com/Contacts.svc/";
NSString *const loginEndpoint = @"Hello";
NSString *const allDataEndpoint = @"GetAll";
NSString *const userPhotoEndpoint = @"getWPhoto";

@interface MXNetwork() {
}

@property (nonatomic, nonnull) NSURLSession *session;
@property (nonatomic, nonnull, readonly) NSError *loginError;
@property (nonatomic, nonnull, readonly) NSError *profileFetchError;


@end


@implementation MXNetwork

- (instancetype)init
{
    self = [super init];
    if (self) {
        _session = [NSURLSession sharedSession];
        _loginError = [[NSError alloc] initWithDomain:MXErrorDomain
                                                 code:MXErrorNotLoggedIn
                                             userInfo: @{NSLocalizedDescriptionKey : kMXErrorNotLoggedInMessege}];
        _profileFetchError = [[NSError alloc] initWithDomain:MXErrorDomain
                                                        code:MXErrorNotLoggedIn
                                                    userInfo: @{NSLocalizedDescriptionKey : kMXErrorWrongDataMessege}];
    }
    return self;
}

- (void)signInWithLogin:(NSString *)userName
               password:(NSString *)password
             completion:(MXLoginRequestCompletion)completion {
    
    NSURLComponents *components = [NSURLComponents componentsWithString:
                                   [baseApi stringByAppendingString: loginEndpoint]];
    NSURLQueryItem *user = [NSURLQueryItem queryItemWithName:@"login" value:userName];
    NSURLQueryItem *pass = [NSURLQueryItem queryItemWithName:@"password" value:password];
    components.queryItems = @[user, pass];
    
    [[self.session dataTaskWithURL: components.URL
                 completionHandler:^(NSData * _Nullable data,
                                     NSURLResponse * _Nullable response,
                                     NSError * _Nullable error) {
                     NSError *jsonError;
                     id result = [NSJSONSerialization JSONObjectWithData:data
                                                                 options: kNilOptions
                                                                   error:&jsonError];
                     if (jsonError) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             completion(self.loginError);
                         });
                         return;
                     }
                     if(![result isKindOfClass: NSDictionary.class]) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             completion(self.loginError);
                         });
                         return;
                     }
                     NSDictionary *resultDict = (NSDictionary *)result;
                     if([resultDict[@"Success"] boolValue]) {
                         completion(nil);
                     } else {
                         completion([self loginErrorWithMessesge: resultDict[@"Message"]]);
                         return;
                     }
                 }] resume];
}

- (void)allDataLogin:(NSString *)userName
            password:(NSString *)password
          completion:(MXAllDataRequestCompletion)completion {
    
    NSURLComponents *components = [NSURLComponents componentsWithString:
                                   [baseApi stringByAppendingString: allDataEndpoint]];
    NSURLQueryItem *user = [NSURLQueryItem queryItemWithName:@"login" value:userName];
    NSURLQueryItem *pass = [NSURLQueryItem queryItemWithName:@"password" value:password];
    components.queryItems = @[user, pass];
    
    [[self.session dataTaskWithURL: components.URL
                 completionHandler:^(NSData * _Nullable data,
                                     NSURLResponse * _Nullable response,
                                     NSError * _Nullable error) {
                     NSError *jsonError;
                     id result = [NSJSONSerialization JSONObjectWithData:data
                                                                 options: kNilOptions
                                                                   error:&jsonError];
                     if (jsonError) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             completion(nil, self.loginError);
                         });
                         return;
                     }
                     if(![result isKindOfClass: NSDictionary.class]) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             completion(nil, self.loginError);
                         });
                         return;
                     }
                     NSDictionary *resultDict = (NSDictionary *)result;
                     completion(resultDict, nil);
                 }] resume];
}

- (void)employeeDataWithID:(NSString *)employeeID
                     login:(NSString *)userName
                  password:(NSString *)password
                completion:(MXEmployeeDataRequestCompletion)completion {
    
    NSURLComponents *components = [NSURLComponents componentsWithString:
                                   [baseApi stringByAppendingString: allDataEndpoint]];
    NSURLQueryItem *user  = [NSURLQueryItem queryItemWithName:@"login" value:userName];
    NSURLQueryItem *pass  = [NSURLQueryItem queryItemWithName:@"password" value:password];
    NSURLQueryItem *empID = [NSURLQueryItem queryItemWithName:@"id" value:employeeID];
    components.queryItems = @[user, pass, empID];
    
    [[self.session dataTaskWithURL: components.URL
                 completionHandler:^(NSData * _Nullable data,
                                     NSURLResponse * _Nullable response,
                                     NSError * _Nullable error) {
                     NSError *jsonError;
                     id result = [NSJSONSerialization JSONObjectWithData:data
                                                                 options: kNilOptions
                                                                   error:&jsonError];
                     if (jsonError) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             completion(nil, self.profileFetchError);
                         });
                         return;
                     }
                     if(![result isKindOfClass: NSDictionary.class]) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             completion(nil, self.profileFetchError);
                         });
                         return;
                     }
                     NSDictionary *resultDict = (NSDictionary *)result;
                     completion(resultDict, nil);
                 }] resume];
}

- (NSURL *)photoURLWithEmployeeID:(NSString *)employeeID
                            login:(NSString *)userName
                         password:(NSString *)password {
    NSURLComponents *components = [NSURLComponents componentsWithString:
                                   [baseApi stringByAppendingString: userPhotoEndpoint]];
    NSURLQueryItem *user = [NSURLQueryItem queryItemWithName:@"user" value:userName];
    NSURLQueryItem *pass = [NSURLQueryItem queryItemWithName:@"pass" value:password];
    NSURLQueryItem *empID = [NSURLQueryItem queryItemWithName:@"id" value:employeeID];
    components.queryItems = @[user, pass, empID];
    return components.URL;
}

#pragma mark - Helpers

- (NSError *)loginErrorWithMessesge:(NSString *)messege {
    if (messege == nil) {
        messege = @"Ошибка входа";
    }
    return  [NSError errorWithDomain:MXErrorDomain
                                code:MXErrorNotLoggedIn
                            userInfo: @{NSLocalizedDescriptionKey : messege }];
}

@end
