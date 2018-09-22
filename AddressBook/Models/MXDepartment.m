//
//  MXDepartment.m
//  AddressBook
//
//  Created by Mesrop Kareyan on 20/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "MXDepartment.h"
#import "MXEmployee.h"

@implementation MXDepartment

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (void)setEmployees:(NSArray *)employees {
    if ([employees isKindOfClass:NSArray.class]) {
        NSMutableArray *emplys = [NSMutableArray new];
        [employees enumerateObjectsUsingBlock:
         ^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
             MXEmployee *emp = [MXEmployee new];
             [emp setValuesForKeysWithDictionary:employees[idx]];
             [emplys addObject:emp];
         }];
        _Employees = [emplys copy];
    }
}

-(void)setDepartments:(NSArray*)departments {
    if ([departments isKindOfClass:NSArray.class]) {
        NSMutableArray *depts = [NSMutableArray new];
        [departments enumerateObjectsUsingBlock:
         ^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
             MXDepartment *dept = [MXDepartment new];
             NSDictionary *data = departments[idx];
             [dept setValuesForKeysWithDictionary: data];
             [depts addObject:dept];
         }];
        _Departments = [depts copy];
    }
}

- (NSArray *)children {
    if (self.Departments != nil) {
        return self.Departments;
    }
    return self.Employees;
}

@end
