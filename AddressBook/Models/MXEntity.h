//
//  MXEntity.h
//  AddressBook
//
//  Created by Mesrop Kareyan on 20/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MXEntity <NSObject>

@property (nonatomic, readonly) NSString *ID;
@property (nonatomic, readonly) NSString *Name;
@property (nonatomic, readonly) NSArray  *children;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
