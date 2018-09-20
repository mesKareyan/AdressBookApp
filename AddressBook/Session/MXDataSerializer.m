//
//  MXDataSerializer.m
//  AddressBook
//
//  Created by Mesrop Kareyan on 20/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "MXDataSerializer.h"
#import "MXCompany.h"

@implementation MXDataSerializer

- (MXCompany *)companyInfoFromData:(NSDictionary *)rawData {
    MXCompany *comp = [[MXCompany alloc] initWithDictionary:rawData];
    return comp;
}

@end
