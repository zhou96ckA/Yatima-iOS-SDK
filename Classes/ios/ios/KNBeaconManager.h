//
//  KNBeaconManager.h
//  ios
//
//  Created by Naito Kensuke on 2014/05/23.
//  Copyright (c) 2014年 kakipo. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CoreLocation/CoreLocation.h>
#include <CoreBluetooth/CoreBluetooth.h>

@interface KNBeaconManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) NSUUID *proximityUUID;
@property (nonatomic) CLBeaconRegion *beaconRegion;

- (NSString *)say;

@end
