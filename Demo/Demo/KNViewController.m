//
//  KNViewController.m
//  Demo
//
//  Created by Naito Kensuke on 2014/05/23.
//  Copyright (c) 2014年 kakipo. All rights reserved.
//

#import "KNViewController.h"
#import "KNBeaconManager.h"


@interface KNViewController ()

@end

@implementation KNViewController {
  KNBeaconManager *_bm;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  _bm = [[KNBeaconManager alloc] init];
  
  NSLog(@"say: %@", [_bm say]);
  
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
