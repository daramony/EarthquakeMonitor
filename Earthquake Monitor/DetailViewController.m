//
//  DetailViewController.m
//  Earthquake Monitor
//
//  Created by Daramony on 4/19/16.
//  Copyright © 2016 MobileAppsCompany. All rights reserved.
//

#import "DetailViewController.h"
#import <MapKit/MapKit.h>
#import "MapPin.h"

#define TITLE @"Detail"
#define FORMAT_DATE @"MM/dd/yyyy hh:mm a"
#define DEFAULT_PIN_TITLE @"Quake"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *magtitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *datetimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property (weak, nonatomic) IBOutlet UILabel *depthLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = TITLE;
    self.magtitudeLabel.text = [self.eqSummaryEntity.mag stringValue];
    NSString * timeStampString = [self.eqSummaryEntity.time stringValue];
    NSTimeInterval _interval=[timeStampString doubleValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:FORMAT_DATE];
    self.datetimeLabel.text = [dateFormatter stringFromDate:date];
    self.locationLabel.text = self.eqSummaryEntity.place;
    self.depthLabel.text = [self.eqSummaryEntity.depth stringValue];
    [self displayMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)displayMap {
    CLLocationCoordinate2D center;
    center.latitude = self.eqSummaryEntity.lat;
    center.longitude = self.eqSummaryEntity.lon;
    
    MKCoordinateSpan zoom;
    zoom.latitudeDelta = 10.0f;
    zoom.longitudeDelta = 10.0f;
    
    MKCoordinateRegion myRegion;
    myRegion.center = center;
    myRegion.span = zoom;
    
    [self.mapview setRegion:myRegion animated:YES];
    
    MapPin *mapPin = [[MapPin alloc] init];
    mapPin.title = DEFAULT_PIN_TITLE;
    mapPin.coordinate = center;
    
    [self.mapview addAnnotation:mapPin];
    
    [self.mapview selectAnnotation:mapPin animated:YES];
    [self.mapview setZoomEnabled:YES];
}

@end
