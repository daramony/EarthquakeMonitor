//
//  EarthquakeService.m
//  Earthquake Monitor
//
//  Created by Daramony on 4/19/16.
//  Copyright © 2016 MobileAppsCompany. All rights reserved.
//

#import "EQService.h"

@implementation EQService

#define EarthQuakeFeedAll @"http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"
#define FEATURES @"features"
#define PROPERTIES @"properties"
#define META_TITLE @"metadata.title"
#define TITLE @"title"
#define DETAIL @"detail"
#define MAG @"mag"
#define PLACE @"place"
#define TIME @"time"
#define UPDATED @"updated"
#define GEOMETRY_COORDINATES @"geometry.coordinates"

-(void)getFeedPastHourWithCompletion:(void (^)(NSString *, NSMutableArray *, BOOL))complete {
    
    
    NSURL *url = [NSURL URLWithString:EarthQuakeFeedAll];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSError *errorJSON;
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorJSON];
            if (!errorJSON) {
                NSArray *featureList = dataDict[FEATURES];
                
                NSString *title = [dataDict valueForKeyPath:META_TITLE];
                
                NSMutableArray *resultList = [[NSMutableArray alloc] init];
                for (NSDictionary *dict in featureList) {
                    NSDictionary *propertiesDict = dict[PROPERTIES];
                    
                    EQSummaryEntity *eqSummaryEntity = [[EQSummaryEntity alloc] init];
                    
                    eqSummaryEntity.title = propertiesDict[TITLE];
                    eqSummaryEntity.detailURL = propertiesDict[DETAIL];
                    eqSummaryEntity.mag = propertiesDict[MAG];
                    eqSummaryEntity.place = propertiesDict[PLACE];
                    eqSummaryEntity.time = propertiesDict[TIME];
                    eqSummaryEntity.updated = propertiesDict[UPDATED];
                    
                    NSArray *coordinates = [dict valueForKeyPath:GEOMETRY_COORDINATES];
                    
                    if (coordinates.count >= 3) {
                        eqSummaryEntity.lon = [coordinates[0] doubleValue];
                        eqSummaryEntity.lat = [coordinates[1] doubleValue];
                        eqSummaryEntity.depth = coordinates[2];
                    }
                    
                    [resultList addObject:eqSummaryEntity];
                }
                
                if (complete) complete(title, resultList, YES);
            }else {
                if (complete) complete(nil, nil, NO);
            }
        }else {
            if (complete) complete(nil, nil, NO);
        }
    }];
    [task resume];
}

@end
