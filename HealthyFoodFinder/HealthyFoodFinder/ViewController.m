//
//  ViewController.m
//  HealthyFoodFinder
//
//  Created by John Frankel on 10/17/14.
//  Copyright (c) 2014 John Frankel. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <CoreData/NSPersistentStoreRequest.h>
#import <CoreData/CoreData.h>
#import "YelpData.h"
#import "AppDelegate.h"

#define METERS_PER_MILE 1609.344

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];

    self.mainContext = app.managedObjectContext;
    
    _MapView.showsUserLocation = YES;
    [self addDataToCore];
    [self loadAnnotationsFromCoreData];
}

//Add annotation to map
- (void)addPinToMapWithTitle:(NSString*)title andScore:(NSNumber*)score atLat:(float)lat andLon:(float)lon
{
    CLLocationCoordinate2D centerCoordinate;
    centerCoordinate.latitude = lat;
    centerCoordinate.longitude = lon;
    
    NSString * pinTitle = [NSString stringWithFormat:@"%@ | Health Score:%@",title,score.stringValue];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:centerCoordinate];
    [annotation setTitle:pinTitle]; //You can set the subtitle too
    [_MapView addAnnotation:annotation];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setLocationWithLat:37.796617 andLon:-122.403108];
}

//Sets the cameral over the users location
- (void)setLocationWithLat:(float)lat andLon:(float)lon
{
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = lat;
    zoomLocation.longitude = lon;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.4*METERS_PER_MILE, 0.4*METERS_PER_MILE);
    
    // 3
    [_MapView setRegion:viewRegion animated:YES];
}

//Puts annotations on map from data stored in coredata
- (void)loadAnnotationsFromCoreData
{
    [_MapView removeAnnotations:_MapView.annotations];
    
    //Do fetch request to CoreData
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"YelpData"];

    NSError *error;
    
    NSArray *matches = [_mainContext executeFetchRequest:request error:&error];
    if(error) {
        NSLog(@"Dailys Activity Core Data Fetch Error: %@", error);
    }

    for(YelpData *d in matches){
        [self addPinToMapWithTitle:[d restaurantName] andScore:[d healthinessScore] atLat:[d locationLat].floatValue andLon:[d locationLong].floatValue];
  
    }
}

//Get NSManaged Object context
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)addDataToCore
{
    YelpData* res = [NSEntityDescription insertNewObjectForEntityForName:@"YelpData" inManagedObjectContext:_mainContext];
    [res setLocationLat:@37.795617];
    [res setLocationLong:@-122.403108];
    [res setRestaurantName:@"Salad Works"];
    [res setHealthinessScore:@10];
    
    res = [NSEntityDescription insertNewObjectForEntityForName:@"YelpData" inManagedObjectContext:_mainContext];
    [res setLocationLat:@37.799617];
    [res setLocationLong:@-122.402108];
    [res setRestaurantName:@"Genetic Diner"];
    [res setHealthinessScore:@7];
    
    res = [NSEntityDescription insertNewObjectForEntityForName:@"YelpData" inManagedObjectContext:_mainContext];
    [res setLocationLat:@37.792617];
    [res setLocationLong:@-122.404108];
    [res setRestaurantName:@"Veggie Farm"];
    [res setHealthinessScore:@8];
    
    res = [NSEntityDescription insertNewObjectForEntityForName:@"YelpData" inManagedObjectContext:_mainContext];
    [res setLocationLat:@37.795617];
    [res setLocationLong:@-122.404108];
    [res setRestaurantName:@"Side Street Bakery"];
    [res setHealthinessScore:@8];
    
    res = [NSEntityDescription insertNewObjectForEntityForName:@"YelpData" inManagedObjectContext:_mainContext];
    [res setLocationLat:@37.797617];
    [res setLocationLong:@-122.407108];
    [res setRestaurantName:@"mixt greens"];
    [res setHealthinessScore:@8];
    
    res = [NSEntityDescription insertNewObjectForEntityForName:@"YelpData" inManagedObjectContext:_mainContext];
    [res setLocationLat:@37.792617];
    [res setLocationLong:@-122.402108];
    [res setRestaurantName:@"mixt greens"];
    [res setHealthinessScore:@8];
//
//    NSDictionary * data = nil;
//    
//    for (NSString* key in data) {
//        id value = [data objectForKey:key];
//        NSNumber *lat = (NSNumber *)[value objectForKey:@"LAT"];
//        NSNumber *lon = (NSNumber *)[value objectForKey:@"LON"];
//        NSNumber *hScore = (NSNumber *)[value objectForKey:@"HS"];
//        NSString *title = (NSString *)[value objectForKey:@"T"];
//        
//        res = [NSEntityDescription insertNewObjectForEntityForName:@"YelpData" inManagedObjectContext:_mainContext];
//        [res setLocationLat:lat];
//        [res setLocationLong:lon];
//        [res setRestaurantName:title];
//        [res setHealthinessScore:hScore];
//    }
    
}


- (IBAction)RefreshPressed:(id)sender
{
    float lat = 37.796617;//_MapView.userLocation.location.coordinate.latitude;
    float lon = -122.403108;//_MapView.userLocation.location.coordinate.longitude;
    
    [self loadAnnotationsFromCoreData];
    [self setLocationWithLat:lat andLon:lon];
}
@end
