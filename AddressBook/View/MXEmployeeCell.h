//
//  MXEmployeeCell.h
//  AddressBook
//
//  Created by Mesrop Kareyan on 22/09/2018.
//  Copyright © 2018 Mesrop Kareyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXEmployeeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

- (void)setupWithEntity:(id<MXEntity>)entity withLevel:(NSInteger)level isExpanded:(BOOL) expanded;
@end

NS_ASSUME_NONNULL_END
