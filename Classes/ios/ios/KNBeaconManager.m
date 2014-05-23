//
//  KNBeaconManager.m
//  ios
//
//  Created by Naito Kensuke on 2014/05/23.
//  Copyright (c) 2014年 kakipo. All rights reserved.
//

#import "KNBeaconManager.h"

@implementation KNBeaconManager

- (id)init {
  if (self = [super init]) {
    if ([CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]) {
      self.locationManager = [CLLocationManager new];
      self.locationManager.delegate = self;
      
      self.proximityUUID = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
      
      self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:self.proximityUUID
                                                             identifier:@"com.kakipo.demo"];
      [self.locationManager startMonitoringForRegion:self.beaconRegion];
    }
  }
  return self;
}

- (NSString *)say {
  return @"hello5";
}


#pragma mark - Delegates
- (void)locationManager:(CLLocationManager *)manager
  didStartMonitoringForRegion:(CLRegion *)region {
  [self.locationManager requestStateForRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager
      didDetermineState:(CLRegionState)state
              forRegion:(CLRegion *)region {
  
  NSString *msg;
  switch (state) {
    case CLRegionStateInside: // リージョン内にいる
      if ([region isMemberOfClass:[CLBeaconRegion class]] && [CLLocationManager isRangingAvailable]) {
        [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
      }
      msg = @"INSIDE";
      break;
    case CLRegionStateOutside:
      msg = @"OUTSIDE";
      break;
    case CLRegionStateUnknown:
      msg = @"UNKNOWN";
      break;
    default:
      break;
  }
  [self sendLocalNotificationForMessage:msg];
}

- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region {
  if ([region isMemberOfClass:[CLBeaconRegion class]]
      && [CLLocationManager isRangingAvailable]) {
    [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
  }
}


- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region {
  if (beacons.count > 0) {
    // 最も距離の近いBeaconについて処理する
    CLBeacon *nearestBeacon = beacons.firstObject;
    
    NSString *rangeMessage;
    
    // Beacon の距離でメッセージを変える
    switch (nearestBeacon.proximity) {
      case CLProximityImmediate:
        rangeMessage = @"Range Immediate: ";
        break;
      case CLProximityNear:
        rangeMessage = @"Range Near: ";
        break;
      case CLProximityFar:
        rangeMessage = @"Range Far: ";
        break;
      default:
        rangeMessage = @"Range Unknown: ";
        break;
    }
    
    // ローカル通知
    NSString *message = [NSString stringWithFormat:@"major:%@, minor:%@, accuracy:%f, rssi:%d",
                         nearestBeacon.major, nearestBeacon.minor, nearestBeacon.accuracy, nearestBeacon.rssi];
    [self sendLocalNotificationForMessage:[rangeMessage stringByAppendingString:message]];
  }
}


#pragma mark - Private methods

- (void)sendLocalNotificationForMessage:(NSString *)message {
  NSLog(@"message: %@", message);
  UILocalNotification *localNotification = [UILocalNotification new];
  localNotification.alertBody = message;
  localNotification.fireDate = [NSDate date];
  localNotification.soundName = UILocalNotificationDefaultSoundName;
  [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}


@end
