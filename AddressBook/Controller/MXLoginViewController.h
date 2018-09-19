//
//  ViewController.h
//  AdressBook
//
//  Created by Mesrop Kareyan on 18/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXRoundedButton.h"
#import "MXRoundedTextField.h"

@interface MXLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet MXRoundedButton *loginButton;
@property (weak, nonatomic) IBOutlet MXRoundedTextField *loginTextField;
@property (weak, nonatomic) IBOutlet MXRoundedTextField *passwordTextField;

@end

