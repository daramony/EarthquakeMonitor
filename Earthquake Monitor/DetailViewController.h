//
//  DetailViewController.h
//  Earthquake Monitor
//
//  Created by Daramony on 4/19/16.
//  Copyright © 2016 MobileAppsCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EQSummaryEntity.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) EQSummaryEntity *eqSummaryEntity;

@end
