//
//  EarthquakeService.h
//  Earthquake Monitor
//
//  Created by Daramony on 4/19/16.
//  Copyright © 2016 MobileAppsCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EQSummaryEntity.h"

@interface EQService : NSObject

-(void)getFeedPastHourWithCompletion:(void(^)(NSString *title, NSMutableArray *dataList, BOOL status))complete;

//-(void)getDetailInfoWithUrl:(NSString *url) withCompletion:(void(^)())

@end
