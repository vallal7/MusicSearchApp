//
//  Service.m
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import "Service.h"
#import "Constants.h"

@interface Service ()


@end

@implementation Service

/**
 * @name init
 * @propertyOf Service
 * @description
 * Get an instance of the shared session
 */
-(instancetype)init {
    _session = [NSURLSession sharedSession];
    return self;
}

// Handle Any app specific changes like header configuration, current service call cancelling

@end
