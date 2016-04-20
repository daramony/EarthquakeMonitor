//
//  EarthquakeEntity.h
//  Earthquake Monitor
//
//  Created by Daramony on 4/19/16.
//  Copyright © 2016 MobileAppsCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EQSummaryEntity : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *detailURL;
@property (strong, nonatomic) NSNumber *mag;
@property (strong, nonatomic) NSString *place;
@property (strong, nonatomic) NSNumber *time;
@property (strong, nonatomic) NSNumber *updated;
@property (assign, nonatomic) double lat;
@property (assign, nonatomic) double lon;
@property (strong, nonatomic) NSNumber *depth;

@end
