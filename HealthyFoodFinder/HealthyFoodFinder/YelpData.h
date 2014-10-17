//
//  YelpData.h
//  HealthyFoodFinder
//
//  Created by John Frankel on 10/17/14.
//  Copyright (c) 2014 John Frankel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface YelpData : NSManagedObject

@property (nonatomic, retain) NSString * restaurantName;
@property (nonatomic, retain) NSNumber * healthinessScore;
@property (nonatomic, retain) NSNumber * locationLong;
@property (nonatomic, retain) NSNumber * locationLat;

@end
