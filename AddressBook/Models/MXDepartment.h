//
//  MXDepartment.h
//  AddressBook
//
//  Created by Mesrop Kareyan on 20/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MXEmployee;

NS_ASSUME_NONNULL_BEGIN

@interface MXDepartment : NSObject

@property (nonatomic, readonly) NSArray<MXEmployee*> *Employees;

@end

NS_ASSUME_NONNULL_END
