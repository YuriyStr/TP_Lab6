//
//  ViewController.m
//  Lab6_2
//
//  Created by Admin on 11.04.17.
//  Copyright (c) 2017 Yury Struchkou. All rights reserved.
//

#import "ViewController.h"
//#import "YQL.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController() <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *place;
@property (weak, nonatomic) IBOutlet UILabel *indicator;
@property (strong) CLLocationManager *manager;
@end

@implementation ViewController

- (IBAction)refresh:(id)sender {
    
    
    NSURL *url = [[NSURL alloc] initWithString:[@[@"https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places%20where%20text%3D%22", self.place.text, @"%22)%20and%20u%3D'c'&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"] componentsJoinedByString:@""]];
    
    NSData *contents = [[NSData alloc] initWithContentsOfURL:url];
    NSDictionary *forecasting = [NSJSONSerialization JSONObjectWithData:contents options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *currentForecast = [[[[forecasting valueForKey:@"query"] valueForKey:@"results"]valueForKey:@"channel"]valueForKey:@"item"][0];
	
	
    NSString *lowTemperature = [[currentForecast valueForKey:@"condition"] valueForKey:@"temp"];
	
    double temperature = [lowTemperature doubleValue];
    
    [self.indicator setText:[NSString stringWithFormat:@"%.1f", temperature]];
    if(temperature > 25) [[self indicator] setTextColor:[UIColor redColor]];
    else if(temperature > 5) [[self indicator] setTextColor:[UIColor orangeColor]];
    else [[self indicator] setTextColor:[UIColor blueColor]];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    //self.manager = [[CLLocationManager alloc]init];
    //self.manager.delegate = self;
    //self.manager.distanceFilter = kCLDistanceFilterNone;
    //self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    //[self.manager startUpdatingLocation];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"Hello");
    CLLocation *currentLocation = [locations lastObject];
    NSLog(@"didUpdateToLocation: %@", currentLocation);
    
    if (currentLocation != nil) {
        NSLog(@"%.8f %.8f", currentLocation.coordinate.longitude, currentLocation.coordinate.latitude);
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    BOOL shouldIAllow = FALSE;
    NSString* locationStatus = @"";
    
    switch (status) {
        case kCLAuthorizationStatusRestricted:
            locationStatus = @"Restricted Access to location";
            break;
        case kCLAuthorizationStatusDenied:
            locationStatus = @"User denied access to location";
            break;
        case kCLAuthorizationStatusNotDetermined:
            locationStatus = @"Status not determined";
        default:
            locationStatus = @"Allowed to location Access";
            shouldIAllow = TRUE;
            break;
    }
    
    if (shouldIAllow) {
        NSLog(@"Location to Allowed");
        // Start location services
        [_manager startUpdatingLocation];
    } else {
        NSLog(@"Denied access: \(locationStatus)");
    }
}

@end
