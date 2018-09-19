//
//  MXRoundedTextField.m
//  AddressBook
//
//  Created by Mesrop Kareyan on 19/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "MXRoundedTextField.h"

@implementation MXRoundedTextField

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    bounds.origin.x += 10;
    bounds.size.width -= 10;
    return bounds;
}


@end
