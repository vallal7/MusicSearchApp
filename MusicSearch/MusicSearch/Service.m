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

-(instancetype)init {
    _session = [NSURLSession sharedSession];
    return self;
}

@end
