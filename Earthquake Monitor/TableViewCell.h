//
//  TableViewCell.h
//  Earthquake Monitor
//
//  Created by Daramony on 4/19/16.
//  Copyright © 2016 MobileAppsCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EQSummaryEntity.h"

@interface TableViewCell : UITableViewCell

@property (strong, nonatomic) EQSummaryEntity *eqSummaryEntity;

@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *magtitudeLabel;
@property (weak, nonatomic) IBOutlet UIView *colorView;

@end
