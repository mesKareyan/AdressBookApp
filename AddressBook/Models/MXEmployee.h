//
//  MXEmployee.h
//  AddressBook
//
//  Created by Mesrop Kareyan on 20/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXEmployee : NSObject

@property (nonatomic, readonly) NSString *Title;
@property (nonatomic, readonly) NSString *Rmail;
@property (nonatomic, readonly) NSString *Phone;

@end

NS_ASSUME_NONNULL_END
