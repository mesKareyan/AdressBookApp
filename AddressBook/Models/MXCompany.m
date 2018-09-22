//
//  MXCompany.m
//  AddressBook
//
//  Created by Mesrop Kareyan on 20/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "MXCompany.h"
#import "MXDepartment.h"

@implementation MXCompany

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (NSArray *)children {
    return self.Departments;
}

-(void)setDepartments:(NSArray*)departments
{
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


@end
