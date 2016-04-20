//
//  EQTableViewCell.m
//  Earthquake Monitor
//
//  Created by Daramony on 4/19/16.
//  Copyright © 2016 MobileAppsCompany. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setEqSummaryEntity:(EQSummaryEntity *)eqSummaryEntity {
    _eqSummaryEntity = eqSummaryEntity;
    self.magtitudeLabel.text = [self.eqSummaryEntity.mag stringValue];
    self.placeLabel.text = self.eqSummaryEntity.place;
    self.colorView.backgroundColor = [self generateColor];
}

-(UIColor *)generateColor {
    UIColor *color;
    
    double mag = [self.eqSummaryEntity.mag doubleValue];
    
    if (mag >= 0.0 && mag <= 0.9) {
        color = [UIColor greenColor];
    }else if(mag >= 9.0 && mag <= 9.9) {
        color = [UIColor redColor];
    }else {
        color = [UIColor blueColor];
    }
    
    return color;
}

@end
