//
//  MXRoundedButton.h
//  AddressBook
//
//  Created by Mesrop Kareyan on 19/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface MXRoundedButton : UIButton

@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable BOOL mxActive;

@end

NS_ASSUME_NONNULL_END
