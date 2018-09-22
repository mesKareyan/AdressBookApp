//
//  MXDepartment.h
//  AddressBook
//
//  Created by Mesrop Kareyan on 20/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXEntity.h"

@class MXEmployee;

NS_ASSUME_NONNULL_BEGIN

@interface MXDepartment : NSObject<MXEntity>

@property (nonatomic, readonly) NSString *ID;
@property (nonatomic, readonly) NSString *Name;
@property (nonatomic, readonly) NSArray<MXEmployee*> *Employees;
@property (nonatomic, readonly) NSArray<MXDepartment*> *Departments;


@end

NS_ASSUME_NONNULL_END
