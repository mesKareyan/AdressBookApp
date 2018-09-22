//
//  MXEmployeeCell.m
//  AddressBook
//
//  Created by Mesrop Kareyan on 22/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import "MXEmployeeCell.h"
#import "MXCompany.h"
#import "MXDepartment.h"
#import "MXEmployee.h"

@implementation MXEmployeeCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setupWithEntity:(id<MXEntity>)entity withLevel:(NSInteger)level isExpanded:(BOOL)expanded {
    
    UIColor *selectedTextColor = [UIColor whiteColor];
    UIColor *deselectedTextColor = [UIColor blackColor];
    UIColor *deselectedColor = [UIColor colorNamed:@"deselected"];
    
    self.backgroundColor = deselectedColor;
    self.detailLabel.textColor = deselectedTextColor;
    self.titleLabel.textColor = deselectedTextColor;
    
    NSInteger numberOfChildren = [entity.children count];
    NSString *entityType;
    if ([entity isKindOfClass: MXCompany.class]) {
        entityType = @"Department";
        self.backgroundColor = [UIColor colorNamed:@"mxLightGreen"];
        self.detailLabel.textColor = selectedTextColor;
        self.titleLabel.textColor = selectedTextColor;
    } else if([entity isKindOfClass: MXDepartment.class]) {
        NSString *colorName = [NSString stringWithFormat: @"selectedLevel%ld", (long)level];
        UIColor *color = [UIColor colorNamed:colorName];
        self.backgroundColor = color != nil ? color : deselectedColor;
        MXDepartment *department = (MXDepartment *)entity;
        entityType = department.Departments == nil ? @"Employees" : @"Departments";
        self.detailLabel.textColor = selectedTextColor;
        self.titleLabel.textColor = selectedTextColor;
    }
    NSString *detailText =
    [NSString localizedStringWithFormat:@"Number of %@ %@", entityType, [@(numberOfChildren) stringValue]];
    self.titleLabel.text = entity.Name;
    self.detailLabel.text = detailText;
    
    CGFloat left = 11 + 20 * level;
    
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.x = left;
    self.titleLabel.frame = titleFrame;
    
    CGRect detailsFrame = self.detailLabel.frame;
    detailsFrame.origin.x = left;
    self.detailLabel.frame = detailsFrame;
}

@end
