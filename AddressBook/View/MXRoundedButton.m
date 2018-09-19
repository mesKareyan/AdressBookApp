//
//  MXRoundedButton.m
//  AddressBook
//
//  Created by Mesrop Kareyan on 19/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "MXRoundedButton.h"
#import "UIColor+MX.h"

@interface MXRoundedButton()
@end


@implementation MXRoundedButton

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (void)setMxActive:(BOOL)mxActive {
    self.enabled = mxActive;
    self.backgroundColor =
    mxActive ? UIColor.mxGreen : UIColor.lightGrayColor;
}



@end
