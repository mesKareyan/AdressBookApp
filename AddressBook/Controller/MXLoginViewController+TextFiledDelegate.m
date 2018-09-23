
//
//  MXLoginViewController+TextFiledDelegate.m
//  AddressBook
//
//  Created by Mesrop Kareyan on 19/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "MXLoginViewController+TextFiledDelegate.h"

@implementation MXLoginViewController (TextFiledDelegate)

#pragma mark - TextField Delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField {
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (self.loginTextField==textField) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    BOOL isValid = NO;
    if (textField == self.loginTextField) {
        isValid = [self validateLogin:newString password:self.passwordTextField.text];
    } else if (textField == self.passwordTextField) {
         isValid = [self validateLogin:self.loginTextField.text password:newString];
    }
    self.loginButton.mxActive = isValid;
    return YES;
}

- (BOOL)validateLogin:(NSString *)login password:(NSString *)password {
    if(![login isEqualToString: @""] &&
       ![password isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

@end
