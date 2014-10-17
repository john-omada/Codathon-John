//
//  ViewController.h
//  HealthyFoodFinder
//
//  Created by John Frankel on 10/17/14.
//  Copyright (c) 2014 John Frankel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *MapView;
@property (nonatomic, strong) NSManagedObjectContext* mainContext;

- (IBAction)RefreshPressed:(id)sender;



@end

