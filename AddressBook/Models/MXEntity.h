//
//  MXEntity.h
//  AddressBook
//
//  Created by Mesrop Kareyan on 20/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXEntity : NSObject

@property (nonatomic, readonly) NSString *ID;
@property (nonatomic, readonly) NSString *Name;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new  NS_UNAVAILABLE;


@end

NS_ASSUME_NONNULL_END
