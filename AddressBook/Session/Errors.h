//
//  Errors.h
//  AddressBook
//
//  Created by Mesrop Kareyan on 20/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#ifndef Errors_h
#define Errors_h

//Errors
FOUNDATION_EXPORT NSString *const MXErrorDomain;

//Network errors
typedef NS_ENUM(NSUInteger, MXError) {
    MXErrorNotLoggedIn,
    MXErrorWrongData,
};

FOUNDATION_EXPORT NSString *const kMXErrorNotLoggedInMessege;
FOUNDATION_EXPORT NSString *const kMXErrorWrongDataMessege;




#endif /* Errors_h */
