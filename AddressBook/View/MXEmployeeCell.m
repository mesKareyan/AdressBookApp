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

@interface MXEmployeeCell()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConstraint;


@end

@implementation MXEmployeeCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setupWithEntity:(id<MXEntity>)entity withLevel:(NSInteger)level isExpanded:(BOOL)expanded {
    
    self.preservesSuperviewLayoutMargins = NO;
    self.separatorInset = UIEdgeInsetsZero;
    self.layoutMargins = UIEdgeInsetsZero;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIColor *selectedTextColor = [UIColor whiteColor];
    UIColor *deselectedTextColor = [UIColor blackColor];
    UIColor *deselectedColor = [UIColor colorNamed:@"deselected"];
    
    self.backgroundColor = deselectedColor;
    self.detailLabel.textColor = deselectedTextColor;
    self.titleLabel.textColor = deselectedTextColor;
    NSInteger numberOfChildren = [entity.children count];
    
    self.accessoryType = UITableViewCellAccessoryNone;

    NSString *entityType;
    if ([entity isKindOfClass: MXCompany.class]) {
        entityType = NSLocalizedString(@"Departments","");
        self.backgroundColor = [UIColor colorNamed:@"mxLightGreen"];
        self.detailLabel.textColor = selectedTextColor;
        self.titleLabel.textColor = selectedTextColor;
        self.detailLabel.text =
        [NSString stringWithFormat:@"%@ - %ld", entityType, numberOfChildren];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if([entity isKindOfClass: MXDepartment.class]) {
        NSString *colorName = [NSString stringWithFormat: @"selectedLevel%ld", (long)level];
        UIColor *color = [UIColor colorNamed:colorName];
        self.backgroundColor = color != nil ? color : deselectedColor;
        MXDepartment *department = (MXDepartment *)entity;
        entityType =
        department.Departments == nil ? @"Employees" : @"Departments";
        self.detailLabel.text =
        [NSString stringWithFormat:@"%@ - %ld", NSLocalizedString(entityType, ""), numberOfChildren];
        self.detailLabel.textColor = selectedTextColor;
        self.titleLabel.textColor = selectedTextColor;
    } else if([entity isKindOfClass: MXEmployee.class]) {
        MXEmployee *emp = (MXEmployee *)entity;
        self.detailLabel.text = emp.Title;
    }
    
    self.titleLabel.text = entity.Name;
    
    CGFloat left = 11 + 20 * level;
    
    self.leadingConstraint.constant = left;
    
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.x = left;
    self.titleLabel.frame = titleFrame;
    
    CGRect detailsFrame = self.detailLabel.frame;
    detailsFrame.origin.x = left;
    self.detailLabel.frame = detailsFrame;
}

@end
