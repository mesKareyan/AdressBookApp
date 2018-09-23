//
//  MXSplashViewController.m
//  AddressBook
//
//  Created by Mesrop Kareyan on 19/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "MXSplashViewController.h"

@interface MXSplashViewController ()
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (nonatomic) IBOutlet NSLayoutConstraint *centerConstraint;
@property (nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end

@implementation MXSplashViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.centerConstraint.active = YES;
    self.topConstraint.active = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self start];
}

#pragma mark - Animations

- (void)start {
    self.welcomeLabel.alpha = 1.0;
    [self addShineAnimationToView:self.welcomeLabel];
    self.centerConstraint.active = NO;
    self.topConstraint.active = YES;
    [UIView animateWithDuration:1 animations:^{
        self.welcomeLabel.alpha = 1.0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self performSegueWithIdentifier:@"start" sender:nil];
    }];
}

-(void)addShineAnimationToView:(UIView*)aView {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    [gradient setStartPoint:CGPointMake(0, 0)];
    [gradient setEndPoint:CGPointMake(1, 0)];
    gradient.frame = CGRectMake(0, 0, aView.bounds.size.width*3, aView.bounds.size.height);
    float lowerAlpha = 0.78;
    gradient.colors = @[
                       (id)[[UIColor colorWithWhite:1 alpha:lowerAlpha] CGColor],
                       (id)[[UIColor colorWithWhite:1 alpha:lowerAlpha] CGColor],
                       (id)[[UIColor colorWithWhite:1 alpha:1.0] CGColor],
                       (id)[[UIColor colorWithWhite:1 alpha:1.0] CGColor],
                       (id)[[UIColor colorWithWhite:1 alpha:1.0] CGColor],
                       (id)[[UIColor colorWithWhite:1 alpha:lowerAlpha] CGColor],
                       (id)[[UIColor colorWithWhite:1 alpha:lowerAlpha] CGColor],
                       ];
    gradient.locations = @[@0.0, @0.4, @0.45, @0.5, @0.55, @0.6,@1.0,];
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.duration = 1;
    animation.repeatCount = INFINITY;
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.fromValue = @(-aView.frame.size.width*2);
    animation.toValue = @0.0;
    [gradient addAnimation:animation forKey:@"animateLayer"];
    aView.layer.mask = gradient;
}

@end
