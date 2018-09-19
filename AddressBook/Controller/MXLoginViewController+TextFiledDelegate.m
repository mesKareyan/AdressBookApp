
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
//    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.loginButton.mxActive = [self validateUser];
    return YES;
}

- (BOOL)validateUser {
    if(![self.loginTextField.text isEqualToString: @""] &&
       ![self.passwordTextField.text isEqualToString:@""]) {
        return YES;
    }
    return NO;
}


@end
