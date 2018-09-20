//
//  MXDataSerializer.h
//  AddressBook
//
//  Created by Mesrop Kareyan on 20/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXCompany.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXDataSerializer : NSObject

- (MXCompany *)companyInfoFromData:(NSDictionary *)rawData;

@end

NS_ASSUME_NONNULL_END
