//
//  MXSession.h
//  AdressBook
//
//  Created by Mesrop Kareyan on 18/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXNetwork.h"

@protocol MXSessionDelegete <NSObject>

- (void)sessionDidLoggedIn;
- (void)sessionDidFailedLoginWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_BEGIN

@interface MXSession : NSObject

@property (nonatomic, readonly, nonnull) MXNetwork *network;
@property (nonatomic, weak) id<MXSessionDelegete> delegate;

- (void)login;
- (void)logout;

@end

NS_ASSUME_NONNULL_END
