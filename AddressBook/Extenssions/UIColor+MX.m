//
//  UIColor+MX.m
//  AddressBook
//
//  Created by Mesrop Kareyan on 19/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "UIColor+MX.h"

@implementation UIColor(MX)

static UIColor *_mxGreen;

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [UIColor colorWithRed:red/255.0f
                           green:green/255.0f
                            blue:blue/255.0f
                           alpha:1.0f];
}

+ (UIColor *)mxGreen {
    if (!_mxGreen) {
        _mxGreen = [UIColor colorWithRed:0 green:210 blue:64];
    }
    return _mxGreen;
}

@end
